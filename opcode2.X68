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
    ; Need to check only the left 4 bits
    ; First four bits should be 1101
    MOVE.W  (A6),D2
    AND.W   #$F000,D2
    CMP.W   #%1101000000000000,D2
    BNE     CHECK_ADDQ
    MOVE.L  #op_ADD,(OPCODE)
    JMP     EA_ADD

CHECK_ADDQ:
    ; Need to check only the left 4 bits
    ; First four bits should be 1101
    MOVE.W  (A6),D2
    LSR.W   #8,D2
    LSR.W   #4,D2
    CMP.W   #%0000000000000101,D2
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
    MOVE.W  (A6),D2
    AND.W   #$F000, D2
    CMP.W   #%1110000000000000,D2
    BNE     CHECK_MOVEA
    JMP     EA_SHIFT
  
CHECK_MOVEA:
    MOVE.W  (A6),D2
    AND.W   #%1100000111000000,D2
    CMP.W   #%0000000001000000,D2
    BNE     CHECK_MOVE
    MOVE.L  #op_MOVEA,(OPCODE)
    JMP     EA_MOVEA
   
    
CHECK_MOVE:
    MOVE.W  (A6),D2
    LSR.W   #8,D2
    LSR.W   #6,D2
    CMP.W   #%0000000000000000,D2
    BNE     CHECK_SUB
    MOVE.L  #op_MOVE,(OPCODE)
    JMP     EA_MOVE

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
    BNE     CHECK_BEQ
    MOVE.L  #op_NOT,(OPCODE)
    JMP     EA_BCC

CHECK_BEQ
    MOVE.W  (A6),D2
    LSR.W   #8,D2
    CMP.W   #%0000000001100111,D2
    BNE     CHECK_BGT
    MOVE.L  #op_BEQ,(OPCODE)
    JMP     EA_BEQ
    
CHECK_BGT
    MOVE.W  (A6),D2
    LSR.W   #8,D2
    CMP.W   #%0000000001101110,D2
    BNE     CHECK_BRA
    MOVE.L  #op_BGT,(OPCODE)
    JMP     EA_BGT
    
CHECK_BRA
    MOVE.W  (A6),D2
    LSR.W   #8,D2
    CMP.W   #%0000000001100000,D2
    BNE     CHECK_MOVEQ
    MOVE.L  #op_BRA,(OPCODE)
    JMP     EA_BRA
    
CHECK_MOVEQ:
    MOVE.W  (A6),D2
    LSR.W   #8,D2
    LSR.W   #4,D2
    CMP.W   #%0000000000000111,D2
    BNE     CHECK_MOVEM
    MOVE.L  #op_MOVEQ,(OPCODE)
    JMP     EA_MOVEQ

CHECK_MOVEM:
    MOVE.W  (A6),D2
    AND.W   #%1111101110000000,D2
    CMP.W   #%0100100010000000,D2
    BNE     CHECK_ASL
    MOVE.L  #op_MOVEM,(OPCODE)
    JMP     EA_MOVEM

CHECK_ASL:
    MOVE.W  (A6),D2
    LSR.W   #8,D2
    LSR.W   #4,D2
    CMP.W   #%0000000000001110,D2
    BNE     CHECK_ASR
    MOVE.L  #op_ASL,(OPCODE)
    JMP     EA_ASL
    
CHECK_ASR:
    MOVE.W  (A6),D2
    LSR.W   #8,D2
    LSR.W   #4,D2
    CMP.W   #%0000000000001110,D2
    BNE     CHECK_LSL
    MOVE.L  #op_ASR,(OPCODE)
    JMP     EA_ASR

CHECK_LSL:
    MOVE.W  (A6),D2
    LSR.W   #8,D2
    LSR.W   #4,D2
    CMP.W   #%0000000000001110,D2
    BNE     CHECK_LSR
    MOVE.L  #op_LSL,(OPCODE)
    JMP     EA_LSL

CHECK_LSR:
    MOVE.W  (A6),D2
    LSR.W   #8,D2
    LSR.W   #4,D2
    CMP.W   #%0000000000001110,D2
    BNE     CHECK_ROL
    MOVE.L  #op_LSR,(OPCODE)
    JMP     EA_LSR
    
CHECK_ROL:
    MOVE.W  (A6),D2
    LSR.W   #8,D2
    LSR.W   #4,D2
    CMP.W   #%0000000000001110,D2
    BNE     CHECK_ROR
    MOVE.L  #op_ROL,(OPCODE)
    JMP     EA_ROL
    
CHECK_ROR:
    MOVE.W  (A6),D2
    LSR.W   #8,D2
    LSR.W   #4,D2
    CMP.W   #%0000000000001110,D2
    BNE     CHECK_DATA
    MOVE.L  #op_ROR,(OPCODE)
    JMP     EA_ROR

CHECK_DATA:
    MOVE.W  (A6),(DATA) ; Pass data to print
    JSR     PRINT_DATA ; Print the data
    ADD.L   #2,A6 ; Increment the disassembly pointer by 1 word to next instruction
    RTS ; Return to main loop



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
