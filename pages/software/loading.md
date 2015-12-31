# Uploading SMACCMPilot

*IMPORTANT:* These instructions assume you've completed the instructions for
[building SMACCMPilot][building], you have a complete [SMACCMPilot flight
platform][hardware].

Before you begin, determine whether you want to use the PX4 USB Bootloader, or
whether you prefer to use a JTAG programmer such as the Black Magic Probe.
Instructions for both cases are below.

[building]: build.html
[hardware]: ../hardware/airvehicle-overview.html

## PX4 USB Bootloader

The PX4 development team has written a USB bootloader for the Pixhawk and
distributes loaders for Windows, Mac, and Linux. The PX4 bootloader is flashed
to the Pixhawk at the factory. This is the easiest method of uploading new
programs to the Pixhawk and does not require hardware aside from a USB cable. By
default, SMACCMPilot binaries are built to be compatible with the PX4
bootloader.

These instructions may be augmented by the [PX4 Project wiki
page][px4wiki-upload] on the same topic.

[px4wiki-upload]: http://pixhawk.ethz.ch/px4/dev/nuttx/building_and_flashing

#### Bootloader Compatible Binaries

The PX4 bootloader uses a special `.px4` format for program binaries. The
build system will build `image.px4` binaries alongside ordinary
ELF binaries (named simply `image`). Note that the `image.px4` binary will be
linked to sit after the PX4 bootloader in flash, whereas the `image` elf will be
linked to sit at the beginning of flash.

#### Bootloader Behavior

The bootloader is active for the first 5 seconds after the Pixhawk is powered on.
When active, the bootloader will rapidly flash the red LED only. The uploader
must initiate communication with the Pixhawk while the bootloader is active.

If there is no program flashed to the Pixhawk, bootloader will stay active for as
long as the board is powered on. The SMACCMPilot application will not rapidly
flash the red LED in normal operation.

#### Uploading on the command line

For Linux and Mac users, the easiest way to upload SMACCMPilot applications to
the Pixhawk is via the `px4_upload.py` script. This script was authored by the
PX4 development team and is redistributed under the terms of their license.

The `px_upload.py` script requires Python 2.7 or greater and the [pyserial][]
package.

The upload script accepts a comma-separated list of serial ports where the
bootloader may be present. Since resetting the Pixhawk to activate the bootloader
will make a new USB serial port connection, it is sometimes helpful to give
several serial ports as an argument. For example, on Linux, you may give the
list:
`/dev/ttyACM0,/dev/ttyACM1,/dev/ttyACM2`.

To use the upload script from the command line, provide the list of serial ports
and location of the binary to upload. From the root of the `smaccmpilot-stm32f4`
repository, use the following command, filling in `LIST_OF_PORTS` as
appropriate.

```
python boot/px_uploader.py --port LIST_OF_PORTS build/px4fmu17_ioar_freertos/img/flight.px4
```

Once the uploader has recognized a valid PX4 firmware file, it will give the
message:

```
Loaded firmware for 5,0, waiting for the bootloader...
```

At this point, reset your Pixhawk board to enter the bootloader. You can do this
by pushing the reset button on the side of the board, or if there is no other
power source, unplugging and replugging the USB cable.

When the uploader recognizes the Pixhawk bootloader, it will output the following
sequence:

```
Found board 5,0 bootloader rev 3 on /dev/ttyACM1
erase...
program...
verify...
done, rebooting.
```

The first time you upload a program, the erase step may take quite some time as
the bootloader erases the entire flash memory. Subsequent erases should be
faster, because the bootloader will only erase pages which have been written to.

[uploadpy]: http://github.com/GaloisInc/smaccmpilot-stm32f4/blob/master/boot/px_uploader.py
[pyserial]: http://pyserial.sourceforge.net/

## Black Magic Probe (Debugger)

You can load your SMACCMPilot binary onto hardware with the instructions found
on the [Black Magic Probe][blackmagic] page.

[blackmagic]: ../hardware/blackmagic.html

## Flashing the Bootloader

Ordinarily, you will not have to worry about flashing the bootloader, since it
comes flashed from the factory and SMACCMPilot project binaries should not
overwrite it unless configured to and loaded via the Black Magic Probe. However,
if you have overwritten the bootloader, it is easy to replace.

The PX4 bootloader for the Pixhawk is distributed as a binary in the [`smaccmpilot-hardware-prep`
repository][blbin].

[blbin]: https://github.com/GaloisInc/smaccmpilot-hardware-prep/tree/master/fmu_bootloader

### Building the bootloader from sources

If you wish to build your own PX4 bootloader from sources, clone and build [the
PX4 project Bootloader repository](http://github.com/PX4/Bootloader).

Like other PX4 project repositories, the Bootloader expects to find a built
clone of the [libopencm3][] repository in the same parent directory.

[libopencm3]: http://github.com/PX4/libopencm3
