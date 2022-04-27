	include "ddragon2_sound.inc"
	include "ddragon2_sound_diag.inc"

	global handle_irq
	global handle_nmi

	section text

; interrupt from ym2151 timer
handle_irq:
		push	af
		exx

		ld	a, $1
		ld	(g_irq_seen), a

		; reset timer
		ld	bc, YM2151_REG_TIMER << 8 | $3a
		call	ym2151_write_register

		exx
		pop	af
		ei
		reti

; If the user has the game rom installed in the main cpu its going to be
; generating nmi's to play sounds.  Best we can really do is jump to our
; _start and never ack or return from the nmi.  This should ignore any
; additional nmi's and allow us to complete testing and remain at the
; error address.
handle_nmi:
		jp	_start
