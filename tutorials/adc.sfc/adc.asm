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
    