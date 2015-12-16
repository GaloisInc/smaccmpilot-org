# Hardware Overview

This page will describe the basic components needed to build a hardware platform
for SMACCMPilot.

## Flight Controller

![](/images/pixhawk-logo-view.jpg)

The SMACCMPilot project uses the [Pixhawk][] autopilot hardware. The official
Pixhawk project website has information on this hardware and where it may be
purchased.

[Pixhawk]: http://pixhawk.org

## Quadcopter Flight Platforms

The SMACCMPilot project supports quadcopter platforms built around the Pixhawk.
Commercial models supported include the now-discontinued 3DR Iris. Please see
the [Pixhawk project site][Pixhawk] for instructions on how to set up a
quadcopter with a Pixhawk flight controller.

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

SMACCMPilot is capable of autonomous and GCS guided flight, but requires a
hobby radio controller for safety. See our [hobby radio controller][rc] page for
information on what kind of system you need, and how to set it up.

[rc]: rc-controller.html

### JTAG/SWD Debugger

Developers may want to use a JTAG/SWD debugger for inspecting programs as they
run on the Pixhawk. We recommend the [Black Magic Probe](blackmagic.html), but
various other products will work with the STM32F4 microcontroller as well.

## Hardware Preparation

We provide a set of steps to configure your hardware for the SMACCMPilot
project in the [smaccmpilot-hardware-prep][] repository. Clone this repository
and follow the steps in the `README` documents.

[smaccmpilot-hardware-prep]: https://github.com/galoisinc/smaccmpilot-hardware-prep



