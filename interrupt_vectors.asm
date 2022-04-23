	include "ddragon2.inc"

	section vectors,"rodata"

	roffs	RST_ENTRY
	jp	_start

	roffs	RST_IRQ
	jp	handle_irq

	roffs	RST_NMI
	jp	handle_nmi
