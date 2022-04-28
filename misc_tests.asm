	include "ddragon2_sound.inc"
	include "ddragon2_sound_diag.inc"
	include "macros.inc"

	global main_cpu_latch_oe_test

	section text

main_cpu_latch_oe_test:
		ld	bc, MMIO_MAIN_CPU_LATCH
		PSUB	memory_oe_test
		ret

