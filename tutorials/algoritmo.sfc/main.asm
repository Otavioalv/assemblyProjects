// Fazer uma lista de numeros e percorrer ela procurando um numero especifico que exista na lista

arch snes.cpu

fill $200000

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

include "snes-header.asm"   // Include Header & Vector Table

constant listNumPtr = $0000     // Inicion do ponteiro da lista de numeros
constant qtdLoopPtr = $0020    // Quantidade de loopings
constant tamListPtr = $0030    // Tamanho da lista do ponteiro
constant findNumPtr = $0040     // Numero que quero encontrar

seek($8000)
    clc
    xce
    nop
    rep #$30                // 16 bits
                            //
    lda #$001F               // #: pega o valor literal que esta em listNum 
    sta listNumPtr          // coloca o valor de A no sta
    tcs                     // seta o ponteiro da pilha com o valor em A

    lda #$0000              // Seta o valor 0
    sta qtdLoopPtr          // Salva 

    lda #$0005              // Define q quantidade de numeros
    sta tamListPtr          // Salva 

    lda #$0030              // Define o numero que quero procurar
    sta findNumPtr          // Salva na posição

    sep #$10                // X e Y 8 bits
    ldx #$10                // Adiciona valor inicial a X

    lda qtdLoopPtr
    setList:                //
        cmp tamListPtr
        beq +

        phx                 // empilha o valor de X
                            //
        txa                 // Trasfere o valor de X para A
        clc                 //
        adc #$0010          // Realizo a soma +10  
                            //
        tax                 // Transfiro o valor atualizado de A para X

        lda qtdLoopPtr
        inc
        sta qtdLoopPtr
    bra setList
    
    +;

    lda #$0000
    sta qtdLoopPtr

    searchNum:
        cmp findNumPtr
        beq +

        lda (listNumPtr)        // pega o endereço salvo na memoria, e usa como endereço pra acessar outra memoria
        

        
        lda qtdLoopPtr
        inc
        sta qtdLoopPtr
    bra searchNum

    +;
-;
    bra -