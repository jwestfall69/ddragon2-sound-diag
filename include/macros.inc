        macro PSUB
                ld	hl, \1_psub
                ld	de, .\@
                rst	RST_PSUB_ENTER
.\@:
        endm

        macro PSUB_RETURN
                rst	RST_PSUB_EXIT
        endm

	macro STALL
.\@
		jp .\@
	endm
