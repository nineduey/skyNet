GET_OPCODE:
CHECK_NOP:
    CMP.W   #%0100111001110001,(A6)
    BNE     CHECK_RTS
    MOVE.L  #op_NOP,(OPCODE) ; Pass the NOP opcode
    JMP     EA_NOP  ; Jump to the EA subroutine for this OpCode (will be made by Amanda)
                    ; Have to use JMP, Branch cannot go far away
CHECK_RTS:
    CMP.W   #%0100111001110101,(A6)
    BNE     CHECK_ADDA_W
    MOVE.L  #op_RTS,(OPCODE)
    JMP     EA_RTS

CHECK_ADDA_W:
    ; Need to check only the left 4 bits
    ; First four bits should be 1101
    MOVE.W  (A6),D2
    LSR.W   #8,D2
    LSR.W   #4,D2
    CMP.W   #%0000000000001101,D2
    BNE     CHECK_ADD
    CLR.L   D2
    MOVE.W  (A6),D2
    LSL.W   #7,D2
    LSR.W   #8,D2
    LSR.W   #5,D2
    CMP.W   #%0000000000000011,D2
    BNE     CHECK_ADDA_L
    MOVE.L  #op_ADDA,(OPCODE)
    JMP     EA_ADDA_W
    
CHECK_ADDA_L:
    ; Need to check only the left 4 bits
    ; First four bits should be 1101
    MOVE.W  (A6),D2
    LSR.W   #8,D2
    LSR.W   #4,D2
    CMP.W   #%0000000000001101,D2
    BNE     CHECK_ADD
    CLR.L   D2
    MOVE.W  (A6),D2
    LSL.W   #7,D2
    LSR.W   #8,D2
    LSR.W   #5,D2
    CMP.W   #%0000000000000111,D2
    BNE     CHECK_ADD
    MOVE.L  #op_ADDA,(OPCODE)
    JMP     EA_ADDA_L
    
CHECK_ADD:
    ; Need to check only the left 4 bits
    ; First four bits should be 1101
    MOVE.W  (A6),D2
    LSR.W   #8,D2
    LSR.W   #4,D2
    CMP.W   #%0000000000001101,D2
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
    BNE     CHECK_ASL_REGISTER
    MOVE.L  #op_AND,(OPCODE)
    JMP     EA_AND
    
CHECK_ASL_REGISTER:                  
    MOVE.W  (A6),D2
    LSR.W   #6,D2
    CMP.W   #%0000001110000111,D2
    BNE     CHECK_ASL_MEMORY
    MOVE.L  #op_ASL,(OPCODE)
    JMP     EA_ASL_REGISTER
    
CHECK_ASL_MEMORY:                      
    MOVE.W  (A6),D2
    LSR.W   #6,D2
    CMP.W   #%0000001110000111,D2
    BNE     CHECK_ASR_REGISTER
    MOVE.L  #op_ASL,(OPCODE)
    JMP     EA_ASL_MEMORY  
    
CHECK_ASR_REGISTER:
    CMP.W   #%1110000011,(A6)   ; Instruction format is determined by a shift to the right
    BNE     CHECK_ASR_MEMORY
    MOVE.L  #op_ASR,(OPCODE)
    JMP     EA_ASR_REGISTER
    
CHECK_ASR_MEMORY:
    MOVE.W  (A6),D2
    LSR.W   #6,D2
    CMP.W   #%0000001110000011,D2   ; Instruction format is determined by a shift to the right
    BNE     CHECK_LEA
    MOVE.L  #op_ASR,(OPCODE)
    JMP     EA_ASR_MEMORY
    
CHECK_LEA:
    MOVE.W  (A6),D2
    LSR.W   #8,D2
    LSR.W   #4,D2
    CMP.W   #%0000000000000100,D2
    BNE     CHECK_MOVEA_W
    MOVE.L  #op_LEA,(OPCODE)
    JMP     EA_LEA
    
CHECK_MOVEA_W:
    MOVE.W  (A6),D2
    LSR.W   #6,D2
    LSL.W   #8,D2
    LSL.W   #6,D2
    CMP.W   #%0010000000000000,D2
    BNE     CHECK_MOVEA_L
    MOVE.L  #op_MOVEA,(OPCODE)
    JMP     EA_MOVEA_W
    
CHECK_MOVEA_L:
    MOVE.W  (A6),D2
    LSR.W   #6,D2
    LSL.W   #8,D2
    LSL.W   #6,D2
    CMP.W   #%0010000000000000,D2
    BNE     CHECK_MOVE_B
    MOVE.L  #op_MOVEA,(OPCODE)
    JMP     EA_MOVEA_L
    
CHECK_MOVE_B:
    MOVE.W  (A6),D2
    LSR.W   #8,D2
    LSR.W   #4,D2
    CMP.W   #%0000000000000001,D2
    BNE     CHECK_MOVE_W
    MOVE.L  #op_MOVE,(OPCODE)
    JMP     EA_MOVE_B
    
CHECK_MOVE_W:
    MOVE.W  (A6),D2
    LSR.W   #8,D2
    LSR.W   #4,D2
    CMP.W   #%0000000000000011,D2
    BNE     CHECK_MOVE_L
    MOVE.L  #op_MOVE,(OPCODE)
    JMP     EA_MOVE_W
    
CHECK_MOVE_L:
    MOVE.W  (A6),D2
    LSR.W   #8,D2
    LSR.W   #4,D2
    CMP.W   #%0000000000000010,D2
    BNE     CHECK_SUB
    MOVE.L  #op_MOVE,(OPCODE)
    JMP     EA_MOVE_L

CHECK_SUB:
    MOVE.W  (A6),D2
    LSR.W   #8,D2
    LSR.W   #4,D2
    CMP.W   #%0000000000001001,D2
    BNE     CHECK_DIVS
    MOVE.L  #op_SUB,(OPCODE)
    JMP     EA_SUB
    
CHECK_DIVS:
    

ELSE:
    MOVE.W  (A6),(DATA) ; Pass data to print
    JSR     PRINT_DATA ; Print the data
    ADD.L   #2,A6 ; Increment the disassembly pointer by 1 word to next instruction
    RTS ; Return to main loop

* 



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
