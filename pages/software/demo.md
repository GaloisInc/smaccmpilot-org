# SMACCMPilot demo flight

This page covers the daughterboard configuration for a demo flight. First, make sure you upload the [flight computer][standalone]

[standalone]: standalone.html

## Flash uboot

Follow instructions written [here](https://wiki.sel4.systems/Hardware/jetsontk1?highlight=%28uboot%29#Flash_U-Boot)

## Load the filesystem

**TBD**

## Upload Pixy cam software

Follow the instructions from [here](../hardware/iris.html#pixycam)

## Ready to fly?

Proceed to [preflight preparations][preflight] or check out the demo script below.

## HACMS Phase 3 Demo Script

The HACMS Phase 3 SMACCMcopter demo consists of two scenarios: a successful attack and
a failed attack. Both attacks start from the assumption that the hacker has root access on the
Linux VM hosting the camera software. The hacker is then looking to escalate his access and/or
compromise the mission. In the successful attack the hacker is able eventually able to take over
complete control of the vehicle while preventing the legitimate ground control station (GCS) from
accessing the vehicle. In the failed attack the hacker is unable to do anything beyond
temporarily taking down the camera.

