# SMACCMPilot demo flight

This page covers the daughterboard configuration for a demo flight. First, make sure you upload the [flight computer][standalone]

[standalone]: standalone.html

## Flash uboot

Follow instructions written [here](https://wiki.sel4.systems/Hardware/jetsontk1?highlight=%28uboot%29#Flash_U-Boot)



## Load sel4 image
Follow the instructions from [here](https://wiki.sel4.systems/Hardware/CEI_TK1_SOM).

A few notes about the uploading. For debugging it is possible to set up ftp on the GCS and dhcp file transfer on the TK1/uboot.
This is a bit of a pain to set up on the host side (hence we don't provide specific instructions), but works fine once going.

For the actual flight we use USB loading. That means we put a USB stick into the TK1 (into the blue usb port!). The USB has a file called sel4.img which contains the TK1 image. Then we have uboot configured to do a USB boot.

The uboot sequence is:

```
usb start
load usb 0:1 0x81000000 sel4.img
bootelf 0x81000000
```

**NOTE:** if your image has different name than *sel4.img* make sure to modify the command accordingly.

If that works you can save it as the default boot command with

```
setenv bootcmd "usb start; load usb 0:1 0x81000000 sel4.img; bootelf 0x81000000"
saveenv
```

The sequence for booting the actual copter is:

1. plug in USB stick
2. hit daughterboard reset button
3. count to 10 seconds
4. remove USB stick (and wait for the system to boot up)

## Load the linux filesystem

Download the linux filesystem image from Dropbox [here](https://www.dropbox.com/s/w0mao28ekccld4m/backup-tk1.tar.gz?dl=0) and unzip it.

Go into uboot and do:

```
ums mmc 0
```

This makes the EMMC available as a USB mass storage device. Then plug
into the mini-USB port on the TK1. If you connect this to your
computer you should see `/dev/sdb1` (or similar) which you can mount and
read/write. You can wipe out what's there already and replace it with
the proper filesystem. Just use the `-r` flag to cp to preserve
permissions. Run `sync` afterwatds to make sure all files got properly copied.

The files relevant for the [demo flight][demo] are under `/root` directory.

## Upload Pixy cam software

Follow the instructions from [here](../hardware/iris.html#pixycam)

## Ready to fly?

Proceed to [preflight preparations][preflight] or check out the example of [demo flight][demo].

[preflight]: preflight.html
[demo]: demo_script.html
