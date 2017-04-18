<a name="top"></a>

# Iris modification

Smaccmpilot requires some modifications to the stock Iris+ before it can be used for a stabilized indoor flight.




## Parts
Depending on your application (stand alone vs. full demo flight) you will need the following parts:


### Stand-alone flight:

* [Lidar][lidar]
* <a href="#px4flow">PX4Flow camera</a>
* <a href="#pixycam">Pixy cam</a>


### Demo flight:

All **Stand-alone flight** parts plus:

* <a href="#tk1">TK-1 mission computer</a>
* <a href="#wifi">Wifi USB dongle</a>
* <a href="#usbhub">USB Hub</a>
* <a href="#connectors">Connectors</a>
* <a href="#tupperware">Tupperware</a>


### Optional:

If your quadcopter is not holding heading properly, you will need:
  
* <a href="#compass">external compass</a>




<a name="lidar"></a>

### Lidar Lite v3

Available [here](https://www.sparkfun.com/products/14032) 

<img src="/images/lidar.jpg" alt="Lidar Lite" style="width: 400px;"/>

Lidar uses a laser beam to precisely measure distance, and we are using to measure the quadcopter's altitude. No firmware update is required as the lidar ships *ready-to-go*.

Mounting instructions [here](lidar_and_sonar_mounting.html).

Back to the <a href="#top">top</a>.




<a name="px4flow"></a>

### PX4Flow camera
Available [here](http://www.getfpv.com/holybro-px4flow-kit-v1-31.html) 

<img src="/images/px4flow.jpg" alt="PX4Flow" style="width: 400px;"/>

PX4Flow contains a camera and a STM32F4xx microcontroller that calculates optical flow measured in the camera image. The module also contains a gyro, so the flow can be derotated and a sonar for range measurements, so the flow can be measured in absolute units.

Smaccmpilot uses PX4Flow sonar measurements as another inputs to our altitude estimator, because we want to have redundancy in case one sensor fails. Smaccmpilot doesn't use the optical flow information at the moment, because there is no postion stabilized mode, but it is one of the possible extensions.

**NOTE:** no firmware update should be needed, although we noticed that some versions of the PX4Flow ship with firmware that is different than [latest stable master][flow_fw]. Generally you shouldn't need to update the firmware, but in case you experience problems, have a look at the [wiki page][flow_wiki].

[flow_fw]: https://github.com/PX4/Flow 
[flow_wiki]: https://dev.px4.io/en/optical-flow.html

Mounting instructions [here](lidar_and_sonar_mounting.html).

Back to the <a href="#top">top</a>.





<a name="pixycam"></a>

### Pixy Cam
Available [here](https://www.amazon.com/gp/product/B00IUYUA80/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B00IUYUA80&linkCode=as2&tag=charlabs-20&linkId=PCETJT7ODDHGMNC7) 

<img src="/images/pixycam.jpg" alt="Pixy cam" style="width: 400px;"/>

Pixy Cam is optional because it requires using a TK1 as a mission computer.  The Pixy cam needs a special firmware - upload [firmware-1.0.2beta.hex](https://github.com/smaccm/camera_demo/blob/master/notes/firmware-1.0.2beta.hex) using [PixyMon](https://github.com/charmedlabs/pixy) app. The camera recognizes targets of specified color, and can be trained to any color by pressing the button while connected to power. 

Mounting instructions [here](pixycam_mount.html).

Back to the <a href="#top">top</a>.






<a name="tk1"></a>

### TK-1-SOM Module
Available [here](https://coloradoengineering.com/standard-products/tk1-som-8gb/)

<img src="/images/tk1som.png" alt="TK-1 SOM" style="width: 400px;"/>

TK-1 serves as a mission computer during the flight, providing communication between GCS and the autopilot, and other high-level functions, sucha as capturing and transmitting video signal from the onboard camera. It runs [sel4](http://sel4.systems/) and a Linux Virtual Machine. TK-1 is necessary for a full demo flight.

Mounting instructions [here](tk1_daughterboard.html).

Back to the <a href="#top">top</a>.



<a name="daughterboard"></a>

### TK-1 Daughterboard

The TK-1 daughterboard was developed by [Data61][] and provides CAN, PWM, power management etc. More info can be found [here][daughterboard].

<img src="/images/daughterboard.jpg" alt="TK-1 daughterboard" style="width: 700px;"/>

This daughterboard cannot be directly purchases at the moment, but the source files are available so it can be replicaed if needed.

Mounting instructions [here](tk1_daughterboard.html).

Back to the <a href="#top">top</a>.

[daughterboard]: https://wiki.sel4.systems/Hardware/CEI_TK1_SOM/Daughter-Board
[Data61]: https://data61.csiro.au/



<a name="wifi"></a>

### Wifi dongle

Available [here][usbhub_buy]

<img src="/images/wifidongle.jpg" alt="Wifi dongle" style="width:200px"/>

Wifi dongle is necessary because TK-1 doesn't have a wireless connectivity on its own. It is possible to use a different Wifi dongle, we had good results with [TP-Link N150 Wireless High Gain USB Adapter (TL-WN722N)][wifi_buy]. The Wifi plugs into the [USB hub][usbhub].

[wifi_buy]: https://www.amazon.com/Anker-4-Port-Ultra-Drives-Devices/dp/B00XMD7KPU?SubscriptionId=AKIAILSHYYTFIVPWUY6Q&tag=duckduckgo-d-20&linkCode=xm2&camp=2025&creative=165953&creativeASIN=B00XMD7KPU

Mounting instructions [here](tk1_daughterboard.html).

Back to the <a href="#top">top</a>.





<a name="usbhub"></a>

### USB hub

Available [here][usbhub_buy]

<img src="/images/usbhub.jpg" alt="USB Hub" style="width:400px"/>

USB Hub goes to the top of the TK1 and is necessary for connecting the [Wifi dongle][wifi] and the [Pixy cam][pixycam], because the TK-1 doesn't have enought USB ports. Indeed you can use a different USB Hub, we tested [Anker 4-Port USB 3.0 Ultra Slim Data Hub][usbhub_buy].

[usbhub_buy]: https://www.amazon.com/Anker-4-Port-Ultra-Drives-Devices/dp/B00XMD7KPU?SubscriptionId=AKIAILSHYYTFIVPWUY6Q&tag=duckduckgo-d-20&linkCode=xm2&camp=2025&creative=165953&creativeASIN=B00XMD7KPU

Mounting instructions [here](tk1_daughterboard.html).

Back to the <a href="#top">top</a>.



<a name="connectors"></a>

### Connectors

<img src="/images/connectors.jpg" alt="Connectors" style="width:400px"/>

A handful of connectors (I recommend shopping on [ebay](http://www.ebay.com/itm/8pcs-20cm-DF13-4-5-6-Position-Connector-For-APM-2-6-2-52-Flight-Control-Cable/191478493790?_trksid=p2141725.c100337.m3725&_trkparms=aid%3D777000%26algo%3DABA.MBE%26ao%3D1%26asc%3D20141212152338%26meid%3D51f52eb877c74101a26785e8d6d95767%26pid%3D100337%26rk%3D1%26rkt%3D1%26sd%3D231883755717) as you can buy them dirt cheap)


Back to the <a href="#top">top</a>.




<a name="tupperware"></a>

### Tupperware

<img src="/images/tupperware.jpg" alt="Tupperware" style="width:400px"/>

Best obtained from your local store - the size that works best is *6" x 4" x 2"* (L x W x H). The tupperware contains and protects the sensitive electronics of the mission computer.

Back to the <a href="#top">top</a>.




<a name="compass"></a>

### External compass

Available on [ebay](http://www.ebay.com/itm/3DR-Ublox-GPS-Drone-Unit-RC-Radio-Control-Telemetry-System-With-Mount-/371919662461?hash=item569823ad7d:g:iswAAOSwWxNYr2Wu) (search for *"3DR Compass"*).

<img src="/images/compass.jpg" alt="External compass" style="width: 400px;"/> 

In case you experience lot of intereference and the heading estimate is not good even after [magnetometer calibration](calibration.html) it might be a good idea to try to use external compass. This compass is identical to the one hidden in the top cover of Iris, but it comes on a stand-off so it can be mounted further away from interference. 

**NOTE:** The unit is powered from GPS connector, so even though Smaccmpilot doesn't use GPS, you either have to connect both GPS and I2C cables (follow the instructions [here](http://ardupilot.org/copter/docs/common-installing-3dr-ublox-gps-compass-module.html)) or solder the I2C VCC to GPS VCC on the compass side.

Back to the <a href="#top">top</a>.


[lidar]: #lidar
[wifi]: #wifi
[pixycam]: #pixycam
[compass]: #compass
[px4flow]: #px4flow
[usbhub]: #usbhub
[connectors]: #connectors
[tupperware]: #tupperware
