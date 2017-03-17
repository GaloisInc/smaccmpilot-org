# RC Hardware

## What is an RC transmitter?

SMACCMPilot may be flown using a Radio Control (RC) transmitter.  When we say
"RC" we are talking about the general range of hobbyist radio control systems
built for flying RC airplanes, helicopters, and the like.

An RC transmitter is a simple and reliable way to manually fly a small
quadcopter.  In the stabilize flight mode, the SMACCMPilot flight controller
essentially serves to make a quadcopter system manually controllable - manual
inputs command throttle, pitch angle, roll angle, and yaw rate. We will map
these inputs to the four joystick axes of the RC transmitter. We'll also map the
control sequences to arm and disarm the flight controller to use a switch on the
RC transmitter as a kill switch, which can turn off the quadcopter motors at any
time. This is a critical safety feature.

![*RC Transmitter Joystick Functions*](../images/radio.png)

## A Safety Controller

SMACCMPilot uses the RC system primarily for safety. Because SMACCMPilot is
still experimental and cannot safely fly without human guidance, the RC system
provides a pilot a way to disable autonomous flight or the helicopter motors
themselves at any time.

We envision that one day, SMACCMPilot will be smart enough to fly & land safety
without requiring an RC system for safety. However, for now, we recommend that
SMACCMPilot users get comfortable flying the vehicle under stabilize mode, and
always have a safety pilot holding the RC transmitter when flying in autonomous
mode.

Improper operation of any quadcopter can cause injury. Only operate a safe
distance away from people, and always have an operator spotting the vehicle and
ready to hit the kill switch.

## Compatible RC Transmitter and Receivers

RC transmitter systems come in many shapes in sizes. Each transmitter system
will also be compatible with some set of RC receivers. We need a transmitter and
receiver system with the following features:

* Aircraft or helicopter style transmitter with two joysticks
* Transmitter offers at least 6 channels of control
* Receiver offers PPM output

## Mixing information

RC transmitters typically require some amount of setup to configure the mapping
of control inputs to output channels. SMACCMPilot requires a radio with at least
6 output channels.

RC transmitters use various schemes to "mix" input sticks and switches to the
channel outputs. Fundamentally, each channel is sent from the receiver to the
flight controller as a pulse-width modulated (PWM) wave. (Pulse-position
modulation, PPM, is a scheme used to multiplex multiple PWM signals serially.)
Whether modulated as PWM or PPM, each channel has a width in the time domain,
measured in microseconds. RC transmitters generally output a channel with a
width ranging from 1000us to 2000us. If your RC transmitter uses a different
range, it may not work with SMACCMPilot.

SMACCMPilot expects radio channels according to the following scheme:

* Channel 1 controls roll.
* Channel 2 controls pitch.
* Channel 3 controls throttle.
* Channel 4 controls yaw.

* Channel 5 selects flight control mode. At this time, SMACCMPilot supports
  three flight control modes: stabilize, and altitude hold, and autonomous.
  The user will typically map channel 5 to a 3-position switch on the right side
  of the controller.
  Channel 5 pulse widths correspond to the following modes:
    * 1000-1250us: autonomous mode
    * 1250-1750us: altitude hold mode
    * 1750-2000us: stabilize mode

* Channel 6 is the arming switch. It is designed for safety: if, at any point, the
  arming switch is released, all of the motors will disarm (no more power will
  be applied) instantly. The arming switch must be set before the motors are
  armed via either the RC controller or via a telemetry command.
  The user will typically map channel 6 to a 2-position switch on the top left
  of the controller.

Below is a recommened configuration for **FS-TH9X radio controller**, shipped as a default with Iris+:
![*FS-TH9X radio controller*](../images/iris_radio.jpg)

### Iris+ switches
3-position **MODE SWITCH** is located on the right side of the controller, and the pilot operates it with their right index finger (while keeping the right thumb on the roll/pitch stick). The modes are:

* **TOP:** Manual mode (all control inputs are from the pilot)
* **MIDDLE:** Alt-hold mode (pilot controls roll/pitch/yaw, the altitude/throttle is maintained automatically)
* **BOTTOWM:** GCS mode (same as Alt-hold, except the GCS operator can send roll/pitch/yaw commands over datalink)

Two position **KILL SWITCH** (labelled as *THROTTLE CUT*) is your best friend. Located at the left side of the controller. It is operated by your left index finger (so you can keep your left thumb on the throttle stick) and you should **always** have a finger on the KILL switch. When engaged (push *away* with your index finger), the vehicle immediately kills all the throttle and stops the motors. When disengaged (push towards you) it allows the vehicle to be armed. 

![RC switches](/images/rc_switches.png)


### Iris+ radio configuration
Your radio should be configured exactly the same:

![Page 1](/images/rc1.JPG)

![Page 2](/images/rc2.JPG)

![Page 3](/images/rc3.JPG)

![Page 4](/images/rc4.JPG)

![Page 5](/images/rc5.JPG)

![Page 6](/images/rc6.JPG)

![Page 7](/images/rc7.JPG)

![Page 8](/images/rc8.JPG)


## Arming via RC controller

The user can arm the motors from the RC controller with the following
sequence:

  1. Channel 6 is set (pulse width greater than 1500us)
  2. Channel 5 set to stabilize mode (pulse width greater than 1750us)
  2. Throttle stick is at the low limit (pulse width lower than 1050us)
  3. Yaw stick is at the high limit - fully to the right (pulse width greater than 1950us)

After this sequence is complete, the motors are armed.  When the throttle stick
is raised, motors will start spinning.

The vehicle is disarmed at any time by resetting the channel 6 switch.

## More information

See our [examples page][] for recommendations and setup instructions for some
radio systems we have used.

[examples page]: rc-controller-examples.html

The [PX4 Project wiki][px4-rc] has more information about various RC radio
systems. Note that the PX4 project software can support more types of radio
system input than the SMACCMPilot software. SMACCMPilot only supports PPM input
at this time.

[px4-rc]: http://pixhawk.ethz.ch/px4/radio-control/start
