	section errors, "rodata"

	; fill the error secion with jr to self instructions
	blkw 0x1000,0xfe18
