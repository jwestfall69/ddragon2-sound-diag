RST_ENTRY		equ $00
RST_IRQ			equ $38
RST_NMI			equ $66

RAM_START		equ $8000
RAM_SIZE		equ $800
RAM_ADDRESS_LINES	equ 11

MMIO_YM2151_ADDRESS	equ $8800
MMIO_YM2151_DATA	equ $8801

MMIO_OKI6295		equ $9800

MMIO_MAIN_CPU_LATCH	equ $a000

YM2151_BUSY_BIT		equ $80

YM2151_REG_CLKA1	equ $10
YM2151_REG_CLKA2	equ $11
YM2151_REG_CLKB		equ $12
YM2151_REG_TIMER	equ $14

OKI6295_PHRASE_SEL_BIT	equ $80
OKI6295_CHANNEL1	equ $1
OKI6295_CHANNEL2	equ $2
OKI6295_CHANNEL3	equ $4
OKI6295_CHANNEL4	equ $8
