	include "ddragon2_sound.inc"
	include "error_addresses.inc"
	include "macros.inc"

	global delay
	global ym2151_write_register
	global ym2151_not_busy

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

; b = register
; c = value
ym2151_write_register:
		call	ym2151_wait_busy
		ld	hl, MMIO_YM2151_ADDRESS
		ld	(hl), b

		call	ym2151_wait_busy
		ld	hl, MMIO_YM2151_DATA
		ld	(hl), c

		ret

; wait for um2151 busy bit to not be set
; if it takes to long generate a EA_YM2141_BUSY
; error
ym2151_wait_busy:
		push	af
		push	hl
		push	de


		ld	hl, MMIO_YM2151_DATA
		ld	de, $1ff

	.loop_try_again:
		ld	a, (hl)
		and	YM2151_BUSY_BIT
		jr	z, .not_busy

		dec	de
		ld	a, d
		or	e
		jr	nz, .loop_try_again

		jp	EA_YM2151_BUSY

	.not_busy:
		pop	de
		pop	hl
		pop 	af
		ret
