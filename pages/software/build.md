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

[smaccmpilot-build]: http://github.com/galoisinc/smaccmpilot-build

## Development Environment

SMACCMPilot is a pretty big project with a lot of specific dependencies. To ease
development environment setup, we provide a [Vagrant][] configuration
that will automatically setup a VM, install all of the correct dependencies, and
build the SMACCMPilot flight application and project documentation.

See the [development environment
readme](https://github.com/GaloisInc/smaccmpilot-build/tree/master/development-environment) for more information.

## Flight Application


## Unit Tests



