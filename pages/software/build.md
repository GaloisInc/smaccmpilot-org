# Building SMACCMPilot

The source code for the SMACCMPilot project is available as open source on
GitHub. You'll need the source to build and use SMACCMPilot: it is not
distributed as a pre-built binary. Note running the software requires some
specialized hardware, but you should be able to build and analyze the binaries
without it.

We have successfully built the flight computer software on 64-bit
Ubuntu, Fedora, and MacOS, and the mission computer software on 64-bit
Ubuntu and Fedora.

## Building flight and mission computer software

There are a number of repositories used in the build. You have some choices in
how to acquire those sources. The easiest is the following:

```$ git clone https://github.com/smaccm/phase3/```

The `phase3` project contains scripts that download and build the
entire project, including dependencies, assuming a bare Ubuntu 12.04
amd64 machine with at least 50GB of disk space. If you provision a
similar (virtual) machine, these scripts should work for you:

```
$ cd phase3/scripts
$ ./main.sh
```

The build is run on [Travis-CI](https://travis-ci.org/smaccm/phase3),
and you can see the output of a successful build there.

If you are building on a different system, you can use these scripts
as a guide to determine how to set up your development environment.

After a successful build, you will have the following two images:

* `phase3/pixhawk-image`
* `phase3/tk1-image`

And you should see output like this:

```
...
 [STAGE] gen_boot_image.sh
[elfloader] done.
[GEN_IMAGE] capdl-loader-experimental-image-arm-tk1
************************************************************
Pixhawk image: /smaccmpilot-build/phase3/pixhawk-image.px4
TK1 image: /smaccmpilot-build/phase3/tk1-image
************************************************************
```

## Building flight computer software only

Building the flight computer only can reduce the number of
dependencies required for the build, and also makes it possible to
build on MacOS. We still recommend using the scripts in the `phase3`
repo as a guide for determining which dependencies to install,
particularly those packages listed
in
[`scripts/travis.sh`](https://github.com/smaccm/phase3/blob/master/scripts/travis.sh).

```
$ git clone https://github.com/GaloisInc/smaccmpilot-build.git
$ git submodule update --init
$ make -C smaccmpilot-stm32f4/src/smaccm-flight flight_echronos
```

There is an experimental Vagrant build that builds a portion of the
system, but not the optional seL4-based mission computer software. See
the
[development environment README](https://github.com/GaloisInc/smaccmpilot-build/tree/master/development-environment) for
more information.

Upon a successful build, flight computer images will be in
`smaccmpilot-stm32f4/src/smaccm-flight/platform-fmu24/standalone-flight`.

## Images and test apps

Most libraries come with a set of test applications that exercise the
functionality of the library code.

For all test apps (including the flight control software itself), the
application will build in a directory path relative to the library
root named `<platform>/<appname>/`. The Pixhawk platform is referred
to as `platform-fmu24`.

In the app build directory, we build two different images:

* `image`: an ELF linked to start at the beginning of flash
  memory. Suitable for uploading with a JTAG/SWD debugger.

* `image.px4`: a PX4 (Pixhawk project) binary image file, linked to
  start after the PX4 Bootloader in flash. Suitable for uploading with
  the `px_uploader.py` script, which has been copied into the same
  directory for your convenience.

A Makefile in the generated code will provide a default target to
rebuild these images from the generated C sources, in case you want to
change any of the sources by hand.  There is also a `make upload`
target that will start the PX4 uploader with the correct arguments,
using the `UPLOAD_PORT` environment variable for the bootloader's
serial port path, for example:

```
$ make UPLOAD_PORT=/dev/tty.usbmodem1 -C smaccmpilot-stm32f4/src/smaccm-flight upload-flight
```

For more detail, see the flight
computer [upload instructions](standalone.html).

## Troubleshooting

### eChronos

In order to successfully build `eChronos` image, you need *GCC 4.9* -
this version of the compiler is automatically installed when you run
`bootstrap.sh`, but in case you have a newer GCC version already
installed and don't want to remove it, append your `~/.bashrc` with:

```
# ARM_PATH for smaccm-echronos build (has to have "/" at the end)
export ARM_PATH="/ABSOLUTE_PATH_HERE/phase3/scripts/smaccmcopter-ph2-build/gcc-arm-embedded/gcc-arm-none-eabi-4_9-2015q2/bin/"
```
where `ARM_PATH` is absolute path to GCC 4.9

### FreeRTOS

While eChronos is the preferred backend for the flight computer, can
compile SMACCMPilot to run on FreeRTOS instead. Replace
`flight_echronos` with `flight` in the Make command above.

### Stack

We have found that Stack sometimes doesn't clean and rebuild the right
Haskell dependencies after switching branches or making major code
changes. This can lead to compilation errors. If you run into a
compilation error, try running `stack clean; make clean`, and then
attempt the build once again.
