
# Example RC Controllers

SMACCMPilot is compatible with a wide variety of RC transmitters and receivers,
as long as they provide 6 or more channels and PPM output. We will describe three
sample RC control systems which we've successfully used with SMACCMPilot.

## FlySky FS-TH9X

The FlySky FS-TH9X ships with the Iris+: 

![*FS-TH9X radio controller*](../images/iris_radio.jpg)

### FS-TH9X switches
The 3-position **MODE SWITCH** is located on the right side of the controller, and the pilot operates it with their right index finger (while keeping the right thumb on the roll/pitch stick). The modes are:

* **TOP:** Manual mode (all control inputs are from the pilot)
* **MIDDLE:** Alt-hold mode (pilot controls roll/pitch/yaw, the altitude/throttle is maintained automatically)
* **BOTTOWM:** GCS mode (same as Alt-hold, except the GCS operator can send roll/pitch/yaw commands over datalink)

The 2-position **KILL SWITCH** (labelled as *THROTTLE CUT*) is your
best friend. Located at the left side of the controller, it is
operated by your left index finger so you can keep your left thumb on
the throttle stick. You should **always** have a finger on the kill
switch. When engaged (push *away* with your index finger), the vehicle
immediately kills all the throttle and stops the motors. When
disengaged (push towards you) it allows the vehicle to be armed.

![RC switches](/images/rc_switches.png)


### FS-TH9X radio configuration

Your radio should be configured exactly as follows:

![Page 1](/images/rc1.JPG)

![Page 2](/images/rc2.JPG)

![Page 3](/images/rc3.JPG)

![Page 4](/images/rc4.JPG)

![Page 5](/images/rc5.JPG)

![Page 6](/images/rc6.JPG)

![Page 7](/images/rc7.JPG)

![Page 8](/images/rc8.JPG)


## FrSky Taranis X9D

![](/images/FrSky-Taranis-X9D+.jpg)

FrSky recently released the [Taranis][], a transmitter which is compatible with
their range of recievers. It has a better build quality than the Turnigy 9XR,
and comes with a rechargable transmitter battery & wall wart charger. As of this
writing (Nov 2013) the Taranis is sold by Aloft Hobbies in the US, but is in
short supply.

[Taranis]: http://www.frsky-rc.com/product/pro.php?pro_id=113

### FrSky Receivers

The Taranis system is offered bundled with the X8R receiver. XXX, lookup how to
put X8R into PPM mode, and check that PPM period is correct.

The [FrSky D4R-II receiver][d4r-ii] is small, inexpensive, and offers PPM
output. However, the PPM output is only valid when the user limits their use to
only 6 channels. Please be sure to set channels 7 and 8 to output a low pulse
width (1000us) when using the D4R-II module.

## Turnigy 9XR w/ FrSky radio gear

On our [shopping list][] page we recommend the [Turnigy 9XR
radio][9xr-hobbyking]. The 9XR is one of the least expensive radios which can be
configured with all of the features required for SMACCMPilot. The aesthetics and
build quality leave something to be desired, but it gets the job done.

[shopping list]: shoppinglist.html

![*Image: hobbyking.com*](../images/9xr_hobbyking.jpg)

[9xr-hobbyking]: http://hobbyking.com/hobbyking/store/__31544__Turnigy_9XR_Transmitter_Mode_2_No_Module_.html

The 9XR is designed to take interchangeable radio transmitter modules for
inter-operation with various radio receivers. The simplest way to get a radio
system with the PPM capability we need is with [FrSky][] radio
modules.

The [FrSky DJT transmitter module][djt] is compatible with the 9XR transmitter.
The [FrSky D4R-II receiver][d4r-ii] is small, inexpensive, and offers PPM
output. See caveat about the D4R-II in the FrSky Taranis section above.

### Mixing for 9x radio

In the 9XR radio, setting up the following the mixer screen will give correct
behavior with the 'THR CUT' switch used for arming and the 'AUX.3' switch used
for mode selection.

![](../images/9x-mixerscreen.jpg)



[FrSky]: http://www.frsky-rc.com
[djt]: http://www.frsky-rc.com/product/pro.php?pro_id=8
[d4r-ii]: http://www.frsky-rc.com/product/pro.php?pro_id=24

