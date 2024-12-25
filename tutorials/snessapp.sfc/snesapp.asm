arch snes.cpu
fill $200000

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

include "snes-header.asm" // Cabeçalho do snes

// Configura o inicio da ROM no banco de sistema, no endereço $8000
seek($8000)
    clc                     // Limpa o carry flag (calculos aritimeticos corretos)
    xce                     // Troca para o modo nativo 
    nop                     // "no operation"
    rep #$30                // Configura o registradoa A, X e Y para 16 bits
    
    // inicia com (#): imediato ou seja, vai salvar um valor
    // não inicia com (#): endereço, ou seja, pega o valor no endereço do banco
    // Load and Store (pratica)
    // Instruçoes: <mneumonicos> <parametros>
    lda #$0001              // (Load A) carrega valor ao registrador A
    lda #$abcd              // (Load A) Sobrescreve o valor de A
    sta $0000               // (Store A) Armazena A no endereço expecificado para a RAM 
    sta $7e0010             // (Store A) Armazena A no endereço expecificado para a RAM
    
    ldx #$1234              // (Load X) Carrega valor ao registrador X
    ldy $0010               // (Load Y) Carrega valor ao registrador Y (sem o #, pega o atual valor do endereço especificado)
    stx $0020               // (Store X) Armazena valor de X no endereço expecificado para a RAM
    sty $0028               // (Store y) Armazena o valor de Y no endereço expecificado para a RAM

    stz $0010               // (Store zero) Armazena o valor 0 no endereço especificado para a RAM


    tax                     // Transfere o valor de A para o X
    txy                     // Transfere o valor de X para o Y
    ldy #$bbbb            
    tya                     // Transfere o valor de Y para o A
    txa                     // Transfere o valor de X para o A
    tya                     // Transfere o valor de Y  para o A
    lda #$0100
    tcs                     // Transfere o A (8 bits) inteiro que e C (16 bits) para o S
    lda #$ffff
    tdc                     // Transfere oque ta no D para o A (8 bits) inteiro que e C (16 bits)
    lda #$1111              
    ldx #$2222 
    ldy #$3333
    
    // Pilha PUSH
    pha                     // push A, empilha o A
    phx                     // push X, empilha o X
    phy                     // push Y, empilha o Y

    // Pilha PULL
    plx                     // pull X, desempilha o ultimo valor empilhado para o X
    pla                     // pull A, desempilha o ultimo valor empilhado para o A

-
    bra -