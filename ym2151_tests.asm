	include "ddragon2_sound.inc"
	include "ddragon2_sound_diag.inc"
	include "macros.inc"

	global ym2151_oe_test
	global ym2151_busy_bit_test
	global ym2151_unexpected_irq_test
	global ym2151_timera_test

	section text

ym2151_oe_test:
		ld	hl, MMIO_YM2151_ADDRESS
		ld	de, MMIO_YM2151_ADDRESS

	; When memory doesn't output anything on a read it usually results in the target
	; register, 'a' for us, containing the opcode of the ld.  Its not 100% and
	; will sometimes have $ff or other garbage, so we loop $64 times trying to
	; catch 2 in a row with different ld opcodes
		ld	b, $64
	.loop_next:
		ld	a, (hl)
		cp	$7e		; ld a, (hl) opcode
		jr	nz, .loop_pass

		ld	a, (de)
		cp	$1a		; ld a, (de) opcode
		jr	z, .test_failed

	.loop_pass:
		djnz	.loop_next

		xor	a
		ret

	.test_failed:
		xor	a
		inc	a
		ret

; we haven't done anything with the ym2151, so the
; busy bit shouldn't be set
; returns:
;  a = (0 = pass, 1 = fail)
ym2151_busy_bit_test:
		ld	hl, MMIO_YM2151_DATA
		ld	a,(hl)

		and	YM2151_BUSY_BIT
		jr	nz, .test_failed
		xor	a
		ret

	.test_failed:
		xor	a
		inc	a
		ret

; We have not yet enabled ym2151 timer so we
; shouldn't be getting any interrupts from it
ym2151_unexpected_irq_test:

		ld	hl, $0
		ld	(g_irq_count), hl

		ei

		ld	bc, $ffff
		call	delay

		di

		ld	hl, (g_irq_count)
		ld	bc, $0
		sbc	hl, bc

		jr	nz, .test_failed

		xor	a
		ret

	.test_failed:
		xor	a
		inc	a
		ret

ym2151_timera_test:
		xor	a
		ret
