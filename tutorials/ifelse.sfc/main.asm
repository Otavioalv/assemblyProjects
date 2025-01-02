arch snes.cpu
fill $200000

macro seek(variable offset) {
    origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
    base offset
}

include "snes-header.asm"

// cmp = compara com oque ta no registrador A 
//      (calcula o valor enviado com o valor do registrador A)
//      calculo feito: (val - A), 
//      (se for zero, a flag Z ativa sendo essa a comparação, 
//         pois 2 numeros iguais em uma subtração sempre sera 0)
//      (se o valor resulltado for negativo, a flag N ativa)

// bne = (branch not equal), verifica se a flag Z == 0, 
//      se for 0, ele execulta, se nao ele ignora
//      se a flag Z for 0, significa que o resultado e diferente
//      (A != val) : do alto nivel

// beq = (branch equal), verifica se a flag Z == 1,
//      se for 1, ele execulta, se nao ele ignora
//      se a flag Z for 1, significa que o resultado e igual
//      (A == val) : do alto nivel

// bpl = (branch plus), verifica se a flag N == 0
//      se for 0, ele execulta, se nao ele ignora
//      se a flag N for 1, significa que o resultado foi negativo
//      (A >= 0) : no alto nivel

constant varEnergyPtr = $7F1000

seek($8000) 
    clc
    xce
    nop
    rep #$30

    lda #$0008
    sta varEnergyPtr

    gameloop:
        lda varEnergyPtr

        cmp #5
        bne next_if1
        // play caution sound
        nop 
        nop

        next_if1:
            nop
            cmp #3
            bpl _else
            // draw red screen
            nop
            nop
            bra next_if2
        _else:
            // draw blue screen
            nop
            nop
        next_if2:
            nop 
            cmp #0
            beq gameover

            // else, decremente energy
            dec
            sta varEnergyPtr
            bra gameloop
    
    gameover:
        -; 
            bra -
