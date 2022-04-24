	include "ddragon2.inc"
	include "error_addresses.inc"
	include "macros.inc"

	section text

	global ram_oe_test_psub
	global ram_we_test_psub
	global ram_data_tests_psub
	global ram_address_test_psub

; returns:
;  Z = 0 (error), 1 = (pass)
;  a = error code or 0 if passed
ram_oe_test_psub:
		ld	hl, RAM_START
		ld	de, RAM_START

	; When ram doesn't output anything on a read it usually results in the target
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
		PSUB_RETURN

	.test_failed:
		xor	a
		inc	a
		PSUB_RETURN

; returns:
;  Z = 0 (error), 1 = (pass)
;  a = error code or 0 if passed
ram_we_test_psub:
		ld	hl, RAM_START

	; read/save a byte from ram, write !byte back to the location,
	; re-read the location and error if it still the original byte
		ld	a, (hl)
		ld	b, a
		xor	$ff
		ld	(hl), a
		ld	a, (hl)
		cp	b
		jr	z, .test_failed

		xor	a
		PSUB_RETURN

	.test_failed:
		xor	a
		inc	a
		PSUB_RETURN

; returns:
;  Z = 0 (error), 1 = (pass)
;  a = error code or 0 if passed
ram_data_tests_psub:
		ld	c, $00
		PSUB	test_ram_data_pattern
		jr	nz, .test_failed

		ld	c, $55
		PSUB	test_ram_data_pattern
		jr	nz, .test_failed

		ld   	c, $aa
		PSUB	test_ram_data_pattern
		jr   	nz, .test_failed

		ld	c, $ff
		PSUB	test_ram_data_pattern
		jr	nz, .test_failed

		xor	a
		PSUB_RETURN

	.test_failed:
		xor	a
		inc	a
		PSUB_RETURN

; Write an incrementing data value at incrementing addresses
; returns:
;  a = 0 (pass), 1 (fail)
;  Z = 1 (pass), 0 (fail)
ram_address_test_psub:
		ld	hl, RAM_START
		ld	b, RAM_ADDRESS_LINES
		ld	a, $1
		ld	de, $1

		ld	(hl), a
		inc	a

	.loop_next_write_address:
		ld	hl, RAM_START
		add	hl, de

		ld	(hl), a
		inc	a
		rl	e
		rl	d
		djnz	.loop_next_write_address

		ld	hl, RAM_START
		ld	b, RAM_ADDRESS_LINES
		ld	a, $1
		ld	de, $1

		cp	(hl)
		jr	nz, .test_failed
		inc	a

	.loop_next_read_address:
		ld	hl, RAM_START
		add	hl, de

		cp	(hl)
		jr	nz, .test_failed
		inc	a
		rl	e
		rl	d
		djnz	.loop_next_read_address

		xor	a
		PSUB_RETURN

	.test_failed:
		xor	a
		inc	a
		PSUB_RETURN

; params:
;  c = pattern
; returns:
;  a = 0 (pass), 1 (fail)
;  Z = 1 (pass), 0 (fail)
test_ram_data_pattern_psub:
		ld	hl, RAM_START
		ld	de, RAM_SIZE

	.loop_next_address:
		ld	a, c
		ld	(hl), a
		cp	(hl)
		jr	nz, .test_failed_abort
		inc	hl
		dec	de
		ld	a, d
		or	e
		jr	nz, .loop_next_address

		xor	a
		PSUB_RETURN

	.test_failed_abort:
		xor	a
		inc	a
		PSUB_RETURN
