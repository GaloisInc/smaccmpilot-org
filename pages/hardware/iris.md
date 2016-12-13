# Iris modification

Here we describe how to modify your Iris with additional sensors so it can be used for a stabilized indoor flight.

This page will describe the basic components needed to build a hardware platform
for SMACCMPilot. There are two main components in SMACCMPilot: the **mission
computer** and the **flight controller**. The mission computer manages
networking with the ground control station (GCS) and hosting high-level
applications (e.g., a webcam running on Linux). The flight controller executes
the core flight functionality.

## Parts
You will need these parts: 

* Lidar Lite v3 - available [here](https://www.sparkfun.com/products/14032) <img src="/images/lidar.jpg" alt="Lidar Lite" style="width: 200px;"/>
* PX4FLOW camera - available [here](http://www.getfpv.com/holybro-px4flow-kit-v1-31.html) <img src="/images/px4flow.jpg" alt="PX4Flow" style="width: 200px;"/>
* and a handful of connectors (I recommend shopping on [ebay](http://www.ebay.com/itm/8pcs-20cm-DF13-4-5-6-Position-Connector-For-APM-2-6-2-52-Flight-Control-Cable/191478493790?_trksid=p2141725.c100337.m3725&_trkparms=aid%3D777000%26algo%3DABA.MBE%26ao%3D1%26asc%3D20141212152338%26meid%3D51f52eb877c74101a26785e8d6d95767%26pid%3D100337%26rk%3D1%26rkt%3D1%26sd%3D231883755717) as you can buy them dirt cheap)

Lidar (essentially a laser range finder) provides precise altitude measurements, while PX4FLOW uses a small camera and a dedicated STM32F4 chip to provide optical flow measurements. Lidar is used primarily for keeping altitude, while PX4FLOW is used for position hold (Iris stays in one spot). PX4Flow has also a sonar which provides its own altitude measurements.

## Mounting
To mount these parts on the frame you will need:

* A drill with a set of common drill bits (2-4 mm diameter)
* A soldering station with a nice [third-hand](https://www.amazon.com/Hobby-Creek-Helping-Hands-Soldering/dp/B010C504NK%3FSubscriptionId%3DAKIAILSHYYTFIVPWUY6Q%26tag%3Dduckduckgo-d-20%26linkCode%3Dxm2%26camp%3D2025%26creative%3D165953%26creativeASIN%3DB010C504NK) and some [heatshrink](https://www.amazon.com/URBEST-530-Pcs-Shrink-Sleeving/dp/B01M8OQ2RZ/ref=sr_1_3?ie=UTF8&qid=1481670660&sr=8-3&keywords=heat+shrink)
* M3x10 button socket head cap screws (same ones are already used on Iris) - available for example from [here](http://www.screwsandmore.de/en/HEXAGON-SOCKET-SCREWS/Button-head-ISO-7380/ISO-7380-stainless-steel-A2/ISO-7380-A2-M3/ISO-7380-A2-M3X10/)
* M3x0.5 hex nuts, available [here](https://www.walmart.com/ip/100pcs-Metric-M3x0.5mm-Nylon-Hexagon-Fastener-Hex-Full-Nuts-White/48414138?wmlspartner=wlpa&selectedSellerId=571&adid=22222222227035899815&wl0=&wl1=g&wl2=c&wl3=76434503434&wl4=pla-177519399394&wl5=9061078&wl6=&wl7=&wl8=&wl9=pla&wl10=111838760&wl11=online&wl12=48414138&wl13=&veh=sem)
* [electrifcal](https://www.amazon.com/Electrical-Tape-several-colors-Black/dp/B003ZWN5ZM%3Fpsc%3D1%26SubscriptionId%3DAKIAILSHYYTFIVPWUY6Q%26tag%3Dduckduckgo-d-20%26linkCode%3Dxm2%26camp%3D2025%26creative%3D165953%26creativeASIN%3DB003ZWN5ZM) or [Kepton](https://www.amazon.com/Mil-Kapton-Tape-Polyimide-Yds/dp/B006ZFQNT6%3FSubscriptionId%3DAKIAILSHYYTFIVPWUY6Q%26tag%3Dduckduckgo-d-20%26linkCode%3Dxm2%26camp%3D2025%26creative%3D165953%26creativeASIN%3DB006ZFQNT6) tape

Lets start!

1. Remove the top cover of Iris. You will need to unplug the RC radio, the magnetometer and maybe a couple of other things
2. Remove the bottom cover. You will need to unplug the i2c LED and unscrew the USB port
3. Put the bottom cover flat. Optionally remove the battery bay door. Place the PX4Flow and the lidar as shown in the picture below. Lidar connector faces towards the battery bay door. PX4Flow has the camera closer to the bay door, and sonar closer to the camera mount.

![Sensors orientation](../images/3-orientation.JPG)

4. We want to place both sensors on the flatter part of the belly, just before it starts tapering down towards the camera holder, see the image below:

![Sensors placement](../images/4-position.JPG)

5. The lidar and the PX4Flow camera share two mounting holes. We will drill 6 holes total, following the layout of the sensors, as shown below:

![Holes placement](../images/2-holes.JPG)

6. We recommend using a small marking bit to mark the location of the holes (you can use tape to hold the sensors in place), and then drilling final holes for M3 screws with a larger drill bit. Here is an ilustration of the process - smaller guide hole is on the bottom, larger final one is on the top:

![Drill small hole first, then use a bigger bit](../images/1-iris.JPG)

7. Now mount the sensors, the screw head will be inside the frame, the nylon nuts are on the sensors side. You will need to use multiple nuts to give the sensors enough space (so they don't touch the plastic directly). 

![Sensors mounted - view from inside of the frame](../images/7-inside.JPG)

8. Use a thin slice of tape to cover the screw heads in the inside. There is enough clearance from the capacitors on the ESC board, but we don't want to take any chances here. This is how it should look like:

![Covered screw heads, just in case](../images/8-tape.JPG)

9. Now we need to add the i2c cable to connect to the PX4Flow - we have to cut a little notch in the top cover so we don't pinch the cables, see below:

![Cut a small notch for the cables](../images/9-cutoff.JPG)

![Detail of the same](../images/10-cutoffdetail.JPG)
 
10. Now it is a good time to solder the lidar cable. Get the lidar cable and a 4 pin i2c cable. Cut the i2c cable in half, since we will need to solder it to the lidar cable. We need to connect:
  - Lidar red -> PX4 red (VCC)
  - Lidar black -> PX4 pin#4, furthest away from the red (GND)
  - Lidar Green -> PX4 pin#2 next to the red (SCL)
  - Lidar Blue -> PX4 pin#3 (the last one free) (SDA)

Third hand comes handy here. Use some shrinktube to protect the solder joints. Below are the pinouts:

![Lidar lite wiring harness](../images/lidar-wire.png)

![Pixhawk I2C connector](../images/i2c.png)

11. Finally, don't forget to twist all cables you have to get rid of unwanted noise. 

![Twisted i2c cable](../images/11-twistedcable.JPG)


And that is it! 

