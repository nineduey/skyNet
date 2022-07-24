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
    CMP.W   #%1101,(A6)
    BNE     CHECK_AND  
    MOVE.L  #op_ADD,(OPCODE)
    JMP     EA_ADD
CHECK_AND:
    CMP.W   #%1100,(A6)
    BNE     CHECK_ASL
    MOVE.L  #op_AND,(OPCODE)
    JMP     EA_AND
CHECK_ASL:                      ; Instruction format is determined by a shift to the left
    CMP.W   #%1110000111,(A6)
    BNE     CHECK_ASR
    MOVE.L  #op_ASL,(OPCODE)
    JMP     EA_ASL
CHECK_ASR:
    CMP.W   #%1110000011,(A6)   ; Instruction format is determined by a shift to the right
    BNE     CHECK_BCC
    MOVE.L  #op_ASR,(OPCODE)
    JMP     EA_ASR
CHECK_BCC:
    CMP.W   #%

ELSE:
    MOVE.W  (A6),(DATA) ; Pass data to print
    JSR     PRINT_DATA ; Print the data
    ADD.L   #2,A6 ; Increment the disassembly pointer by 1 word to next instruction
    RTS ; Return to main loop

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
