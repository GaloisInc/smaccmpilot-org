# Ground Control Station

We provide a ground control station

## Prerequisite

Run `make` in the smaccm-comm-client directory.

## Running

The smaccm-comm-client starts an http server on port 8080 (change this with
options, see --help to learn more).

In `smaccmpilot-build/smaccmpilot-stm32/src/smaccm-comm-client/` there is a
shell script `gcs.sh`. Provide two arguments: first, the serial port the radio
is connected to, and second, the baud rate (if you're using smaccm-sik, as you
should be, this will always be 57600).

You can pass additional options after these, pass `--help` to learn about them.

## Browser Interface

Several HTML based user interfaces are available:

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
* [http://localhost:8080/motors.html](http://localhost:8080/motors.html) shows
  the vehicle motor outputs
* [http://localhost:8080/pidconfig.html](http://localhost:8080/pidconfig.html)
  is used to tune the flight PID control loop parameters. Note that these
  parameters are not saved across the reset, once you tune a vehicle you will
  have to buildw new firmware with the desired PID variables by default creating
  a new vehicle type in
  `smaccmpilot-build/smaccmpilot-stm32/src/smaccm-flight/tuning.conf` and
  building firmware for that precise vehicle by setting the `args.vehicle` field
  in your `user.conf`.
* [http://localhost:8080/uitest.html](http://localhost:8080/uitest.html) shows
  the user input (RC controller) values being recieved by the vehicle.

## JSON API

If you wish to make your own gcs app, the smaccm comm client speaks a simple
JSON api based on the GIDL schema found in
`smaccmpilot-build/smaccmpilot-stm32/src/smaccm-comm-schema/smaccm-comm-schama.gidl`.
We apologize there are very few docs on how this works, but you can follow the
examples in the existing web browser UIs and send mail to the list if you need
more information.

