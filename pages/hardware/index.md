# Hardware Overview

This page will describe the basic components needed to build a hardware platform
for SMACCMPilot. There are two main components in SMACCMPilot: the **mission
computer** and the **flight controller**. The mission computer manages
networking with the ground control station (GCS) and hosting high-level
applications (e.g., a webcam running on Linux). The flight controller executes
the core flight functionality (e.g. stabilization and motor control).

## Flight Controller

![](/images/pixhawk-logo-view.jpg)

The SMACCMPilot project uses the [Pixhawk][] autopilot hardware. The official
Pixhawk project website has information on this hardware and where it may be
purchased.

### Hardware Preparation

We provide a set of steps to configure your hardware for the SMACCMPilot project
in the [smaccmpilot-hardware-prep][] repository. Clone this repository and
follow the steps in the `README` documents. This only needs to be done once even
if you modify the flight controller software later.

[smaccmpilot-hardware-prep]: https://github.com/galoisinc/smaccmpilot-hardware-prep

## Mission Controller

### TK-1-SOM

**TODO**

### ODROID (deprecated)

The mission controller includes a Hardkernel
[ODROID-XU](http://www.hardkernel.com/main/products/prdt_info.php?g_code=G137510300620)
(discontinued) development board with a custom daughter board developed by NICTA.

#### Linux Filesystem

Assuming you have connected and wired the ODROID and daughter board, prepare a Linux filesystem on a micro SD card. Download [the image](https://www.dropbox.com/s/hkduec0ezi7i2ux/smaccm_demo.img.gz?dl=0) then

```
> gunzip -c smaccm_demo.img.gz | dd of=<device file; sync
```

Mount the 1st partition and modify `boot.ini` by removing `run verify`. Plug the
SD card into the ODORID.

#### Wiring

![](/images/odroid-daughter-wiring.jpg)

Connect the ODROID daughter board to the 3DR radio (or optionally an FTDI cable
 during testing).


* The Pixhawk and ODROID daughter board talk over CAN; wire them together.


## Quadcopter Flight Platforms

The SMACCMPilot project supports quadcopter the
[Iris+](https://store.3dr.com/products/iris), although it could be easily ported
to support other Pixhawk-based plaftforms.

At this time, platforms with more than 4 motors are not supported. All motors
must be PWM based, and use the first 4 channels connected to the PX4IO
coprocessor.

## Required Accessories

### Telemetry Modems

SMACCMPilot needs to communicate with a ground control station (GCS) to operate.

You'll need a pair of [3DR Radio][3drradio] radio modems for bidirectional
communication between the air vehicle and GCS software running on your PC.

See the [3DR Radio setup][3drradio-setup] page for information on how to setup
and configure 3DR Radios for use with SMACCMPilot.

[3drradio]: http://store.3drobotics.com/products/3dr-radio-telemetry-kit-915-mhz
[3drradio-setup]: ../software/gcs-smaccm-sik.html

### RC Controller

SMACCMPilot requires a hobby radio controller for safety. See our
[hobby radio controller][rc] page for information on what kind of system you
need, and how to set it up.

[rc]: rc-controller.html

### JTAG/SWD Debugger (Optional)

Developers may want to use a JTAG/SWD debugger for inspecting programs as they
run on the Pixhawk. We recommend the [Black Magic Probe](blackmagic.html), but
various other products will work with the STM32F4 microcontroller as well.



[Pixhawk]: http://pixhawk.org
