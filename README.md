# ddragon2-sound-diag
This is a sound diagnostics program that can be run on the sound cpu of the original double dragon 2 jamma/arcade boards.  This is a sister project to [ddragon-diag](https://github.com/jwestfall69/ddragon-diag) which targets the main cpu.

The sound diag rom tries to verify core functionality of the sound subsystem, ie:

* Sound cpu functioning
* Sound ram is good
* YM2151 is alive
* OKI6295 is alive

Such that ddragon2's sound rom should be functional when used and any sound issue is being caused by a non-core fault (ie bad YM3012).  In this case its best to use the ddragon-diag with ddragon2's sound rom.  Using the sound test to repeatedly play a PCM or FM sound over and over, tracing its path and where it dies.

In order to make use of this diag rom you will need a logic probe.  Error codes (and success code) are determined by probing what address the diag rom stops on.

Please refer to the [error addresses](docs/error_addresses.md) docs for more information.

## Usage
#### MAME
Copy ddragon2-sound-diag.bin over 26ad-0.bin rom file in ddragon2, and fire up ddragon2.

#### Hardware
Burn the ddragon2-sound-diag.bin to a 27C256 or a 27c512 (if you double it up). Install the eprom into IC41.  You will also want to have the 2x ADPCM roms install or the OKI6295 play test will fail.

## Pre-Built
You can grab the latest build from the main branch at

https://www.mvs-scans.com/ddragon2-sound-diag/ddragon2-sound-diag-main.zip

## Building
Building requires vasm (vasmz80_oldstyle) and vlink which are available here

http://sun.hasenbraten.de/vasm/<br>
http://sun.hasenbraten.de/vlink/
