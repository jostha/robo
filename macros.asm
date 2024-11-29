//// MACROS

.macro SetBorderColor(color) { 
                lda #color
                sta $d020
}

.macro SetBackgroundColor(color) {
                lda #color
                sta $d021
}

