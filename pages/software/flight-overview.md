# Flight Software: Overview

The SMACCMPilot project has produced [quadcopter][] flight control software as a
real-world validation of the project's new software techniques and
[languages][].

[quadcopter]: http://en.wikipedia.org/wiki/Quadcopter
[languages]: http://ivorylang.org

The SMACCMPilot project only supports the [Pixhawk][] flight controller and four
motored copters. It comes with tuning parameters for the now-discontinued 3DR
Iris and Iris+.

### Capabilities

#### Flight Stabilization

SMACCMPilot implements a simple quadcopter stabilizer for manual piloting.
There are no autonomous features implemented.

#### RC Control

SMACCMPilot is flown manually with a radio controller. For more info, see the
[Radio Control hardware page][rc].

[rc]: ../hardware/rc-controller.html

#### Telemetry

You can view telemetry from the vehicle using the [ground control station
software](gcs-overview.md).

