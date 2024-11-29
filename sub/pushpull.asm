// Preserve values of accumulator, x and y
// Untested :)

push:
		pha		// push accumulator

		txa		// push x to a
		pha		// push x to the stack

		tya		// push y to a
		pha		// push y to the stack
		rts

pull:
		pla		// pull a from stack
		tay		// restore to y

		pla		// pull a from stack
		tax		// restore to x

		pla		// restore accumulator
		rts
