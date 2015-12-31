# Building SMACCMPilot

## Sources

The source code for the SMACCMPilot project is available as open source on
Github. You'll need the source to build and use SMACCMPilot: it is not
distributed as a pre-built binary.

<p><a class="btn btn-primary"
      href="http://github.com/galoisinc/smaccmpilot-build">
    SMACCMPilot-build repository &raquo;</a>
</p>

The [smaccmpilot-build][] repository contains a collection of submodules
containing all of the project sources. You can fetch these submodules when you
fetch smaccmpilot-build by performing

```sh
git clone --recursive https://github.com/galoisinc/smaccmpilot-build
```

or, if you already did a non-recursive clone, enter the `smaccmpilot-build`
directory and perform

```sh
git submodule init
git submodule update
```

[smaccmpilot-build]: http://github.com/galoisinc/smaccmpilot-build

## Development Environment

SMACCMPilot is a pretty big project with a lot of specific dependencies. To ease
development environment setup, we provide a [Vagrant][] configuration
that will automatically setup a VM, install all of the correct dependencies, and
build the SMACCMPilot flight application and project documentation.

See the [development environment
readme](https://github.com/GaloisInc/smaccmpilot-build/tree/master/development-environment) for more information.

## Flight Application

The SMACCMPilot flight application is built from the directory
`smaccmpilot-build/smaccmpilot-stm32/src/smaccm-flight` with the command `make
flight`

To upload the flight app to a Pixhawk, use the command `make upload-flight` from the
same directory. Set the `UPLOAD_PORT` environment variable to the path you
expect the Pixhawk bootloader to enumerate on, e.g.

```sh
UPLOAD_PORT=/dev/ttyACM0 make upload-flight
```

## Test Apps

Most libraries come with a set of test applications that exercise the
functionality of the library code.

For all test apps (including the flight app, whose only difference is that we
defined some convenient shortcut make targets), the application will build in a
directory path relative to the library root named `<platform>/<appname>/`. (The
Pixhawk platform is refered to internally as `platform-fmu24`.)

In the app build directory, we will build two distinct images:

* `image`: an ELF linked to start at the beginning of Flash. Suitable for
  uploading with a JTAG/SWD debugger.

* `image.px4`: a PX4 (Pixhawk project) binary image file, linked to start after
  the PX4 Bootloader in Flash. Suitable for uploading with the `px_uploader.py`
  script, which has been copied into the same directory for your convenience.

A Makefile will provide a default target to rebuild these images from the
generated C sources, in case you want to change any of the sources by hand.
There will also be a `make upload` target that will start the PX4 uploader with
the correct arguments, using the `UPLOAD_PORT` environment variable for the
bootloader's serial port path.

