# Error Addresses
---
The only output the sound cpu has is sound, but the only reason to run the sound diag is if you have no sound.  So in order to communicate errors (or success) to user, the sound diag will jump to a specific address and then continually loop at that address.  The Z80 cpu uses A0 to A6 for part of memory refresh so those lines will always be pulsing. That leaves the upper 9 address lines for communicating errors.

A logic probe is need to probe each of the address lines to determine what address the sound diag stopped on.  When doing this its best to start with A15 and work your ways backward.

Address lines that are pulsing should be considered a 1, while address lines that are low should be considered 0.

|  Hex |   Binary (A15...A0) | Error |
|-----:|---------------------|-------|
| 7a00 | 0111 1010 0xxx xxxx | EA_ALL_TESTS_PASSED |
| 6100 | 0110 0001 0xxx xxxx | EA_RAM_ADDRESS |
| 6200 | 0110 0010 0xxx xxxx | EA_RAM_DATA |
| 6300 | 0110 0011 0xxx xxxx | EA_RAM_DEAD_OUTPUT |
| 6400 | 0110 0100 0xxx xxxx | EA_RAM_UNWRITABLE |
| 6500 | 0110 0101 0xxx xxxx | EA_YM2151_ALREADY_BUSY |
| 6600 | 0110 0110 0xxx xxxx | EA_YM2151_BUSY |
| 6700 | 0110 0111 0xxx xxxx | EA_YM2151_TIMERB |
| 6800 | 0110 1000 0xxx xxxx | EA_YM2151_DEAD_OUTPUT |
| 6900 | 0110 1001 0xxx xxxx | EA_OKI6295_ALREADY_PLAYING |
| 6a00 | 0110 1010 0xxx xxxx | EA_OKI6295_NO_PLAY |
| 6b00 | 0110 1011 0xxx xxxx | EA_OKI6295_DEAD_OUTPUT |
| 6f00 | 0110 1111 0xxx xxxx | EA_UNEXPECTED_IRQ |
