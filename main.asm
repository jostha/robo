//// NOTES

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



//// VARIABLES

// These are to reuse the joystick and sprite routines
// to allow two players without code duplication

.var joy1 = $dc00
.var joy2 = $dc01


//// PROG

		BasicUpstart2(start)
		*=$08f0 "Main Code"
		robox:	.byte 100	// in order to reuse subr
		roboy:	.byte 100	// these temp vars are used
		robo0x:	.byte 100
		robo0y:	.byte 100
		robo1x:	.byte 100
		robo1y:	.byte 100
		joy:	.byte 0	

		// sprite animation counter and arrays
		spr_tbl_pos:	.byte 0		// counter
		spr0_rw_pos:	.byte 0		// counter
		spr1_rw_pos:	.byte 0		// counter
		ldx #$00
		stx spr_tbl_pos
		spr_table:	.byte $80	 
				.byte $84, $84, $84, $84, $85, $85, $85, $85, $86, $86, $86, $86, $85, $85, $85, $85
				.byte $87, $87, $87, $87, $88, $88, $88, $88, $89, $89, $89, $89, $88, $88, $88, $88
			// ^ spr 0 and 1 anim frames	00     looking forward
			//				01-16  walking right
			//				17-32  walking left

start:	

		SetBorderColor(BLACK)
		SetBackgroundColor(BLACK)	
		jsr cls

		jsr robo_init

game_loop: 	
		lda joy1	// Player 1
		sta joy
		ldx robo0x
		stx robox
		ldy robo0y
		sty roboy
		ldx spr0_rw_pos
		stx spr_tbl_pos
		jsr input_joy	// check for joystick input
		ldx robox	// transfer appropriate values
		stx robo0x
		ldy roboy
		sty robo0y
		ldx spr_tbl_pos
		stx spr0_rw_pos

		lda joy2	// Player 2
		sta joy
		ldx robo1x
		stx robox
		ldy robo1y
		sty roboy
		ldx spr1_rw_pos
		stx spr_tbl_pos
		jsr input_joy	// check for joystick input
		ldx robox
		stx robo1x
		ldy roboy
		sty robo1y
		ldx spr_tbl_pos
		stx spr1_rw_pos

		jsr draw_stuff
	//	jsr robo_waiting
		jmp game_loop
	//	rts


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

draw_stuff:
		jsr wait_vsync

		ldx robo0x	// draw spr 0
		ldy robo0y
		stx $d000	
		sty $d001
		ldx spr0_rw_pos
		lda spr_table, x
		sta $07f8

		ldx robo1x	// draw spr 1
		ldy robo1y
		stx $d002	
		sty $d003
		ldx spr1_rw_pos
		lda spr_table, x
		sta $07f9

		rts

input_joy:

// joystick bits
// bit 0: up            1
// bit 1: down		2
// bit 2: left		4
// bit 3: right		8
// bit 4: fire		16

// lda $dc01       // read joy port 1
// lda $dc00       // read joy port 2

		lda joy		// joy is defined in main loop
tax 		// store value in x as later checks will affect accumulator 
	joy_read:
		txa
		and #%00000001
		beq joy_up

		txa
		and #%00000010
		beq joy_down

		txa
		and #%00000100
		beq joy_left

		txa
		and #%00001000
		beq joy_right

		jmp nothing_pressed

	joy_up:
		lda roboy	// read y
		cmp #$00	// check not at minimum
		beq no_move_y
		dec roboy
		rts		

	joy_down:
		lda roboy	// read y
		cmp #$ff	// check not at maximum
		beq no_move_y
		inc roboy
		rts		

	joy_left:
		lda robox	// read x
		cmp #$00	// check not at minimum
		beq no_move_x
		dec robox
		lda spr_tbl_pos
		cmp #16
		bcc reset_spr_lw_pos
		cmp #32
		bcs reset_spr_lw_pos	// start animation again
		inc spr_tbl_pos	
		rts		

	joy_right:
		lda robox	// read x
		cmp #$ff	// check not at maximum
		beq no_move_x
		inc robox
		lda spr_tbl_pos
		cmp #00
		bcc reset_spr_rw_pos
		cmp #17
		bcs reset_spr_rw_pos	// start animation again
		inc spr_tbl_pos	
		rts		

	reset_spr_lw_pos:	// return to frame 1 for rw (right walk)
		ldx #$16
		stx spr_tbl_pos
		rts

	reset_spr_rw_pos:	// return to frame 1 for rw (right walk)
		ldx #$01
		stx spr_tbl_pos
		rts

	joy_fire:
	no_move_x:
	no_move_y:
		rts

	nothing_pressed:
		ldx #$00	// if not moving this frame face forward (0 in sprite table)
		stx spr_tbl_pos
		rts

	
robo_init:	
		ldx #$80
		stx $07f8	// sprite 0 data pointer 
		stx $07f9	// sprite 1 data pointer (same sprite data) 
		ldy #%00000011
		sty $d015	// sprite 0 enabled

		ldx robo0x
		stx $d000	// sprite 0x
		ldy robo0y
		sty $d001	// sprite 0y

		ldx robo1x
		stx $d002	// sprite 1x
		ldy robo1y
		sty $d003	// sprite 1y 

		lda #%00000011  // Enable multicolor mode for sprite 0 & 1
		sta $d01C

                lda #WHITE      // sprite multicolor register 1
                sta $d025
                lda #DARK_GREY  // sprite multicolor register 2
                sta $d026
		lda #LIGHT_GREY // sprite 0 colour
		sta $d027

		lda #ORANGE 	// sprite 1 colour
		sta $d028

		ldx #100
		stx robo0x
		stx robo0y

		ldx #60
		stx robo1x
		stx robo1y

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
* = $2000 "Sprites"
#import "spr_robo.asm"
#import "macros.asm"
#import "sub/cls.asm"
#import "sub/pushpull.asm"

