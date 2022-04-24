	include "ddragon2_sound.inc"
	include "error_addresses.inc"
	include "macros.inc"

	global delay

	section text

; 3579545hz
; params
;  bc * ~10us = how long to delay
delay:
		push	af

	.delay_loop:
		dec	bc		; 6 cycles
		ld	a, c		; 4 cycles
		or	b		; 4 cycles
		jr	nz, .delay_loop	; 12 cycles

		pop	af
		ret

