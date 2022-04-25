	include "ddragon2_sound.inc"
	include "ddragon2_sound_diag.inc"

	global handle_irq
	global handle_nmi

	section text

; interrupt from ym2151 timer
handle_irq:
		ex	af, af'
		exx

		ld	a, $1
		ld	(g_irq_seen), a

		; reset timer
		ld	bc, YM2151_REG_TIMER << 8 | $3a
		call	ym2151_write_register

		exx
		ex	af, af'

		ei
		reti

handle_nmi:
		reti
