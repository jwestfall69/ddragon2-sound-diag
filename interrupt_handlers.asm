	include "ddragon2_sound.inc"
	include "ddragon2_sound_diag.inc"

	global handle_irq
	global handle_nmi

	section text

; interrupt from ym2151 timer
handle_irq:
		exx
		ld	hl, (g_irq_count)
		inc	hl
		ld	(g_irq_count), hl
		exx
		reti

handle_nmi:
		reti
