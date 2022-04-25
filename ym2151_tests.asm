	include "ddragon2_sound.inc"
	include "ddragon2_sound_diag.inc"
	include "error_addresses.inc"
	include "macros.inc"

	global ym2151_oe_test
	global ym2151_busy_bit_test
	global ym2151_unexpected_irq_test
	global ym2151_timerb_test

	section text

ym2151_oe_test:
		ld	hl, MMIO_YM2151_DATA
		ld	de, MMIO_YM2151_DATA

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

		xor	a
		ld	(g_irq_seen), a

		ei

		ld	bc, $ffff
		call	delay

		di

		ld	a, (g_irq_seen)

		jr	nz, .test_failed

		xor	a
		ret

	.test_failed:
		xor	a
		inc	a
		ret


ym2151_timerb_test:

		xor	a
		ld	(g_irq_seen), a

		; setup timerb to fire every 10ms like the game
		ld	bc, YM2151_REG_CLKB << 8 | $dd
		call	ym2151_write_register

		; enable timerb with ints
		ld	bc, YM2151_REG_TIMER << 8 | $3a
		call	ym2151_write_register

		ei

		ld	bc, $ffff
		call	delay

		di

		ld	a, (g_irq_seen)
		cp	0

		jr	z, .test_failed

		xor	a
		ret

	.test_failed:
		xor	a
		inc	a
		ret
