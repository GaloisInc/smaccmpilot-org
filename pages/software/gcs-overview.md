# Ground Control Station

We provide a ground control station for monitoring the status of the
quadcopter, for tuning the control loops and for control via keyboard
or gamepad.


## Prerequisite

Run `make` in
the
[smaccm-comm-client](https://github.com/GaloisInc/smaccmpilot-stm32f4/tree/master/src/smaccm-comm-client) directory
of a full SMACCMPilot [build tree](build.html).


## Running

The `smaccm-comm-client` executable starts a http server on port 8080
(change this with options, see `--help` to learn more).

In `smaccmpilot-build/smaccmpilot-stm32/src/smaccm-comm-client/` there is a
shell script `gcs.sh`. Provide two arguments: first, the serial port the radio
is connected to, and second, the baud rate (if you're using `smaccm-sik`, as you
should be, this will always be 57600).

You can pass additional options after these, pass `--help` to learn about them.


## Browser Interface

Several HTML based user interfaces are available:

* [http://localhost:8080/elm.html](http://localhost:8080/elm.html) is
  the primary display of the vehicle's state when using the flight
  application, provides an interface for tuning the controller
  parameters, and allows keyboard inputs to control a vehicle in GCS
  input mode
* [http://localhost:8080/elm2.html](http://localhost:8080/elm2.html)
  a reskinned "adversary" GCS used during the final flight demo
* [http://localhost:8080/sensors_accel.html](http://localhost:8080/sensors_accel.html)
  shows the output from the accelerometer
* [http://localhost:8080/sensors_gyro.html](http://localhost:8080/sensors_gyro.html)
  shows the output from the gyroscope
* [http://localhost:8080/sensors_mag.html](http://localhost:8080/sensors_mag.html)
  shows the output from the magnetometer


Additional interfaces convenient for debugging:

* [http://localhost:8080/sensors.html](http://localhost:8080/sensors.html)
  displays a plot with roll, pitch and yaw of the quadcopter
* [http://localhost:8080/motors.html](http://localhost:8080/motors.html) shows
  the vehicle motor outputs
* [http://localhost:8080/uitest.html](http://localhost:8080/uitest.html) shows
  the user input (RC controller) values being recieved by the vehicle.
* [http://localhost:8080/alt_setp.html](http://localhost:8080/alt_setp.html) 
  is used for tuning altitude hold


Older (deprecated) interfaces:

* [http://localhost:8080/hud.html](http://localhost:8080/hud.html)
  is the primary display of the vehicle's state when using the flight
  application.  
* [http://localhost:8080/attitude.html](http://localhost:8080/attitude.html)
  renders the output of the sensor fusion, which is available in the flight
  application and the smaccm-ins tests
* [http://localhost:8080/bbox.html](http://localhost:8080/bbox.html) shows
  the bounding box output from the odroid companion computer, if connected
* [http://localhost:8080/light.html](http://localhost:8080/light.html) directly
  controls the RGB led, useful in the RGB LED unit test
* [http://localhost:8080/pidconfig.html](http://localhost:8080/pidconfig.html)
  is used to tune the flight PID control loop parameters. Note that these
  parameters are not saved across the reset, once you tune a vehicle you will
  have to build new firmware with the desired PID variables by default creating
  a new vehicle type in
  `smaccmpilot-build/smaccmpilot-stm32/src/smaccm-flight/tuning.conf` and
  building firmware for that precise vehicle by setting the `args.vehicle` field
  in your `user.conf`.

## JSON API

If you wish to make your own GCS app, the `smaccm-comm-client` server
speaks a simple JSON API based on the GIDL schema found
in
[smaccmpilot-build/smaccmpilot-stm32/src/smaccm-comm-schema/smaccm-comm-schama.gidl](https://github.com/GaloisInc/smaccmpilot-stm32f4/blob/master/src/smaccm-comm-schema/smaccm-comm-schema.gidl).

Unfortunately there are very few docs on how this works, but you can
follow the examples of the existing browser UIs, and send mail to the
list if you need more information.

