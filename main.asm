BasicUpstart2(start)

// c64 colors
// BLACK       = $00
// WHITE       = $01
// RED         = $02
// CYAN        = $03
// PURPLE      = $04
// GREEN       = $05
// BLUE        = $06
// YELLOW      = $07
// ORANGE      = $08
// BROWN       = $09
// LIGHT_RED   = $0a
// DARK_GREY   = $0b
// GREY        = $0c
// LIGHT_GREEN = $0d
// LIGHT_BLUE  = $0e
// LIGHT_GREY  = $0f


start:		SetBorderColor(BLACK)
		SetBackgroundColor(BLACK)	

loop1:

		ldx #$80
		stx $07f8	// sprite data pointer 
		ldy #%00000001
		sty $d015	// sprite 0 enabled

		stx $d000	// sprite 0x
		stx $d001	// sprite 0y (both set to 128 (from #$80 above))

		lda #%00000001  // Enable multicolor mode for sprite 0
		sta $D01C

		lda #WHITE      // sprite multicolor register 1
		sta $D025
		lda #DARK_GREY  // sprite multicolor register 2
		sta $D026
		lda #LIGHT_GREY // sprite 0 colour
		sta $D027
		jmp loop1

// A little macro
.macro SetBorderColor(color) {  // <- This is how macros are defined
	lda #color
	sta $d020
}

// A little macro
.macro SetBackgroundColor(color) {  // <- This is how macros are defined
	lda #color
	sta $d021
}

//// ROBO SPRITES

* = $2000 "Sprite 0"

// sprite 0 / multicolor / color: $0f
chibi1:
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$aa,$5a,$aa,$ff,$ff,$ff,$29
.byte $6a,$a8,$29,$e9,$e8,$2b,$eb,$e8
.byte $09,$6a,$a0,$01,$6a,$80,$00,$3c
.byte $00,$00,$9a,$00,$0b,$9a,$e0,$08
.byte $9a,$20,$08,$9a,$20,$00,$c3,$00
.byte $00,$82,$00,$00,$82,$00,$00,$82
.byte $00,$00,$82,$00,$01,$81,$80,$8f

// sprite 1 / multicolor / color: $0f
chibi2:
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$aa,$5a,$aa,$ff,$ff,$ff,$29
.byte $6a,$a8,$2b,$6b,$68,$2b,$eb,$e8
.byte $09,$6a,$a0,$01,$6a,$80,$00,$3c
.byte $00,$00,$9a,$00,$0b,$9a,$e0,$08
.byte $9a,$20,$08,$9a,$20,$00,$c3,$00
.byte $00,$82,$00,$00,$82,$00,$00,$82
.byte $00,$00,$82,$00,$01,$81,$80,$8f

// sprite 2 / multicolor / color: $0f
chibi3:
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$aa,$5a,$aa,$ff,$ff,$ff,$29
.byte $6a,$a8,$29,$e9,$e8,$2b,$eb,$e8
.byte $09,$6a,$a0,$01,$6a,$80,$00,$3c
.byte $00,$00,$9a,$00,$0b,$9a,$e0,$08
.byte $9a,$20,$08,$9a,$20,$00,$c3,$00
.byte $00,$82,$00,$00,$82,$00,$00,$82
.byte $00,$01,$82,$00,$00,$81,$80,$8f

// sprite 3 / multicolor / color: $0f
chibi4:
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$aa,$5a,$aa,$ff,$ff,$ff,$29
.byte $6a,$a8,$2b,$eb,$e8,$2b,$6b,$68
.byte $09,$6a,$a0,$01,$6a,$80,$00,$3c
.byte $00,$00,$9a,$08,$0b,$9a,$e8,$08
.byte $9a,$00,$08,$9a,$00,$00,$c3,$00
.byte $00,$82,$00,$00,$82,$00,$00,$82
.byte $00,$00,$82,$00,$01,$81,$80,$8f

// sprite 4 / multicolor / color: $0f
chibi5:
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$aa,$5a,$aa,$ff
.byte $ff,$ff,$29,$6a,$a8,$29,$6b,$68
.byte $29,$6b,$e8,$09,$6a,$a0,$01,$6a
.byte $80,$00,$3c,$00,$00,$9a,$00,$00
.byte $9e,$00,$03,$9a,$80,$0c,$9a,$20
.byte $00,$ff,$00,$00,$28,$00,$00,$2c
.byte $00,$00,$83,$00,$01,$83,$c0,$8f

// sprite 5 / multicolor / color: $0f
chibi6:
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$aa,$5a,$aa,$ff,$ff,$ff,$29
.byte $6a,$a8,$29,$6b,$68,$29,$6b,$e8
.byte $09,$6a,$a0,$01,$6a,$80,$00,$3c
.byte $00,$00,$9a,$00,$00,$9e,$00,$00
.byte $9a,$00,$00,$9a,$00,$00,$ff,$00
.byte $00,$28,$00,$00,$2c,$00,$00,$08
.byte $00,$00,$ec,$00,$00,$d8,$00,$8f

// sprite 6 / multicolor / color: $0f
chibi7:
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$aa,$5a,$aa,$ff
.byte $ff,$ff,$29,$6a,$a8,$29,$6b,$68
.byte $29,$6b,$e8,$09,$6a,$a0,$01,$6a
.byte $80,$00,$3c,$00,$00,$9a,$00,$00
.byte $9e,$00,$02,$9a,$c0,$08,$9a,$30
.byte $00,$ff,$00,$00,$28,$00,$00,$38
.byte $00,$00,$c2,$00,$03,$c1,$80,$8f

// sprite 7 / multicolor / color: $0f
chibi8:
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$aa,$5a,$aa,$ff
.byte $ff,$ff,$29,$6a,$a8,$29,$ea,$a8
.byte $2b,$ea,$a8,$09,$6a,$a0,$01,$6a
.byte $80,$00,$3c,$00,$00,$9a,$00,$00
.byte $9e,$00,$03,$9a,$80,$0c,$9a,$20
.byte $00,$ff,$00,$00,$28,$00,$00,$2c
.byte $00,$00,$83,$00,$01,$83,$c0,$8f

// sprite 8 / multicolor / color: $0f
chibi9:
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$aa,$5a,$aa,$ff,$ff,$ff,$29
.byte $6a,$a8,$29,$ea,$a8,$2b,$ea,$a8
.byte $09,$6a,$a0,$01,$6a,$80,$00,$3c
.byte $00,$00,$9a,$00,$00,$9e,$00,$00
.byte $9a,$00,$00,$9a,$00,$00,$ff,$00
.byte $00,$28,$00,$00,$38,$00,$00,$20
.byte $00,$00,$3b,$00,$00,$1b,$00,$8f

// sprite 9 / multicolor / color: $0f
chibi10:
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$aa,$5a,$aa,$ff
.byte $ff,$ff,$29,$6a,$a8,$29,$ea,$a8
.byte $2b,$ea,$a8,$09,$6a,$a0,$01,$6a
.byte $80,$00,$3c,$00,$00,$9a,$00,$00
.byte $9e,$00,$02,$9a,$c0,$08,$9a,$30
.byte $00,$ff,$00,$00,$28,$00,$00,$38
.byte $00,$00,$c2,$00,$03,$c1,$80,$8f

// sprite 10 / multicolor / color: $0f
chibi11:
.byte $00,$00,$00,$00,$00,$00,$00,$28
.byte $00,$aa,$5a,$aa,$ff,$ff,$ff,$29
.byte $6a,$a8,$29,$e9,$e8,$2b,$eb,$e8
.byte $09,$6a,$a0,$01,$6a,$80,$00,$3c
.byte $00,$00,$9a,$00,$0b,$9a,$e0,$08
.byte $9a,$20,$08,$9a,$20,$00,$ff,$00
.byte $00,$28,$00,$00,$28,$00,$00,$28
.byte $00,$00,$28,$00,$00,$66,$00,$8f

// sprite 11 / multicolor / color: $0f
chibi12:
.byte $00,$00,$00,$00,$28,$00,$00,$28
.byte $00,$aa,$5a,$aa,$ff,$ff,$ff,$29
.byte $6a,$a8,$2b,$6b,$68,$2b,$eb,$e8
.byte $09,$6a,$a0,$01,$6a,$80,$00,$3c
.byte $00,$00,$9a,$00,$02,$9a,$80,$02
.byte $9a,$80,$03,$9a,$c0,$00,$3c,$00
.byte $00,$28,$00,$00,$28,$00,$00,$28
.byte $00,$00,$00,$00,$00,$00,$00,$8f

// sprite 12 / multicolor / color: $0f
chibi13:
.byte $00,$00,$00,$02,$6b,$80,$00,$28
.byte $00,$aa,$5a,$aa,$ff,$ff,$ff,$29
.byte $6a,$a8,$29,$e9,$e8,$2b,$eb,$e8
.byte $09,$6a,$a0,$01,$6a,$80,$00,$3c
.byte $00,$00,$9a,$00,$02,$9a,$80,$02
.byte $9a,$80,$03,$9a,$c0,$00,$3c,$00
.byte $00,$28,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$8f

// sprite 13 / multicolor / color: $0f
chibi14:
.byte $00,$00,$00,$29,$6a,$f8,$00,$28
.byte $00,$aa,$5a,$aa,$ff,$ff,$ff,$29
.byte $6a,$a8,$29,$e9,$e8,$2b,$eb,$e8
.byte $09,$6a,$a0,$01,$6a,$80,$00,$3c
.byte $00,$00,$9a,$00,$02,$9a,$80,$02
.byte $9a,$80,$03,$9a,$c0,$00,$3c,$00
.byte $00,$28,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$8f

