
# Gamepad setup

Smaccmpilot quadcopter can be controller via a joystick or a gamepad (such as [xbox controller][xbox]). The quadcopter has to be in **GCS Input Mode** and the GCS window has to be in focus. Only horizontal control is allowed (i.e. roll/pitch/yaw), the altitude is automatically maintained by the autopilot. GCS operator can also reset the Linux VM on the Mission computer.

![Xbox one](/images/xboxone.jpeg)

We bind the buttons on the gamepad to keys, so any joystick or gamepad can be used as long as it is properly mapped. Indeed it is possible to control the quadcopter just with the keyboard, but it requires more piloting skills. 

Upon pressing a key, the GCS sends a command message with a discrete control input to the autopilot, where the GCS commands are blended in with the RC control input. That way the trims are counted in, and the safety pilot has always the authority to override the gamepad.

[xbox]: https://www.amazon.com/Microsoft-Xbox-Controller-Cable-Windows/dp/B00O65I2VY?SubscriptionId=AKIAILSHYYTFIVPWUY6Q&tag=duckduckgo-d-20&linkCode=xm2&camp=2025&creative=165953&creativeASIN=B00O65I2VY

## Key mapping

Keys are mapped as:

* W: pitch down
* A: roll left
* S: pitch up
* D: roll right
* Q: yaw left
* E: yaw right
* T: reset Virtual Machine

Indeed you can combine multiple keys to yaw left and pitch forward at the same time for example.


The control scheme we recommend for a gamepad is:

* D-pad: WSAD
* Shoulder buttons: QE
* Start/Menu button: T


## Setup

This setup is tested on Ubuntu 14.04 and uses *xpad* and *antimicro* for keyboard binding.

```
$ sudo git clone https://github.com/paroj/xpad.git /usr/src/xpad-0.4
$ sudo dkms install -m xpad -v 0.4
$ sudo modprobe xpad
$ ls /dev/input
$ # should see /dev/input/js0
$ sudo add-apt-repository ppa:mdeguzis/libregeek
$ sudo apt-get update
$ sudo apt-get install antimicro
```

Now start up *antimicro* and load the following key bindings:

![](/images/xbox.png)

## Flight

In order to use gamepad control, the quadcopter has to be in **GCS Input mode** and the GCS window has to be in focus.
