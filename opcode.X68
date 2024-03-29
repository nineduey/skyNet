GET_OPCODE:
CHECK_NOP:
    CMP.W   #%0100111001110001,(A6)
    BNE     CHECK_RTS
    MOVE.L  #op_NOP,(OPCODE) ; Pass the NOP opcode
    JMP     EA_NOP  ; Jump to the EA subroutine for this OpCode (will be made by Amanda)
                    ; Have to use JMP, Branch cannot go far away
CHECK_RTS:
    CMP.W   #%0100111001110101,(A6)
    BNE     CHECK_ADD
    MOVE.L  #op_RTS,(OPCODE)
    JMP     EA_RTS

CHECK_ADD:
    MOVE.W  (A6),D2
    AND.W   #$F000,D2
    CMP.W   #%1101000000000000,D2
    BNE     CHECK_ADDQ
    MOVE.L  #op_ADD,(OPCODE)
    JMP     EA_ADD

CHECK_ADDQ:
    MOVE.W  (A6),D2
    AND.W   #%1111000100000000,D2
    CMP.W   #%0101000000000000,D2
    BNE     CHECK_AND
    MOVE.L  #op_ADDQ,(OPCODE)
    JMP     EA_ADDQ

CHECK_AND:
    MOVE.W  (A6),D2
    LSR.W   #8,D2
    LSR.W   #4,D2
    CMP.W   #%0000000000001100,D2
    BNE     CHECK_SHIFT
    MOVE.L  #op_AND,(OPCODE)
    JMP     EA_AND
    
CHECK_SHIFT:
    MOVE.W  (A6), D2
    AND.W   #$F000, D2
    CMP.W   #%1110000000000000, D2
    BNE     CHECK_MOVE
    JMP     EA_SHIFT
    
CHECK_MOVE:
    MOVE.W  (A6),D2
    AND.W   #%1100000000000000,D2
    CMP.W   #%0000000000000000,D2
    BNE     CHECK_MOVEQ
    MOVE.L  #op_MOVE,(OPCODE)
    JMP     EA_MOVE
    
CHECK_MOVEQ:
    MOVE.W  (A6),D2
    AND.W   #%1111000100000000,D2
    CMP.W   #%0111000000000000,D2
    BNE     CHECK_MOVEM
    MOVE.L  #op_MOVEQ,(OPCODE)
    JMP     EA_MOVEQ
    
CHECK_MOVEM:
    MOVE.W  (A6),D2
    AND.W   #%1111101110000000,D2
    CMP.W   #%0100100010000000,D2
    BNE     CHECK_SUB
    MOVE.L  #op_MOVEM,(OPCODE)
    JMP     EA_MOVEM

CHECK_SUB:
    MOVE.W  (A6),D2
    LSR.W   #8,D2
    LSR.W   #4,D2
    CMP.W   #%0000000000001001,D2
    BNE     CHECK_JSR
    MOVE.L  #op_SUB,(OPCODE)
    JMP     EA_SUB
 
CHECK_JSR:
    MOVE.W  (A6),D2
    AND.W   #%1111111111000000,D2
    CMP.W   #%0100111010000000,D2
    BNE     CHECK_LEA
    MOVE.L  #op_JSR,(OPCODE)
    JMP     EA_JSR
    
CHECK_LEA:
    MOVE.W  (A6),D2
    AND.W   #%1111000111000000,D2
    CMP.W   #%0100000111000000,D2
    BNE     CHECK_NOT
    MOVE.L  #op_LEA,(OPCODE)
    JMP     EA_LEA
    
CHECK_NOT:
    MOVE.W  (A6),D2
    AND.W   #%1111111100000000,D2
    CMP.W   #%0100011000000000,D2
    BNE     CHECK_BCC
    MOVE.L  #op_NOT,(OPCODE)
    JMP     EA_NOT
    
CHECK_BCC:
    MOVE.W  (A6),D2
    AND.W   #%1111000000000000,D2
    CMP.W   #%0110000000000000,D2
    BNE     CHECK_OR
    MOVE.L  #op_NOT,(OPCODE)
    JMP     EA_BCC
    
CHECK_OR:
    MOVE.W  (A6),D2
    AND.W   #%1111000000000000,D2
    CMP.W   #%1000000000000000,D2
    BNE     CHECK_DATA
    MOVE.L  #op_OR,(OPCODE)
    JMP     EA_OR

    

CHECK_DATA:
    MOVE.W  (A6),(DATA) ; Pass data to print
    JSR     PRINT_DATA ; Print the data
    ADD.L   #2,A6 ; Increment the disassembly pointer by 1 word to next instruction
    RTS ; Return to main loop

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
