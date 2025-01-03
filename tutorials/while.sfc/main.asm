arch snes.cpu

fill $200000

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

include "snes-header.asm" // Include Header & Vector Table

constant energyPtr = $7F1000 // meu while

seek($8000)
    clc 
    xce
    nop
    rep #$30

    // Meu while
    lda #$0005
    sta energyPtr
    
    whileLoop:
        cmp #0
        beq +

        dec 
        sta energyPtr
        lda energyPtr

        bra whileLoop
    +;  
        nop
        nop
        nop
        nop
        bra gameover

    // fim meu while

    gameover:
        -;
            bra -
