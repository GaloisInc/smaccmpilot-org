<a name="top"></a>

# Iris+ modification

SMACCMPilot requires some modifications to the stock Iris+ before it can be used for a stabilized indoor flight.

## Parts
Depending on your application (stand-alone vs. full demo flight) you will need the following parts:


### Stand-alone flight:

* [Lidar][lidar]
* [PX4Flow camera](#px4flow)


### Demo flight:

All **Stand-alone flight** parts plus:

* [Pixy cam](#pixycam)
* [TK1 module](#tk1)
* [TK1 daughterboard](#daughterboard)
* [Wifi USB dongle](#wifi)
* [USB Hub](#usbhub)
* [Connectors](#connectors)
* [Tupperware](#tupperware)

### Optional:

If your quadcopter is not holding heading properly, you will need:
  
* [External compass](#compass)

<a name="lidar"></a>

### LIDAR-Lite v3

Available [here](https://www.sparkfun.com/products/14032).

<img src="/images/lidar.jpg" alt="Lidar Lite" style="width: 400px;"/>

Lidar uses a laser beam to precisely measure distance, and we use it
to measure the quadcopter's altitude. No firmware update is required
as the lidar ships *ready-to-go*.

Mounting instructions are [here](lidar_and_sonar_mounting.html).

<a name="px4flow"></a>

### PX4Flow camera
Available [here](http://www.getfpv.com/holybro-px4flow-kit-v1-31.html).

<img src="/images/px4flow.jpg" alt="PX4Flow" style="width: 400px;"/>

PX4Flow contains a camera and a STM32F4xx microcontroller that
calculates optical flow measured in the camera image. The module also
contains a gyro, so the flow can be derotated and a sonar for range
measurements, so the flow can be measured in absolute units.

SMACCMpilot uses PX4Flow sonar measurements as another input to our
altitude estimator, because we want to have redundancy in case one
sensor fails. SMACCMpilot doesn't use the optical flow information at
the moment, because there is no postion stabilized mode, but it is one
of the possible extensions.

**NOTE:** no firmware update should be needed, although we noticed that some versions of the PX4Flow ship with firmware that is different than [latest stable master][flow_fw]. Generally you shouldn't need to update the firmware, but in case you experience problems, have a look at the [wiki page][flow_wiki].

[flow_fw]: https://github.com/PX4/Flow 
[flow_wiki]: https://dev.px4.io/en/optical-flow.html

Mounting instructions are [here](lidar_and_sonar_mounting.html).

<a name="pixycam"></a>

### Pixy Cam
Available [here](https://www.amazon.com/gp/product/B00IUYUA80/).

<img src="/images/pixycam.jpg" alt="Pixy cam" style="width: 400px;"/>

Pixy Cam is optional because it requires using a TK1 as a mission
computer. The Pixy cam needs a special firmware:
upload
[firmware-1.0.2beta.hex](https://github.com/smaccm/camera_demo/blob/master/notes/firmware-1.0.2beta.hex) using
the [PixyMon](https://github.com/charmedlabs/pixy) app. The camera
recognizes targets of a specified color, and can be trained to any color
by pressing the button while connected to power.

Mounting instructions are [here](pixycam_mount.html).

<a name="tk1"></a>

### TK1-SOM Module
Available [here](https://coloradoengineering.com/standard-products/tk1-som-8gb/).

<img src="/images/tk1som.png" alt="TK1-SOM" style="width: 400px;"/>

The TK1 serves as a mission computer during the flight, providing
communication between GCS and the autopilot, and other high-level
functions such as capturing and transmitting video signal from the
onboard camera. It runs [seL4](http://sel4.systems/) and a Linux
virtual machine. The TK1 is necessary for a full demo flight.

Mounting instructions are [here](tk1_daughterboard.html).

<a name="daughterboard"></a>

### TK1 Daughterboard

The TK1 daughterboard was developed by [Data61][] and provides CAN,
PWM, power management, and more. More info can be
found [here][daughterboard], and the source files are available
on
[bitbucket](https://bitbucket.csiro.au/login?next=/projects/OH/repos/tk1som-quadcopter-daughterboard/browse).

<img src="/images/daughterboard.jpg" alt="TK1 daughterboard" style="width: 700px;"/>

This daughterboard cannot be directly purchased at the moment, but the
source files are available so it can be replicated if needed.

Mounting instructions are [here](tk1_daughterboard.html).

[daughterboard]: https://wiki.sel4.systems/Hardware/CEI_TK1_SOM/Daughter-Board
[Data61]: https://data61.csiro.au/



<a name="wifi"></a>

### WiFi dongle

Available [here][usbhub_buy]

<img src="/images/wifidongle.jpg" alt="Wifi dongle" style="width:200px"/>

The WiFi dongle is necessary to provide wireless connectivity to the
TK1. It is possible to use a different WiFi dongle, but we had good
results with
the
[TP-Link N150 Wireless High Gain USB Adapter (TL-WN722N)][wifi_buy]. The
dongle plugs into the [USB hub][usbhub].

[wifi_buy]: https://www.amazon.com/TP-Link-N150-Wireless-Adapter-TL-WN722N/dp/B002SZEOLG

Mounting instructions [here](tk1_daughterboard.html).

<a name="usbhub"></a>

### USB hub

Available [here][usbhub_buy].

<img src="/images/usbhub.jpg" alt="USB Hub" style="width:400px"/>

The USB hub goes on top of the TK1 and is necessary for connecting
the [WiFi dongle][wifi] and the [Pixy cam][pixycam], because the TK1
doesn't have enough USB ports. You should be able to use a different USB
hub, but we have tested with the [Anker 4-Port USB 3.0 Ultra Slim Data Hub][usbhub_buy].

[usbhub_buy]: https://www.amazon.com/Anker-4-Port-Ultra-Drives-Devices/dp/B00XMD7KPU

Mounting instructions are [here](tk1_daughterboard.html).

<a name="connectors"></a>

### Connectors

<img src="/images/connectors.jpg" alt="Connectors" style="width:400px"/>

A handful of connectors (we recommend shopping on [eBay](http://www.ebay.com/itm/8pcs-20cm-DF13-4-5-6-Position-Connector-For-APM-2-6-2-52-Flight-Control-Cable/), as you can buy them very inexpensively)

<a name="tupperware"></a>

### Tupperware

<img src="/images/tupperware.jpg" alt="Tupperware" style="width:400px"/>

Best obtained from your local store; the size that works best is *6" x
4" x 2"* (L x W x H). The tupperware contains and protects the
sensitive electronics of the mission computer.

<a name="compass"></a>

### External compass

Available on [eBay](http://www.ebay.com/itm/3DR-Ublox-GPS-Drone-Unit-RC-Radio-Control-Telemetry-System-With-Mount-/371919662461?hash=item569823ad7d:g:iswAAOSwWxNYr2Wu) (search for *"3DR Compass"*).

<img src="/images/compass.jpg" alt="External compass" style="width: 400px;"/> 

In case of intereference, the heading estimate might not be good even
after [magnetometer calibration](calibration.html). In this case, you
can try using the external compass. This compass is identical to the
one hidden in the top cover of Iris+, but it comes on a stand-off so it
can be mounted further away from interference.

**NOTE:** The unit is powered from the GPS connector, so even though
SMACCMPilot doesn't use GPS, you either have to connect both the GPS and
I2C cables (follow the
instructions
[here](http://ardupilot.org/copter/docs/common-installing-3dr-ublox-gps-compass-module.html))
or solder the I2C VCC to GPS VCC on the compass side.

[lidar]: #lidar
[wifi]: #wifi
[pixycam]: #pixycam
[compass]: #compass
[px4flow]: #px4flow
[usbhub]: #usbhub
[connectors]: #connectors
[tupperware]: #tupperware
