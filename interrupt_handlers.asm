	include "ddragon2.inc"

	global handle_irq
	global handle_nmi

	section text

handle_irq:
handle_nmi:
	reti
