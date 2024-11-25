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

start:	
		SetBorderColor(BLACK)
		SetBackgroundColor(BLACK)	

		jsr robo_init

gameloop: 	
		jsr robo_waiting
		jmp gameloop
	//	rts

//// MACROS
.macro SetBorderColor(color) { 
		lda #color
		sta $d020
}

.macro SetBackgroundColor(color) {
		lda #color
		sta $d021
}

//// SUBROUTINES
delay:
		ldx #$ff
	delay_loop1:
		ldy #$ff
	delay_loop2:
		dey
		bne delay_loop2
		dex
		bne delay_loop1
		rts

robo_init:	
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
		rts	

robo_waiting:	
	display_robo_still_eyesleft:
                ldx #$80
		stx $07f8	// sprite data pointer 
		jsr delay
		jsr delay
	display_robo_still_eyesright:
                ldx #$81
                stx $07f8
		jsr delay
                rts

//// ROBO SPRITES
* = $2000 "Sprite 0"
#import "spr_robo.asm"

