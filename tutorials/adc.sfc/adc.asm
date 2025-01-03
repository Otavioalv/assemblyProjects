arch snes.cpu
fill $200000

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}



//  soma 
//  A = 1
//  n = 1
//  C = 1

//  soma = A + n + C
//  exp: 
//    1 + 1 + 1 = 3
//    1 + 1 + 0 = 2
//  (necessario zerar a flag C)

//  subtração
//  sub = A - n + C - 1
//    6 - 2 + 1 - 1 = 4
//    6 - 2 + 0 - 1 = 3
//  (necessario adicionar a flag C)


include "snes-header.asm" // Cabeçalho do snes

// Configura o inicio da ROM no banco de sistema, no endereço $8000
seek($8000)
    clc                     // Limpa o carry flag (calculos aritimeticos corretos)
    xce                     // Troca para o modo nativo 
    nop                     // "no operation"
    rep #$30                // Configura o registradoa A, X e Y para 16 bits
    
    // adc
    lda #$1000              // Tranafere o valor para A
    clc                     // limpa flag C
    adc #$1234              // soma o valor com A

    // memoria/sbc
    tax                     // Transfere o valor de A para X
    lda #$1000              // Transfere o valor para A
    sta $0000               // Salva o valor de a na memoria especificada
    txa                     // Transfere o valor de X para A
    sec                     // Seta o valor 1 na flag C
    sbc $0000               // Subtrai o A em em (16 bits) que e C com o valor especificado

    // inc
    inc                     // incrementa A em (16 bits) que e C
    inc $0000               // incrementa o valor na posição na memoria especificada

    // dec
    dec                     // Decrementa o A em (16 bits) que e C
    dec $0000               // Decrementa o valor na posição da memoria especificada

    // X e Y (não tem add e sbc pro X e Y)
    inx                     // Incrementar X
    iny                     // Incrementar Y
    dex                     // Decrementar X
    dey                     // Decrementar Y

    // Carry do adc
    lda #$0001              // Transfere o valor para A
    sec                     // Seta  C
    adc #$0001              // Realiza soma com o valor especificado + A

    // Carry do sbc
    lda #$0005              // Transfere o valor para A
    clc                     // limpa a flag C
    sbc #$0001              // Subtrai A como o valor especificado

    // Atuação nas flags
    lda #$7fff              // Transfere o valor para A
    inc                     // Soma 1 com A em 16 bits

    lda #$ffff              // Transfe o valor para A
    inc                     // Soma 1 com A em 16 bits

    lda #$1000              // Tranafere o valor para A
    sec                     // Seta C
    sbc #$1000              // Subtrai A em 16 bits com o valor especificado

-   
    bra -

