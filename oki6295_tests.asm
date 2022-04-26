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

; Information about the start/stop addresses of sound
; samples are stored in array of data at the start of
; the ADPCM rom space.  The array consists of 128 of
; the following struct;
; struct phrase {
;   uint8_t start_addr[3];
;   uint8_t end_addr[3];
;   uint8_t pad[2]; // 0 filled
; }
; The oki6295 doesn't allow the use of phrase 0, so
; this allows for 127 different adpcm sounds.
;
; When wanting to play a sound you need to send 2 bytes
; to the oki6295 MMIO address.
;  byte 1 = OKI6295_PHRASE_SEL_BIT | phrase #
;  delay
;  byte 2 = channel bit << 4 | volume reduction value
;
; tell the oki6295 to play something and
; verify it says its playing
oki6295_play_test:
		ld	a, OKI6295_PHRASE_SEL_BIT | $2
		call	oki6295_write_byte

		ld	a, OKI6295_CHANNEL4 << 4
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
