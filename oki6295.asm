	include "ddragon2_sound.inc"
	include "macros.inc"

	global oki6295_playing_test
	global oki6295_play_test

	section text

; we haven't told the oki6295 to play anything
; so sound channels should be inactive
oki6295_playing_test:
		ld	a, (MMIO_OKI6295)
		and	a, $f			; lower 4 bits are the channels
		jr	nz, .test_failed

		xor	a
		ret

	.test_failed:
		xor	a
		inc	a
		ret

; tell the oki6295 to play something and
; verify it says its playing
oki6295_play_test:
		ld	a, $82
		call	oki6295_write_byte

		ld	a, $80
		call	oki6295_write_byte

		ld	a, (MMIO_OKI6295)
		and	a, $f

		; tell the oki to stop playing the test sound
		push	af
		ld	a, $0
		call	oki6295_write_byte
		pop	af

		cp	a, $8
		jr	nz, .test_failed

		xor	a
		ret

	.test_failed:
		xor	a
		inc	a
		ret
