// Pass character to clear screen with in accumulator

cls:
		lda #$00
		tax
		lda #$20
	cls_loop:   
		sta $0400,x
		sta $0500,x
		sta $0600,x
		sta $0700,x
		dex
		bne cls_loop
		rts
