BasicUpstart2(start)

joy2_info:	
	.byte 0

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
		jsr input_joy2	// check for joystick input
	//	jsr robo_waiting
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

input_joy2:

// joystick bits
// bit 0: up            1
// bit 1: down		2
// bit 2: left		4
// bit 3: right		8
// bit 4: fire		16

		jsr wait_vsync

//		lda $dc01       // read joy port 1
		lda $dc00       // read joy port 2
		tax 		// store value in x as later checks will affect accumulator 

	joy2_read:
		txa
		and #%00000001
		beq joy2_up

		txa
		and #%00000010
		beq joy2_down

		txa
		and #%00000100
		beq joy2_left

		txa
		and #%00001000
		beq joy2_right

		rts

	joy2_up:
		lda $d001	// read y
		cmp #$00	// check not at minimum
		beq no_move_y
		sec		// set carry flag for subtraction
		sbc #$01	// subtract from y
		sta $d001	// new y
		rts		

	joy2_down:
		lda $d001	// read y
		cmp #$ff	// check not at maximum
		beq no_move_y
		clc		// clear carry flag for addition
		adc #$01	// add to y
		sta $d001	// new y
		rts		

	joy2_left:
		lda $d000	// read x
		cmp #$00	// check not at minimum
		beq no_move_x
		sec		// set carry flag for subtraction
		sbc #$01	// sub from x
		sta $d000	// new x
		rts		

	joy2_right:
		lda $d000	// read x
		cmp #$ff	// check not at maximum
		beq no_move_x
		clc		// clear carry flag
		adc #$01	// add to x
		sta $d000	// new x
		rts		


	joy2_fire:
	no_move_x:
	no_move_y:
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

wait_vsync:
		lda $d012	// read raster line
		cmp #$ff	// compare with last line of screen
		bne wait_vsync	// wait until raster line hits bottom of screen
		rts

//// ROBO SPRITES
* = $2000 "Sprite 0"
#import "spr_robo.asm"

