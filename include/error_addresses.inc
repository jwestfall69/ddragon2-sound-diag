; On z80's A0 to A6 are used for memory refresh and will contantly pulsing,
; so they are unuseable for part of the error address.  That leaves us with
; the upper 9 address lines.  To make life easier we will just use the
; upper 8 address lines to give us a single byte.  The error address range
; is restricted to 0x6000 to 0x7ffff which forces the upper 3 address lines
; to be 011.  This will leave us 5 bits for possible error addresses

EA_ALL_TESTS_PASSED		equ $7a00

EA_RAM_ADDRESS			equ $6100
EA_RAM_DATA			equ $6200
EA_RAM_DEAD_OUTPUT		equ $6300
EA_RAM_UNWRITABLE		equ $6400

EA_YM2151_ALREADY_BUSY		equ $6500
EA_YM2151_BUSY			equ $6600
EA_YM2151_TIMERB		equ $6700
EA_YM2151_DEAD_OUTPUT		equ $6800

EA_OKI6295_ALREADY_PLAYING	equ $6900
EA_OKI6295_NO_PLAY		equ $6a00
EA_OKI6295_DEAD_OUTPUT		equ $6b00

EA_UNEXPECTED_IRQ		equ $6f00
