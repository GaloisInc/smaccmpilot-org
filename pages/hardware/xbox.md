
# Gamepad setup

SMACCMPilot quadcopter can be controller via keyboard or a gamepad
(such as an [Xbox One controller][xbox]). The quadcopter has to be in **GCS
Input Mode** and the GCS window has to be in focus. Only horizontal
control is allowed (i.e. roll/pitch/yaw); the altitude is
automatically maintained by the autopilot. GCS operator can also reset
the Linux VM on the mission computer for the demo scenario.

![Xbox one](/images/xboxone.jpeg)

We bind the buttons on the gamepad to keys, so any gamepad can be used
as long as it is properly mapped. Indeed it is possible to control the
quadcopter just with the keyboard, but it is easier with the gamepad.

Upon pressing a key, the GCS sends a command message with a discrete
control input to the autopilot, where the GCS commands are blended in
with the RC control input. That way the trims are counted in, and the
safety pilot has always the authority to override the gamepad.

[xbox]: https://www.amazon.com/Microsoft-Xbox-Controller-Cable-Windows/dp/B00O65I2VY

## Key mapping

The keys are mapped in the GCS as:

* W: pitch forward
* S: pitch back
* A: roll left
* D: roll right
* Q: yaw left
* E: yaw right
* T: reset Virtual Machine

Multiple key inputs can be combined, for example you can hold down `w`
and `q` to yaw left and pitch forward at the same time.

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

On MacOS, we have had success
using [Enjoyable](https://yukkurigames.com/enjoyable/) to bind keys.

## Flight

In order to use gamepad control, the quadcopter has to be in **GCS
Input mode** and the GCS window has to be in focus.
