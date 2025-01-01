arch snes.cpu

fill $200000

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

include "snes-header.asm" // Include Header & Vector Table


//  branch e jump, 
//
//  brc: pulo relativo, e relativo de acordo com uma quantidade em decimal
//      util para pequenos pulos
//  jmp: absoluto, de acordo com a posição da memoria
//      util para longos pulos fixos
//
//  label
//  lable sao marcações feitas no codigo para facilitar a localização na memoria
//  labels não sao transformadas em binario, pois e so uma marcação no codigo
//  label nomeada
//      pode ser qulquer nome: <nomelabel>:
//  label de sinal
//      isso e do proprio assembler, ele identifica os sinais, e atribui como label)
//      + vai para baixo 
//      - vai para cima
//      <sinal>;

seek($8000)
    clc
    xce
    nop
    rep #$30

    lda  #$0001

    label1: // pode ser qualquer nome (label nomeada)
        clc
        adc #$0001
        bra label2
        -; // label em forma de sinal
            nop
            nop 
            nop
            jmp + 

    label2:  // pode ser qualquer nome
        clc
        adc #$0002
        bra - // pula pra label (-) acima
        +;
            clc
            adc #$0001
            jmp $8000 // pula para o inicio do programa

-; 
    bra -

