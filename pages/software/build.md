# Building SMACCMPilot

The source code for the SMACCMPilot project is available as open source on
Github. You'll need the source to build and use SMACCMPilot: it is not
distributed as a pre-built binary. Note that the current build requires some
specialized hardware, but you should be able to build and analyze the binaries
without it.

There are a number of repositories used in the build. You have some choices in
how to acquire those sources. The easiest is the following:

```> git clone https://github.com/smaccm/phase2/```

The `phase2` project contains scripts that downloads and builds the entire
project, including dependencies, assuming a bare Ubuntu 12.04 amd64 machine with
at least 50GB of memory. If you provision a similar (virtual) machine, these
scripts should work for you. The scripts run are located in `scripts/` and the
entry point is `main.sh`. The build is run on Travis-CI:
<https://travis-ci.org/smaccm/phase2>, and you can see the output of a
successful build there. . If you are building on a different system, use these
scripts as a guide. The first time you run the scripts, run `bootstrap.sh`
manually to install the prerequisites.

There is an experimental Vagrant build that builds a portion of the system but
not the seL4 components that could be extended (patches welcome!). See the
[development environment readme](https://github.com/GaloisInc/smaccmpilot-build/tree/master/development-environment)
for more information.

We have successfully built the software on Ubuntu, Fedora, and OSX 64-bit
machines.

The build was successful if you generated the following two images:

* `phase2\pixhawk-image`
* `phase2\odroid-image`

## Test Apps

Most libraries come with a set of test applications that exercise the
functionality of the library code.

For all test apps (including the flight app, whose only difference is that we
defined some convenient shortcut make targets), the application will build in a
directory path relative to the library root named `<platform>/<appname>/`. (The
Pixhawk platform is refered to as `platform-fmu24`.)

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

