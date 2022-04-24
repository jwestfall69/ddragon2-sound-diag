	include "ddragon2_sound.inc"
	include "error_addresses.inc"
	include "macros.inc"

	global _start

	section text

_start:

		di

		ld	a,(MMIO_MAIN_CPU_LATCH)

		PSUB	ram_oe_test
		jp	nz, EA_RAM_DEAD_OUTPUT

		PSUB	ram_we_test
		jp	nz, EA_RAM_UNWRITABLE

		PSUB	ram_data_tests
		jp	nz, EA_RAM_DATA

		PSUB	ram_address_test
		jp	nz, EA_RAM_ADDRESS

		; ram seems good, init stack
		ld	sp, RAM_START + RAM_SIZE - 2

		call	ym2151_oe_test
		jp	nz, EA_YM2151_DEAD_OUTPUT

		call	ym2151_busy_bit_test
		jp	nz, EA_YM2151_ALREADY_BUSY

		jp	EA_ALL_PASSED
