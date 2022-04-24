	include "ddragon2.inc"
	include "error_addresses.inc"
	include "macros.inc"

	global _start

	section text

_start:

		di
		im	1
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


		jp	EA_ALL_PASSED
