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

    // Meu do while loop
    +;
        lda #$0004
        sta energyPtr

        doWhile:
            dec
            sta energyPtr
            lda energyPtr
            
            cmp #0
        bne doWhile  // not equal
    
    // Meu for loop
    lda #$0000
    sta energyPtr

    for:
        cmp #5
        beq +
        
        inc 
        sta energyPtr
        lda energyPtr
    bra for


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
