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
		jr	z, .test_passed_ram_oe
		jp	EA_RAM_DEAD_OUTPUT
	.test_passed_ram_oe:

		PSUB	ram_we_test
		jr	z, .test_passed_ram_we
		jp	EA_RAM_UNWRITABLE
	.test_passed_ram_we:

		PSUB	ram_data_tests
		jr	z, .test_passed_ram_data
		jp	EA_RAM_DATA
	.test_passed_ram_data:

		PSUB	ram_address_test
		jr	z, .test_passed_ram_address
		jp	EA_RAM_ADDRESS
	.test_passed_ram_address:


		jp	EA_ALL_PASSED
test_psub:
	ld	a,$44
	PSUB_RETURN
