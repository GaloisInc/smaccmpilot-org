# HACMS Phase 3 Demo Script

The HACMS Phase 3 SMACCMcopter demo consists of two scenarios: a successful attack and
a failed attack. Both attacks start from the assumption that the hacker has root access on the
Linux VM hosting the camera software. The hacker is then looking to escalate his access and/or
compromise the mission. In the successful attack the hacker is able eventually able to take over
complete control of the vehicle while preventing the legitimate ground control station (GCS) from
accessing the vehicle. In the failed attack the hacker is unable to do anything beyond
temporarily taking down the camera.



## Common Setup

1. The GCS operator needs a copy of the GCS software
2. The GCS operator needs a copy of the [camera demo software][camera_sw].
3. The GCS operator needs a 3DR radio on the same channel as the smaccmcopter
4. The TK-1 should be configured to automatically join a wireless network on boot and start the camera demo software
5. The demo software should be launched with: `./demo <ip-address- of-GCS>;`
7. The attacker needs ssh access to the copter
8. Safety pilot (PPM controller) for take-off, landing, stabilization as needed.

![Friendly GCS](/images/gcs_good.png)

[camera_sw]: https://github.com/smaccm/camera_demo



## The Successful Attack

This attack assumes the unsecured version of Linux VM. See [attack details][attack] for more info.

[attack]: attack_details.html

### Configuration ahead of time

1. The GCS operator and attacker each need a 3DR radio using the same channel as the smaccmcopter. Thus you’ll have three 3DR radios in total, all on the same channel. Only two will ever be powered at the same time. Do not ever power all three simultaneously.
2. The attacker needs a copy of the ground station software with the last 8 bytes of both keys changed to all zeros. That is, modify keys.conf to look like:

```
[symmetric_key.server_to_client]
keysalt = [ 1, 2, 3, 4, 5, 6, 7, 8,
            9, 10, 11, 12, 13, 14, 15, 16,
             0, 0, 0, 0, 0, 0, 0, 0]

[symmetric_key.client_to_server]
keysalt = [ 24, 23, 22, 21, 20, 19, 18, 17,
            16, 15, 14, 13, 12, 11, 10, 9,
             0, 0, 0, 0, 0, 0, 0, 0]
```

3. The attacker needs a copy of the camera demo software.
4. The smaccm camera_demo and vm_hack repositories should be checked out on the smaccmcopter (they are under `/root/` folder).
5. The file `camera_demo/attack.py` should be customized with the GCS ip address and the hacker ip address
6. You may need to install some libraries for python and curses in order to run the cattacks


### Live Step-by-step

1. SMACCMcopter starts in *friendly territory.*
2. Maintenance person loads the unsecure image onto the TK1 (e.g. via red USB stick)
  * a. Insert stick into USB 3.0 port (near power jack)
  * b. Push reset button
  * c. Wait 10 seconds (camera light will flash during this time)
  * d. Ensure Pixhawk is armed
3. GCS operator loads GCS and camera software, establish connection/display
4. Safety pilot starts copter and takes off (in manual mode).  Hover at approx. 6 ft. altitude. 
5. Safety pilot switches to GCS mode
6. GCS operator takes control of copter and flies copter left and right in the flight area at constant altitude
7. Attacker ssh’s into TK1 via WiFi
8. Attacker runs vm_hack/attack.py (press ‘space’ to advance the animation/attack). The GCS will lose telemetry and control.
9. Attacker will start up his GCS software
10. Attacker has control and flies the copter via his GCS, causing it to fly left and right. 
11. Video attack is triggered by Attacker (using a separate laptop)
  * a. Attacker takes control of WiFi video
  * b. Attacker runs camera_demo/attack.py
  * c. This will send the skull animation to the GCS and send correct camera image to the attacker
12. The Attacker Pilot controls the copter via his GCS and moves it to *enemy territory*.
13. At the end of the demo, the safety pilot lands the copter.


![Flight path during successfull attack](/images/attack.png)



## The Failed Attack

This scenario assumes the secured version of Linux VM.


### Configuration ahead of time

There is no extra configuration for the failed attack. GCS reinstalls his 3DR radio.  The attacker’s 3DR radio is disconnected and never used.


### Live Step-by-step

1. SMACCMcopter starts in *friendly territory*.
2. Maintenance person loads the secure image onto the TK1 (e.g. via blue USB stick)
  * a. Insert stick into USB 3.0 port (near power jack)
  * b. Push reset button
  * c. Wait 10 seconds
  * d. Ensure Pixhawk is armed
3. GCS operator loads GCS and camera software, establish connection/display
4. Safety pilot starts copter and takes off (in manual mode).  Hover at approx. 6 ft. altitude. 
5. Safety pilot switches to GCS mode
6. GCS operator takes control of copter and flies copter left and right in the flight area at constant altitude
7. Attacker ssh’s into TK1 via WiFi
8. Attacker runs vm_hack/attack.py (press ‘space’ to advance the animation/attack). The attack will fail. 
  * Press ‘q’ or Ctrl-c to quit
9. GCS operator resumes flying copter left and right.. 
10. Attacker runs vm_hack/forkbomb.py
  * a. This will display a little randomized animation for a bit, then do a real forkbomb
  * b. The hacker’s terminal will freeze up
  * c. The GCS’s camera view will show the camera being disconnected
10. The GCS operator clicks the *reboot* button
  * a. The Linux VM should take less than 12 seconds to reboot
  * b. At this point the GCS is back to its initial state and the hacker’s terminal is frozen.
11. The GCS operator flies the drone back to *friendly territory*.
12. At the end of the demo, the safety pilot lands the copter.


![Flight path during unsuccessfull attack](/images/defend.png)
