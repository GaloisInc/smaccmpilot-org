# SMACCMPilot demo flight

This page covers configuration of the mission computer for a demo
flight. First, make sure you have uploaded
the [flight computer software][standalone].

[standalone]: standalone.html

You will then have to make sure that uboot is installed, that the
seL4-based mission computer is installed, and that the filesystem for
the untrusted Linux VM demo component is flashed to the eMMC storage.

## Flash uboot

Follow the instructions [here](https://wiki.sel4.systems/Hardware/jetsontk1?highlight=%28uboot%29#Flash_U-Boot)

## Load mission computer image

Follow the instructions [here](https://wiki.sel4.systems/Hardware/CEI_TK1_SOM).

A few notes about the uploading: for debugging, it is possible to set
up FTP on the GCS and DHCP file transfer on the TK1/uboot.  This is a
bit of a pain to set up on the host side (hence we don't provide
specific instructions), but works fine once going.

For the actual flight we use USB loading. That means we put a USB
stick into the TK1's *blue* usb port. The USB stick has a file
called `sel4.img` which contains the TK1 image. Then we have uboot
configured to do a USB boot.

The uboot sequence is:

```
usb start
load usb 0:1 0x81000000 sel4.img
bootelf 0x81000000
```

**NOTE:** if your image has a different name than `sel4.img`, make
sure to modify the command accordingly.

If that works, you can save it as the default boot command with

```
setenv bootcmd "usb start; load usb 0:1 0x81000000 sel4.img; bootelf 0x81000000"
saveenv
```

To boot the actual vehicle:

1. Plug in the USB stick
2. Press the daughterboard reset button
3. Count to 10 seconds
4. Remove the USB stick, and wait for the rest of the system to boot

## Load the Linux filesystem

Download the Linux filesystem image from Dropbox [here](https://www.dropbox.com/s/w0mao28ekccld4m/backup-tk1.tar.gz?dl=0) and unzip it.

Go into uboot and do:

```
ums mmc 0
```

This makes the eMMC storage available as a USB mass storage
device. Then connect the mini-USB port on the TK1 to your
computer. You should see a new drive, such as `/dev/sdb1`, which you
can mount and read/write. You can wipe out what's there already and
replace it with the proper downloaded. Make sure to use the `-r` flag
to `cp` to preserve permissions. Run `sync` afterwatds to make sure
all files got properly copied.

The files relevant for the [demo flight][demo] are under `/root` directory.

## Upload Pixy cam software

Follow the instructions [here](../hardware/iris.html#pixycam).

## Ready to fly?

Proceed to [preflight preparations][preflight] or check out the example of [demo flight][demo].

[preflight]: preflight.html
[demo]: demo_script.html
