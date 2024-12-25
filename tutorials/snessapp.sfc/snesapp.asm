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
    xce                     // Toca para o modo nativo 
    nop                     // "no operation"
    rep #$30                // Configura o registradoa A, X e Y para 16 bits
    
    // inicia com (#): imediato
    // não inicia com (#): endereço
    // Load and Store (pratica)
    // Instruçoes: <mneumonicos> <parametros>
    lda #$0001              // (Load A) carrega valor ao registrador A
    lda #$abcd              // (Load A) Sobrescreve o valor de A
    sta $0000               // (Store A) Armazena A no endereço expecificado para a RAM 
    sta $7e0010             // (Store A) Armazena A no endereço expecificado para a RAM
    
    ldx #$1234              // (Load X) Carrega valor ao registrador X
    ldy $0010               // (Load Y) Carrega valor ao registrador Y
    stx $0020               // (Store X) Armazena valor de X no endereço expecificado para a RAM
    sty $0028               // (Store y) Armazena o valor de Y no endereço expecificado para a RAM

    stz $0010               // (Store zero) Armazena o valor 0 no endereço especificado para a RAM
-
    bra -