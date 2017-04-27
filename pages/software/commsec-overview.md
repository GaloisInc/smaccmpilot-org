# Secure Communications

[MAVLink][mavlink] is a popular micro air vehicle message format used to
communicate between the ground stations and unmanned vehicles.  MAVLink uses
insecure radio frequency-based communications channels that are susceptible to
common attacks including snooping, forgery, replay attacks, traffic analysis,
and denial of service.

In response, we've implemented a simple
[custom serialization protocol](https://github.com/GaloisInc/gidl) called GIDL
for with Ivory and Haskell backends. In SMACCMPilot, GIDL replaces MAVLink.

We have also implemented a implemented a lightweight encapsulation format that
can be used with GIDL (or MAVLink) to protect against forgery, replay attacks,
and snooping.  The changes result in an overhead of 16 bytes of additional
bandwidth use per message frame, which is potentially composed of many messages.
The computational overhead is dominated by encryption and decryption operations
for each message send and receive.

The design constraints for the crypto are made with the following constraints in mind:

* Costs, in terms of computational overhead and bandwidth, must be kept low.
* Availability of the communications medium must not be eliminated by unexpected power-cycles.
* One-way links must remain useful, the protocol can not assume two-way communication.
* Packet-loss can occur for extended periods of time (easily many minutes).

There are two distinct phases: key agreement and encapsulation. The design of both (and more details about the cryptographic work) are described in the [Galois Embedded Crypto](https://github.com/GaloisInc/gec) repository.

[mavlink]: http://qgroundcontrol.org/mavlink/start
