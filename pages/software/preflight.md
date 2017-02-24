# Flight preparation


## Sensors calibration

Before we can fly, we need to calibrate our sensors to get a reliable attitude estimation. In order to calibrate the sensors correctly, we need to get raw data out of then, save and parse them, and do a least squares estimation to find the bias of each axis. The simplest way to do so is to use [Paparazzi autopilot][pprz] firmware for PX4. Note that the acceleroneter calibration has to happen *before* you put the Pixhawk into Iris. Magnetometer calibration on the other hand has to happen *after* you install Pixhawk into the quadcopter. More theory and information about the calibration can be found at [Paparazzi wiki][pprz_wiki]

[pprz]: https://wiki.paparazziuav.org/
[pprz_wiki]: https://wiki.paparazziuav.org/wiki/ImuCalibration

### Installing Paparazzi
Although there is nice and detailed description on [Paparazzi wiki][pprz-install] we can just use this one liner to get us up to date (copy-paste to your shell):

```
sudo add-apt-repository -y ppa:paparazzi-uav/ppa && sudo add-apt-repository -y ppa:team-gcc-arm-embedded/ppa && sudo apt-get update && \
sudo apt-get -f -y install paparazzi-dev paparazzi-jsbsim gcc-arm-embedded && cd ~ && git clone --origin upstream https://github.com/paparazzi/paparazzi.git && \
cd ~/paparazzi && git remote update -p && \
git checkout -b v5.10 upstream/v5.10 && sudo cp conf/system/udev/rules/*.rules /etc/udev/rules.d/ && sudo udevadm control --reload-rules && \
make && ./start.py
```

#### Uploading Firmware
A lancher will pop up:

![](../images/pprz1.png)

From the launcher configuration, choose `Conf = conf_tests.xml` and `Control panel = control_panel.xml`, then press *Launch Paparazzi with selected configuration* 

Now you will see *Paparazzi center*. First choose your airframe (A/C) from the dropdown menu and set it to *Iris.* Then set your *Target* to *ap* (autopilot). Set the *Flash Mode* to *Default* and compare what you see with the picture below:

![](../images/pprzcenter1.png)

Click on *Clean* and then *Build*. As the build is progressing, get ready to plug in your usb cable into Pixhawk, but *don't plug it in yet*. Once the build process finishes, we need to *Upload* the new firmware. Unfortunately the way the upload is handled, you have to time your steps precisely in order to avoid timeouts (fortunately you have to do this only once). So get ready to plug in the USB cable into Pixhakw, press *Upload* and connect the USB cable to the Pixhawk USB port within 1-2 seconds after you pressed the *Upload* button. 

![](../images/pprzcenter2.png)

If you do it correct, you will see the familiar bootloader output:
```
Found board 9,0 bootloader rev 5 on /dev/serial/by-id/usb-3D_Robotics_PX4_BL_FMU_v2.x_0-if00
50583400 00ac2600 00100000 00ffffff ffffffff ffffffff ffffffff ffffffff 6e369938 4b384b7e bd4a1f73 2ab539ed e63e39a0 b2a70f4e 773276b9 7fd0eae1 3e34cace 08201d59 ffa4f998 32542721 3121c8b1 74e24c40 8df8e18c e5135968 10a0cd5b 0f9851a3 7ed75a54 79b70e95 3b12idtype: =00
vid: 000026ac
pid: 00000010
coa: bjaZOEs4S369Sh9zKrU57eY+OaCypw9OdzJ2uX/Q6uE+NMrOCCAdWf+k+ZgyVCchMSHIsXTiTECN+OGM5RNZaBCgzVsPmFGjftdaVHm3DpU7ElwrOAzech3BxeRQTxgAZJUqHIENDs9In0IqoATNgW1S06mGP0NFNXVzUg28THU=

sn: 002300303532471836343032
chip: 10036419
family: STM32F42x
revision: Y
flash 1032192


Erase  : [                    ] 0.0%
Erase  : [=                   ] 5.6%
Erase  : [==                  ] 11.1%
Erase  : [===                 ] 16.7%
Erase  : [====                ] 22.3%
Erase  : [====================] 100.0%

Program: [=======             ] 39.1%
Program: [===============     ] 78.3%
Program: [====================] 100.0%

Verify : [                    ] 1.0%
Verify : [====================] 100.0%
Rebooting.
```

Now we have flashed a firmware on the Pixhawk. In case you didn't see this message, repeat the Upload step - you probably timed-out.

The next step is to connect to a running Pixhawk. Take a FTDI USB-to-serial converter cable and plug it into *TELEMETRY 1* port on Pixhawk. You should have a USB cable plugged into the Pixhawk USB port already, if that is not the case, do it now.

![FTDI cable with the Pixhawk telemetry connector](../images/cable.jpg)

Set the *Session* to *Messages and settings* and hit *Execute* as shown below.

![](../images/pprzcenter3.png)

Another pop-up window will show up, one with the messages received from the Pixhawk, another one with settings that can be changed. By default, the raw messages are not sent so we need to adjust the telemetry settings. In the *Settings* window, change the telemetry 

![Raw messages from sensors](../images/pprzcenter4.png)

### Accelerometer calibration

### Magnetometer calibration

