	global psub_enter
	global psub_exit

	section text


psub_enter:
		ld	a, r
		add	a, $80
		ld	r, a
		jp	p, .nested_call
		ld	ix, $0000
		add	ix, de
		jp	(hl)

	.nested_call:
		ld	iy, $0000
		add	iy, de
		jp	(hl)


psub_exit:
		ex	af, af'
		ld	a, r		; dont clobber a while we figure out what register
		add	a, $80		; to jp back to
		ld	r, a
		jp	m, .nested_return
		ex	af, af'
		jp	(ix)

	.nested_return:
		ex	af, af'
		jp	(iy)
