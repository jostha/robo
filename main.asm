BasicUpstart2(start)

.include "robo.asm"

start:		SetBorderColor(BLACK)
		SetBackgroundColor(BLACK)	

loop1:

		ldx #$80
		stx $07f8	// sprite pointer 1
		ldy #%00000001
		sty $d015	// sprite 1 enabled

		stx $d000	// sprite 1x
		stx $d001	// sprite 1y (both set to 128 (from #$80 above))

		//	lda #$08 // sprite multicolor 1
		//	sta $D025
		//	lda #$06 // sprite multicolor 2
		//	sta $D026
		jmp	loop1

// A little macro
.macro SetBorderColor(color) {		// <- This is how macros are defined
	lda #color
	sta $d020
}

// A little macro
.macro SetBackgroundColor(color) {		// <- This is how macros are defined
	lda #color
	sta $d021
}
