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
    LSR.W   #8,D2
    LSR.W   #4,D2
    CMP.W   #%0000000000001101,D2
    BNE     CHECK_AND  
    MOVE.L  #op_ADD,(OPCODE)
    JMP     EA_ADD
    
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
    BNE     CHECK_BCC
    MOVE.L  #op_ASR,(OPCODE)
    JMP     EA_ASR_MEMORY
    
CHECK_BCC:

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
