	include "ddragon2_sound.inc"

	global handle_irq
	global handle_nmi

	section text

handle_irq:
handle_nmi:
	reti
