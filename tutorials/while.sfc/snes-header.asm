seek($FFC0)
    db "Program Name Here    "
    db $20
    db $00
    db $01
    db $00
    db $00
    db $00
    db $00
    db "CC"
    db "CS"
    dw $0000 // RESERVED
    dw $0000 // RESERVED
    dw $0000 // COP VECTOR   (COP Opcode)
    dw $0000 // BRK VECTOR   (BRK Opcode)
    dw $0000 // ABORT VECTOR (Unused)
    dw $0000 // NMI VECTOR   (V-Blank Interrupt)
    dw $0000 // RESET VECTOR (Unused)
    dw $0000 // IRQ VECTOR   (H/V-Timer/External Interrupt)
    dw $0000 // RESERVED
    dw $0000 // RESERVED
    dw $0000 // COP VECTOR   (COP Opcode)
    dw $0000 // BRK VECTOR   (Unused)
    dw $0000 // ABORT VECTOR (Unused)
    dw $0000 // NMI VECTOR   (V-Blank Interrupt)
    dw $8000 // RESET VECTOR (CPU is always in 6502 mode on RESET)
    dw $0000 // IRQ/BRK VECTOR