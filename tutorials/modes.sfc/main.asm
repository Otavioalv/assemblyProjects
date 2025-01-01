// vim: ft=snes
arch snes.cpu

fill $200000

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

include "snes-header.asm" // Include Header & Vector Table

 
    // Quando o Status Register esta como o valor 0, significa que e (16 bits)
    // Se ficar com o valor 1, significa que e (8 bits)

    // 0 = 16 bits
    // 1 = 8 bits

    // rep = (restart ep) acompanha como parametro o bits que vai setar como 0, 
    //     deixando todas as flags como 1, ficando somente o endereço da flag com 0

    // sep = (set ep) Acompanha como parametro o bits que vai setar como 1,
    //     deixando todas as flags com 0, ficando somente o enereço da flag com 1;

    // as flags que controlam os bits, sao as flags M e X
    // M -> controla o registradot A
    // X -> controla os registradores X e Y

    // # -> significa imediato
    // $ -> significa exadecimal
    // b -> significa binario

seek($8000)
    clc
    xce
    nop
    rep #$30                    // reinicia os registradores M e X, fazendo o sistema inteiro ficar em 16 bits

    lda #$1234                  
    sta $0000                  
    ldx $0000
    ldy $0000
    lda #$0078

    sep #$20                    // 8 bits
    sta $0010                   
    lda $0020               

    lda #$ff
    inc 

    rep #$20                    // 16 bits
    lda #$00ff
    inc
    
    ldx #$0000                  
    ldy #$0000

    sep #$10                    // X and Y now 8 bits
    ldx $0000
    ldy $0000
    ldx #$ff
    inx
    iny

    rep #$10

    // Full 16 bits

    // O registrador a tem 2 lados, A e B
    // cada lado tem 8 bits, juntando os dois,
    // ele se torna o C que e 16 bits
    // XBA, troca os lados dos, o A fica no B 
    // e vice-versa

    lda #$1234
    xba 

    lda #$8912
    xba


-
        bra -