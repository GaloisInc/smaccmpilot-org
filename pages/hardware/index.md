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



## Quadcopter Flight Platforms

The SMACCMPilot project supports quadcopter the
[Iris+][], although it could be easily ported
to support other Pixhawk-based plaftforms.

At this time, platforms with more than 4 motors are not supported. All motors
must be PWM based, and use the first 4 channels connected to the PX4IO
coprocessor.

## Flight Configurations

SMACCMPilot can be used in two different configurations: *Stand-alone flight* and *Demo flight*

### Stand-alone Flight

*Stand-alone* flight uses the stock [Iris+][] with added [lidar][] and [PX4Flow camera][px4_flow]. You will also need the **required accessories** described below. Stand-alone flight uses only the flight controller and is a great way how to get started with SMACCMPilot.

Follow the [mounting instructions][lidar_mount] to get your stand-alone hardware ready.

![Iris+ ready for a stand-alone flight](/images/iris_standalone.jpeg)


### Demo flight

*Demo flight* on the other hand requires additional hardware (besides what is needed for stand-alone flight), such as [Pixy cam][pixycam] and [TK-1][tk1] with a [daughterboad][tk1daughter].
This configuration simulates sophisticated UAVs with mission computer, surveillance camera and as a result a large attack surface for potential hackers.

[Attach the Pixy cam][pixycam_mount] and [mount TK-1 with daughterboard][tk1_mount] and you are good to go.

![Iris+ with TK-1 and daughterboard](/images/IMG_1230.jpg)

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


[Iris+]: https://store.3dr.com/products/iris
[Pixhawk]: http://pixhawk.org
[lidar]: iris.html#lidar
[px4_flow]: iris.html#px4flow
[lidar_mount]: lidar_and_sonar_mounting.html
[pixycam]: iris.html#pixycam
[tk1]: iris.html#tk1
[tk1daughter]: iris.html#daughterboard
[pixycam_mount]: pixycam.html
[tk1_mount]: tk1_daughterboard.html
