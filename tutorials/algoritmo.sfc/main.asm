// Fazer uma lista de numeros e percorrer ela procurando um numero especifico que exista na lista

arch snes.cpu

fill $200000

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

include "snes-header.asm" // Include Header & Vector Table

constant listNumPtr =  $0010

seek($8000)
    clc
    xce
    nop
    rep #$30  // 16 bits
    
    lda #listNumPtr // #: pega o valor literal que esta em listNum 
    sta $0000 // coloca o valor de A no sta

    sep #$10  // X e Y 8 bits
    ldx #$10

    setList:
        clc
        adc #$0002          // soma = 2 ao A em 16 bits
        sta $0000           // Salva o valor de A na posição especificada na memoria RAM

        txa                 // Trasfere o valor de X para A
        adc #$0010          // Realizo a soma +10

        tax                 // Transfiro o valor atualizado de A para X
        lda $0000           // Pego o valor do A da memoria

        stx $00           // Pega o valor salvo na posição da memoria 
        

    bra setList



-;
    bra -