	include "ddragon2_sound.inc"
	include "error_addresses.inc"
	include "macros.inc"

	global delay
	global oki6295_write_byte
	global ym2151_write_register
	global ym2151_not_busy
	global psub_enter
	global psub_exit

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

; a = byte
oki6295_write_byte:
		ld	(MMIO_OKI6295), a

	; this delay mimics what the ddragon2 sound code does
		ld	a, $64
	.loop_delay:
		dec	a
		jr	nz, .loop_delay

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

psub_enter:
		ld	a, r
		add	a, $80
		ld	r, a
		jp	p, .nested_call
		ld	ix, $0000
		add	ix, de
		jp	(hl)

	.nested_call:
		ld	iy, $0000
		add	iy, de
		jp	(hl)


psub_exit:
		ex	af, af'
		ld	a, r		; dont clobber a while we figure out what register
		add	a, $80		; to jp back to
		ld	r, a
		jp	m, .nested_return
		ex	af, af'
		jp	(ix)

	.nested_return:
		ex	af, af'
		jp	(iy)
