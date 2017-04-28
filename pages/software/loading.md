# Uploading SMACCMPilot

These instructions assume you've succesfully [built SMACCMPilot][building],
and you have a complete [SMACCMPilot flight platform][hardware].

## Stand-alone flight computer

For stand-alone flight, there is only one board to program:

- [Pixahwk][Pixhawk]

Follow the detailed instructions [here][standalone].

## Demo configuration (flight and mission computer)

For demo flight, there are two boards to program: 

- [Pixahwk][Pixhawk]
- [Colorado Engineering TK1][TK1] with [NVIDIA Tegra K1 SoC][tegra]  

First, follow the stand-alone flight
computer [instructions][standalone], and then follow the detailed
misson computer [instructions][demo].

[standalone]: standalone.html
[demo]: demo.html

[building]: build.html
[hardware]: ../hardware/index.html
[Pixhawk]: https://pixhawk.org/modules/pixhawk
[TK1]: https://coloradoengineering.com/standard-products/tk1-som-8gb/
[tegra]: https://coloradoengineering.com/standard-products/tk1-som-8gb/
[ODROID-XU]: http://odroid.com/dokuwiki/doku.php?id=en:odroid-xu4

