arch snes.cpu
fill $200000

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

include "snes-header.asm" // Cabeçalho do snes

constant endPtr = $0000

seek($8000)
    clc 
    xce
    nop
    rep #$30

    lda #$ffff
    sta endPtr

    ldx $0000
    lda (endPtr)

    reset:
      cmp #$0000
      lda #$0000
      sta (endPtr)
      lda endPtr
      sbc #$0002
      sta endPtr
    bne reset

    lda #'H'
    sta $0000

    lda #'E'
    sta $0001

    lda #'L'
    sta $0002

    lda #'L'
    sta $0003

    lda #'O'
    sta $0004

    lda #' '
    sta $0005

    lda #'W'
    sta $0006

    lda #'O'
    sta $0007

    lda #'R'
    sta $0008
    
    lda #'L'
    sta $0009

    lda #'D'
    sta $000A

-;
    bra -