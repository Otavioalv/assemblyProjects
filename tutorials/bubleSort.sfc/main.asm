arch snes.cpu

fill $200000

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

include "snes-header.asm"   // Include Header & Vector Table








constant startListPtr = $0000     // Valor do inicio da lista
constant agoNumPtr = $0002      // Valor da posição anterior
constant nextNumPtr = $0004     // Valor da proxima posição

constant tamListPtr = $0020     // Tamanho da lista
constant qtdLoopPtr = $0022      // Quantidade de X do looping
constant qtdFinalLoopPtr = $0024    // Quanjtidade final do looping
constant swapNumPtr = $0026      // Valor para troca
constant stopPtr = $0028        // Valor indica fim da busca

seek($8000)
    clc                         // Limpa a Flag C
    xce                         // Coloca o valor de C para o E
    nop                          
    rep #$30                    // Define como 0 (16 bits) as Flags na posição especificada (0011 0000)

    lda #$001F                  // Define A com uma posição
    sta startListPtr            // Salva na memoria
    tcs                         // Transfere C(A) na flag S (pointer)

    lda #$0005                  // Tamanho da lista (0) conta
    sta tamListPtr              // Salva na memoria

    sep #$20

    // iniciar os valores da lista

    // 0
    lda #$80
    sta $001F
    // 1
    lda #$70
    sta $001E
    // 2
    lda #$70
    sta $001D
    // 3
    lda #$20
    sta $001C
    // 4
    lda #$40
    sta $001B
    // 5
    lda #$10
    sta $001A
    // Fim da lista


    


    // Realiza o boobleSort
    rep #$20
    
    lda #$0000                  //  Define a quantidade 0
    sta qtdLoopPtr              // Salva na memoria loop
    sta qtdFinalLoopPtr         // salva na memoria tot loop
    sta stopPtr                 // salva na memoria parar loop

    lda startListPtr            // Pega o valor do inicio da lista
    sta agoNumPtr               // Salva

    dec                         // Decrementa A
    sta nextNumPtr              // Salva
    
    bubbleSort: 
        sep #$20                    // Coloca em A(C) 8 bits
        
        lda (agoNumPtr)             // Pega o numero da pos
        cmp (nextNumPtr)            // Compara
        
        bpl +                       // Se for positivo, ele pula, se nao, ele ignora
            
            sta swapNumPtr          // salva o numero anterior na posição 
            
            lda (nextNumPtr)        // Pega o proximo numero
            sta (agoNumPtr)         // Salva na posição anterior

            lda swapNumPtr          // pega o numero anterior 
            sta (nextNumPtr)        // Salva na poxisão posterior

            rep #$20                // A(C) em 16 bits
            lda #$0001              // define 1
            sta stopPtr             // salva na pos
        +;
        rep #$20                    // Coloca A(C) em 16 bsits
        
        lda nextNumPtr              // Pega o valor (next pos)
        sta agoNumPtr               // Salvao no (ago Pos)

        dec                         // Decrementa (nextPos)
        sta nextNumPtr              // Salva no (ago Pos)
        
        // simulação looping FOR
        lda qtdFinalLoopPtr         // pega a qtd final de loop
        inc                         // incrementa
        sta qtdFinalLoopPtr         //salcva

        lda qtdLoopPtr              // pega a qtd de loop
        inc                         // incrementa
        sta qtdLoopPtr              // salva

        cmp tamListPtr
        bne +                       // Verifica se a flag Z esta com 0
            lda startListPtr            // Pega o valor do inicio da lista
            sta agoNumPtr               // Salva

            dec                         // Decrementa A
            sta nextNumPtr              // Salva

            // se stopPtr e 1 ele continua, se for 0 ele sai
            lda stopPtr                 // Pega o valor 
            cmp #$0000                  // Compara o valor com 0
            beq endProgram              // se for igual, 0, ele sai do looping

            lda #$0000                  // define 0
            sta qtdLoopPtr              // Salva na memoria
            sta stopPtr                 // Salva na memoria
        +;


    bra bubbleSort

    endProgram: 
        -;
            bra -


