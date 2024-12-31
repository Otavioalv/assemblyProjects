arch snes.cpu
fill $200000

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

include "snes-header.asm" // Cabeçalho do snes

seek($8000)
    clc 
    xce
    nop
    rep #$30            // 16 bytes

    lda #$1234          // Adiciona valor para A
    sta $0000           // Guarda valor de A na memoria

    sep #$20            // 8 bytes
    lda #$12            // Adiciona valor para A
    sta $0010           // Salva na memoria
    rep #$20            // 16 bytes

    lda #$0000          // Adiciona valor para A
    lda $0000           // Adiciona valor da memoria expecificada para A

    lda #$0002          // Adiciona valor para A
    sta $0020           // Salva valor de A na memoria
    sep #$20            // 8 bytes
    lda $0020           // Adiciona valor da memoria para A
    rep #$20            // 16 bytes

    // Acessar endereço de 3 bytes
    lda #$beef          // Adiciona valor para A
    sta $0050           // Salva valor de A na memoria

    lda #$0050          // Adiciona valor para A
    sta $0000           // Salva valor de A na memoria
    lda #$007e          // Adiciona valor para A
    sta $0002           // Salva valor de A na memoria
    
    // neste exp o endereço que foi salvo foi (7e 0050)
    lda [$00]           // E passado o endereço da RAM, e pega o endereço em 
                        // 24 bits. Com base nesse endereço ele vai nele e 
                        // pega o valor e joga no A

- 
    bra -