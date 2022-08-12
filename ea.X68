EA_NOP:
    MOVE.L  #sym_NULL,(SIZE) ; Set size, source, dest to blank since NOP doesn't have any parameters
    MOVE.L  #sym_NULL,(SOURCE)
    MOVE.L  #sym_NULL,(DEST)
    JSR     PRINT ; Print the instruction
    ADD.L   #2,A6 ; Increment the disassembly pointer by 1 word to next instruction
    RTS ; Return to main loop
    
EA_RTS:
    MOVE.L  #sym_NULL,(SIZE) ; Set size, source, dest to blank since RTS doesn't have any parameters
    MOVE.L  #sym_NULL,(SOURCE)
    MOVE.L  #sym_NULL,(DEST)
    JSR     PRINT ; Print the instruction
    ADD.L   #2,A6 ; Increment the disassembly pointer by 1 word to next instruction
    RTS ; Return to main loop
    
EA_ADD:
    JSR     GET_OPMODE_AN
    MOVEA.L A4, A5
    MOVE.L  #DATA, A4
    JSR     GET_EFFECTIVE_ADDRESS
    JSR     PRINT
    ADD.L   #2,A6
    RTS
    
EA_ADDQ:
    JSR     GET_SIZE
    ;Get immediate value
    CLR.L     D1
    MOVE.W  (A6), D1
    AND.W   #%0000111000000000, D1
    LSR.W   #8, D1
    LSR.W   #1, D1
    CMP.W   #%0000000000000000, D1
    BNE     EA_ADDQ_17
EA_ADDQ_8:
    MOVE.L  #sym_8, (SOURCE)
    BRA     EA_ADDQ_CONTINUE
EA_ADDQ_17:    
    MOVE.L  #SOURCE_STR, A1
    JSR CONVERT_TO_ASCII_IMMEDIATE
    MOVE.L  #SOURCE_STR, (SOURCE)
EA_ADDQ_CONTINUE:   
    ;Get destination value
    MOVE.L  #DEST, A5
    MOVE.L  #DATA, A4
    JSR     GET_EFFECTIVE_ADDRESS
    JSR     PRINT
    ADD.L   #2,A6
    RTS
    
EA_AND:
    JSR     GET_OPMODE_DN
    MOVE.L A4, A5
    MOVE.L  #DATA, A4
    JSR     GET_EFFECTIVE_ADDRESS
    JSR     PRINT
    ADD.L   #2,A6
    RTS
    
EA_MOVE:
    JSR     GET_SIZE2
    JSR     GET_EFFECTIVE_ADDRESS_DEST
    MOVE.L  #SOURCE, A5
    MOVE.L  #SOURCE_STR, A4
    JSR     GET_EFFECTIVE_ADDRESS
    JSR     PRINT   
    ADD.L   #2,A6
    RTS
    
EA_MOVEQ:
    MOVE.L  #sym_NULL, (SIZE)
    CLR.L   D0
    MOVE.W  (A6), D0
    AND.W   #%0000111000000000, D0
    LSR.W   #8, D0
    LSR.W   #1, D0
    MOVE.L  #reg_SET_D, A0
    MOVE.L  #DEST, A5
    JSR     GET_REGISTER
    CLR.L   D1
    MOVE.W  (A6), D1
    AND.W   #$00FF, D1
    MOVE.L  #SOURCE_STR, A1
    JSR     CONVERT_TO_ASCII_IMMEDIATE
    MOVE.L  #SOURCE_STR, (SOURCE)
    JSR     PRINT
    ADD.L   #2, A6
    RTS
    
EA_MOVEM:
    JSR     GET_SIZE3
    ;Get direction
    CLR.L   D0
    MOVE.W  (A6), D0
    AND.W   #%0000010000000000, D0
    CMP.W   #%0000000000000000, D0
    BNE     EA_MOVEM_MEMORY
EA_MOVEM_REGISTER:
    MOVE.L  #DEST, A5
    MOVE.L  #DEST_STR, A4
    MOVE.L  #MOVEM_STR, (SOURCE)
    BRA     EA_MOVEM_CONTINUE    
EA_MOVEM_MEMORY:
    MOVE.L  #SOURCE, A5
    MOVE.L  #SOURCE_STR, A4
    MOVE.L  #MOVEM_STR, (DEST)
EA_MOVEM_CONTINUE:
    JSR     GET_MOVEM_LIST
    SUB.L   #2, A6
    MOVE.L  (A6), D0
    ROL.L   #8, D0 ;Rotate so that EA is now right after Op Word
    ROL.L   #8, D0 ;Rotate so that EA is now right after Op Word
    MOVE.L  D0, (A6)
    ADD.L   #2, A6
    JSR     GET_EFFECTIVE_ADDRESS   
    ;JSR     GET_MOVEM_LIST 
    JSR     PRINT
    ADD.L   #2, A6
    RTS
    
EA_SUB:
    JSR     GET_OPMODE_DN
    MOVEA.L A4, A5
    JSR     GET_EFFECTIVE_ADDRESS
    JSR     PRINT
    ADD.L   #2,A6
    RTS
    
EA_OR:
    JSR     GET_OPMODE_DN
    MOVEA.L A4, A5
    JSR     GET_EFFECTIVE_ADDRESS
    JSR     PRINT
    ADD.L   #2,A6
    RTS
    
EA_JSR:
    MOVE.L  #SOURCE, A5
    JSR     GET_EFFECTIVE_ADDRESS
    MOVE.L  #sym_NULL, (DEST)
    MOVE.L  #sym_NULL, (SIZE)
    JSR     PRINT
    ADD.L   #2,A6
    RTS
    
EA_LEA:
    CLR.L   D0
    MOVE.W  (A6), D0
    AND.W   #%0000111000000000, D0
    LSR.W   #8, D0
    LSR.W   #1, D0
    MOVE.L  #reg_SET_A, A0
    MOVE.L  #DEST, A5
    JSR     GET_REGISTER
    MOVE.L  #SOURCE, A5
    JSR     GET_EFFECTIVE_ADDRESS
    MOVE.L  #sym_NULL, (SIZE)
    JSR     PRINT
    ADD.L   #2,A6
    RTS
    
EA_NOT:
    JSR     GET_SIZE
    MOVE.L  #SOURCE, A5
    JSR     GET_EFFECTIVE_ADDRESS
    MOVE.L  #sym_NULL, (DEST)
    JSR     PRINT
    ADD.L   #2,A6
    RTS
    
EA_BCC:
    JSR     GET_BRANCH
    JSR     GET_BRANCH_DISPLACEMENT
    MOVE.L  #sym_NULL, (DEST)
    MOVE.L  #sym_NULL, (SIZE)
    JSR     PRINT
    ADD.L   #2,A6
    RTS
    
EA_SHIFT:
    ;Check for shift 1
    CLR.L   D0
    MOVE.W  (A6), D0
    AND.W   #%0000000011000000, D0
    CMP.W   #%0000000011000000, D0
    BNE     EA_SHIFT_REGISTER
EA_SHIFT_1:
    MOVE.L  #sym_NULL, (SIZE)
    MOVE.L  #sym_NULL, (DEST)
    JSR     GET_SHIFT1
    MOVE.L  #SOURCE, A5
    JSR     GET_EFFECTIVE_ADDRESS
    BRA     EA_SHIFT_CONTINUE
EA_SHIFT_REGISTER:
    JSR     GET_SIZE
    JSR     GET_SHIFT
    CLR.L   D0
    MOVE.W  (A6), D0
    AND.W   #%0000000000000111, D0
    MOVE.L  #reg_SET_D, A0
    MOVE.L  #DEST, A5
    JSR     GET_REGISTER
    JSR     GET_SHIFT_SOURCE
EA_SHIFT_CONTINUE:
    JSR     PRINT
    ADD.L   #2,A6
    RTS
    
    


;################ SUPPORTING SUBROUTINES ################
    
;Checks for Dn opmode
;Sets either the source or destination argument
;A4 then points to the location that the effective address must go
GET_OPMODE_DN:
    CLR.L   D2
    MOVE.W  (A6),D2
    AND.W   #%0000000011000000,D2
;Get size first
OPMODE_DN_B:
    CMP.W   #%0000000000000000,D2
    BNE     OPMODE_DN_W
    MOVE.L  #size_B,(SIZE)
    BRA     OPMODE_DN_OPMODE
OPMODE_DN_W:
    CMP.W   #%0000000001000000,D2
    BNE     OPMODE_DN_L
    MOVE.L  #size_W,(SIZE)
    BRA     OPMODE_DN_OPMODE
OPMODE_DN_L:
    CMP.W   #%0000000010000000,D2
    BNE     OPMODE_DN_ERROR
    MOVE.L  #size_L,(SIZE)
    BRA     OPMODE_DN_OPMODE
OPMODE_DN_ERROR:
    ADD.L   #4,A7 ;Remove stack address due to JSR GET_OPMODE_DN
    JMP     CHECK_DATA
OPMODE_DN_OPMODE:
    MOVE.W  (A6),D2
    AND.W   #%0000000100000000,D2
    CMP.W   #%0000000100000000,D2
    BNE     OPMODE_DN_DEST
    MOVE.L  #SOURCE,A5
    MOVE.L  #DEST,A4
    BRA     OPMODE_DN_GET_REGISTER
OPMODE_DN_DEST:
    MOVE.L  #DEST,A5
    MOVE.L  #SOURCE,A4
OPMODE_DN_GET_REGISTER:
    CLR.L   D0
    MOVE.W  (A6),D0
    AND.L   #%0000111000000000,D0
    ASR.L   #8,D0
    ASR.L   #1,D0
    MOVE.L  #reg_SET_D, A0
    JMP     GET_REGISTER

;Checks for An opmode
;Sets the destination argument
;If not An, then uses Dn subroutine
;A4 then points to the location that the effective address must go
GET_OPMODE_AN:
    CLR.L   D2
    MOVE.W  (A6),D2
    AND.W   #%0000000011000000,D2
    CMP.W   #%0000000011000000,D2
    BNE     GET_OPMODE_DN
    MOVE.L  #op_ADDA,(OPCODE)
    MOVE.W  (A6),D2
    AND.W   #%0000000100000000,D2
    CMP.W   #%0000000100000000,D2
    BNE     OPMODE_AN_W
    MOVE.L  #size_L,(SIZE)
    BRA     OPMODE_AN_GET_REGISTER
OPMODE_AN_W:
    MOVE.L  #size_W,(SIZE)
OPMODE_AN_GET_REGISTER:
    CLR.L   D0
    MOVE.W  (A6),D0
    AND.L   #%0000111000000000,D0
    ASR.L   #8,D0
    ASR.L   #1,D0
    MOVE.L  #reg_SET_A, A0
    MOVE.L  #DEST, A5
    MOVE.L  #SOURCE, A4
    JMP     GET_REGISTER
    
;Gets the register found in D0 (bits must be all the way to the right)
;Uses register SET defined in A0 (sets are An, Dn, (An), (An)+, -(An))
;Deposits result into location that A5 points to
GET_REGISTER:
    CMP.W   #8, D0 ;Make sure it is a valid register (less than 8)
    ;If not - ERROR
    BLT     GET_REGISTER_CONTINUE
    ADD.L   #4,A7 ;Remove stack address due to JSR GET_REGISTER
    JMP     CHECK_DATA
GET_REGISTER_CONTINUE:
    CMP.L   #reg_SET_Aipi, A0 ;If SET is aipi or aipd
    BLT     GET_REGISTER_D_A_AI
GET_REGISTER_AIPI_AIPD:
    MULU.W  #12, D0 ;Each string takes up 3 words instead of 2
    BRA     GET_REGISTER_OFFSET
GET_REGISTER_D_A_AI:
    MULU.W  #8, D0 ;Each string takes up 2 words
GET_REGISTER_OFFSET:
    ADD.L   D0, A0 ;Go to offset
    MOVE.L  A0, (A5)
    RTS
    
GET_EFFECTIVE_ADDRESS_DEST:
    MOVE.L  #DEST_STR, A4
    MOVE.L  #DEST, A5
    CLR.L     D2
    CLR.L     D3
    MOVE.W  (A6), D2
    AND.W   #%0000000111000000, D2
    CMP.W   #%0000000001000000, D2
    BNE     GET_EFFECTIVE_ADDRESS_DEST_C
    MOVE.L  #op_MOVEA, (OPCODE)
GET_EFFECTIVE_ADDRESS_DEST_C:
    MOVE.W  (A6), D3 ;Store original contents
    MOVE.W  D3, D2
    ROL.W   #7, D2
    LSL.B   #5, D2
    LSR.W   #5, D2
    LSL.B   #5, D2
    LSR.W   #5, D2
    MOVE.W D2, (A6)
    JSR     GET_EFFECTIVE_ADDRESS
    MOVE.W  D3, (A6) ;Restore original contents
    RTS
    
;Gets the effective address of the current word in A0
;Deposits resulting address into physical location that A5 points to
;If effective address is immediate or address, will use physical space that A4 points to
GET_EFFECTIVE_ADDRESS:
    CLR.L   D0
    CLR.L   D2
    MOVE.W  (A6), D2
    AND.W   #%0000000000111000, D2
CHECK_EFFECTIVE_ADDRESS_DN:
    CMP.W   #%0000000000000000, D2
    BNE     CHECK_EFFECTIVE_ADDRESS_AN
    MOVE.W  (A6), D0
    AND.W   #%0000000000000111, D0
    MOVE.L  #reg_SET_D, A0
    JMP     GET_REGISTER
CHECK_EFFECTIVE_ADDRESS_AN:
    CMP.W   #%0000000000001000, D2
    BNE     CHECK_EFFECTIVE_ADDRESS_ANI
    MOVE.W  (A6), D0
    AND.W   #%0000000000000111, D0
    MOVE.L  #reg_SET_A, A0
    JMP     GET_REGISTER
CHECK_EFFECTIVE_ADDRESS_ANI:
    CMP.W   #%0000000000010000, D2
    BNE     CHECK_EFFECTIVE_ADDRESS_ANIPI
    MOVE.W  (A6), D0
    AND.W   #%0000000000000111, D0
    MOVE.L  #reg_SET_Ai, A0
    JMP     GET_REGISTER
CHECK_EFFECTIVE_ADDRESS_ANIPI:
    CMP.W   #%0000000000011000, D2
    BNE     CHECK_EFFECTIVE_ADDRESS_ANIPD
    MOVE.W  (A6), D0
    AND.W   #%0000000000000111, D0
    MOVE.L  #reg_SET_Aipi, A0
    JMP     GET_REGISTER
CHECK_EFFECTIVE_ADDRESS_ANIPD:
    CMP.W   #%0000000000100000, D2
    BNE     CHECK_EFFECTIVE_ADDRESS_OTHER
    MOVE.W  (A6), D0
    AND.W   #%0000000000000111, D0
    MOVE.L  #reg_SET_Aipd, A0
    JMP     GET_REGISTER
CHECK_EFFECTIVE_ADDRESS_OTHER:
    CMP.W   #%0000000000111000, D2
    BNE     CHECK_EFFECTIVE_ADDRESS_ERROR
    
CHECK_EFFECTIVE_ADDRESS_I:
    MOVE.W  (A6), D2
    AND.W   #%0000000000000111, D2
    CMP.W   #%0000000000000100, D2
    BNE     CHECK_EFFECTIVE_ADDRESS_W
    
    MOVEA.L #DATA_STR, A1
    ADD.L   #2, A6 ;Increment to next word
    ;If the size is long, then pull a longword
    MOVE.L  #size_L, D1
    CMP.L   (SIZE),D1
    BEQ     EA_I_L
    MOVE.L  #size2_L, D1
    CMP.L   (SIZE),D1
    BEQ     EA_I_L
    ;Else move word
    CLR.L   D1
    MOVE.W  (A6), D1
    BRA     EA_I_CONTINUE
EA_I_L:
    CLR.L   D1
    MOVE.L  (A6), D1
    ADD.L   #2, A6
EA_I_CONTINUE:
    JSR     CONVERT_TO_ASCII_IMMEDIATE
    MOVE.L  #DATA_STR, (A5)
    RTS
CHECK_EFFECTIVE_ADDRESS_W:
    CMP.W   #%0000000000000000, D2
    BNE     CHECK_EFFECTIVE_ADDRESS_L
    MOVEA.L #DATA_STR, A1
    ADD.L   #2, A6 ;Increment to next word
    CLR.L   D1
    MOVE.W  (A6), D1
    JSR     CONVERT_TO_ASCII_W
    MOVE.L  #DATA_STR, (A5)
    RTS
CHECK_EFFECTIVE_ADDRESS_L:
    CMP.W   #%0000000000000001, D2
    BNE     CHECK_EFFECTIVE_ADDRESS_ERROR
    MOVEA.L #DATA_STR, A1
    ADD.L   #2, A6 ;Increment to next word
    CLR.L   D1
    MOVE.L  (A6), D1
    ADD.L   #2, A6 ;Add another word since it's L
    JSR     CONVERT_TO_ASCII_L
    MOVE.L  #DATA_STR, (A5)
    RTS
CHECK_EFFECTIVE_ADDRESS_ERROR:
    ADD.L   #4,A7 ;Remove stack address due to JSR GET_EFFECTIVE_ADDRESS
    JMP     CHECK_DATA

GET_BRANCH:
    CLR.L   D0
    MOVE.L  #op_SET_BCC, A0
    MOVE.W  (A6), D0
    AND.W   #%0000111100000000, D0
    LSR.W   #8, D0
    MULU.W  #8, D0
    ADD.L   D0, A0
    MOVE.L  A0, (OPCODE)
    RTS
    
GET_BRANCH_DISPLACEMENT:
    CLR.L   D0
    MOVE.W  (A6), D0
    AND.W   #%0000000011111111, D0
    CMP.B   #$00, D0
    BEQ     GET_BRANCH_DISPLACEMENT_W
    CMP.B   #$FF, D0
    BEQ     GET_BRANCH_DISPLACEMENT_L
    EXT.W   D0
    EXT.L   D0
    MOVE.L  A6, D1
    ADD.L   #2, D1
    BRA     GET_BRANCH_DISPLACEMENT_CONT
GET_BRANCH_DISPLACEMENT_W:
    ADD.L   #2, A6
    MOVE.W  (A6), D0
    EXT.L   D0
    MOVE.L  A6, D1
    BRA     GET_BRANCH_DISPLACEMENT_CONT
GET_BRANCH_DISPLACEMENT_L:
    ADD.L   #2, A6
    MOVE.L  (A6), D0
    ADD.L   #2, A6
    MOVE.L  A6, D1
GET_BRANCH_DISPLACEMENT_CONT:
    ADD.L   D0, D1
    MOVE.L  #SOURCE_STR, A1
    JSR     CONVERT_TO_ASCII_L
    MOVE.L  #SOURCE_STR, (SOURCE)
    RTS
    
GET_SIZE:
    CLR.L   D0
    MOVE.W  (A6), D0
    AND.W   #%0000000011000000, D0
    CMP.W   #%0000000011000000, D0
    BEQ     GET_SIZE_ERROR
    LSR.W   #6, D0
    CMP.W   #3, D0
    BLT     GET_SIZE_CONTINUE
    ADD.L   #4,A7 ;Remove stack address due to JSR GET_REGISTER
    JMP     CHECK_DATA
GET_SIZE_CONTINUE:
    MOVE.L  #size_SET, A0
    MULU.W  #8, D0
    ADD.L   D0, A0
    MOVE.L  A0, (SIZE)
    RTS
GET_SIZE_ERROR:
    ADD.L   #4,A7 ;Remove stack address due to JSR GET_REGISTER
    JMP     CHECK_DATA
    
GET_SIZE2:
    CLR.L   D0
    MOVE.W  (A6), D0
    AND.W   #%0011000000000000, D0
    CMP.W   #$0000, D0
    BEQ     GET_SIZE2_ERROR    
    LSR.W   #8, D0
    LSR.W   #4, D0
    SUB.W   #1, D0
    CMP.W   #3, D0
    BLT     GET_SIZE2_CONTINUE
    ADD.L   #4,A7 ;Remove stack address due to JSR GET_REGISTER
    JMP     CHECK_DATA
GET_SIZE2_CONTINUE:
    MOVE.L  #size2_SET, A0
    MULU.W  #8, D0
    ADD.L   D0, A0
    MOVE.L  A0, (SIZE)
    RTS
GET_SIZE2_ERROR:
    ADD.L   #4,A7 ;Remove stack address due to JSR GET_REGISTER
    JMP     CHECK_DATA
    
GET_SIZE3:
    CLR.L   D0
    MOVE.W  (A6), D0
    AND.W   #%0000000001000000, D0
    LSR.W   #6, D0
    MOVE.L  #size_W, A0
    MULU.W  #8, D0
    ADD.L   D0, A0
    MOVE.L  A0, (SIZE)
    RTS
    
GET_SHIFT:
    CLR.L   D0
    MOVE.W  (A6), D0
    AND.W   #%0000000000011000, D0
    CMP.W   #%0000000000010000, D0
    BNE     GET_SHIFT_CONTINUE
    ADD.L   #4,A7 ;Remove stack address due to JSR GET_REGISTER
    JMP     CHECK_DATA
GET_SHIFT_CONTINUE:
    MOVE.W  (A6), D0
    AND.W   #%0000000100011000, D0
    LSL.B   #3, D0
    LSR.W   #6, D0
    MOVE.L  #op_SET_SHIFT, A0
    MULU.W  #8, D0
    ADD.L   D0, A0
    MOVE.L  A0, (OPCODE)
    RTS
    
GET_SHIFT1:
    CLR.L   D0
    MOVE.W  (A6), D0
    AND.W   #%0000011000000000, D0
    CMP.W   #%0000010000000000, D0
    BNE     GET_SHIFT1_CONTINUE
    ADD.L   #4,A7 ;Remove stack address due to JSR GET_REGISTER
    JMP     CHECK_DATA
GET_SHIFT1_CONTINUE:
    MOVE.W  (A6), D0
    AND.W   #%0000011100000000, D0
    ROL.W   #7, D0
    LSL.B   #6, D0
    LSR.W   #6, D0
    LSL.B   #1, D0
    LSR.W   #1, D0
    LSL.B   #6, D0
    LSR.W   #6, D0
    MOVE.L  #op_SET_SHIFT, A0
    MULU.W  #8, D0
    ADD.L   D0, A0
    MOVE.L  A0, (OPCODE)
    RTS
    
GET_SHIFT_SOURCE:
    CLR.L   D0
    MOVE.W  (A6), D0
    AND.W   #%0000000000100000, D0
    CLR.L   D1
    MOVE.W  (A6), D1
    AND.W   #%0000111000000000, D1
    LSR.W   #8, D1
    LSR.W   #1, D1
    CMP.W   #%0000000000000000, D0
    BNE     GET_SHIFT_SOURCE_REGISTER
GET_SHIFT_SOURCE_IMMEDIATE:
    MOVE.L  #SOURCE_STR, A1
    JSR     CONVERT_TO_ASCII_IMMEDIATE
    MOVE.L  #SOURCE_STR, (SOURCE)
    RTS
GET_SHIFT_SOURCE_REGISTER:
    MOVE.L  D1, D0
    MOVE.L  #reg_SET_D, A0
    MOVE.L  #SOURCE, A5
    JSR     GET_REGISTER
    RTS
    
    
GET_MOVEM_LIST:
    MOVE.L  #MOVEM_STR, A4
    MOVE.W  (A6), D0
    AND.W   #%0000000000111000, D0
    CMP.W   #%0000000000111000, D0
    BEQ     GET_MOVEM_LIST_DEST
    CMP.L   #DEST, A5
    BEQ     GET_MOVEM_LIST_SOURCE
GET_MOVEM_LIST_DEST:
    MOVE.L  #reg_A7, A0
    MOVE.L  #-8, D1 ; Step number
    BRA     GET_MOVEM_LIST_CONTINUE
GET_MOVEM_LIST_SOURCE:   
    MOVE.L  #reg_D0, A0
    MOVE.L  #8, D1 ; Step number
GET_MOVEM_LIST_CONTINUE:
    ADD.L   #2, A6 ; Go to word that contains list
    CLR.L   D0
    MOVE.W  (A6), D0 ; Word that contains list
    MOVE.B  #$00, (MOVEM_STR)
GET_MOVEM_LIST_LOOP:
    BTST.L  #15, D0
    BEQ     GET_MOVEM_LIST_LOOP_SKIP
    CMP.B   #$00, (MOVEM_STR)
    BEQ     GET_MOVEM_LIST_LOOP_1ST
    ; Add slash
    MOVE.B  #'/', (A4)
    ADD.L   #1, A4
GET_MOVEM_LIST_LOOP_1ST:
    ; Add register
    MOVE.B  (A0)+, (A4)+
    MOVE.B  (A0), (A4)
    ADD.L   #1, A4
    SUB.L   #1, A0
GET_MOVEM_LIST_LOOP_SKIP:
    ADD.L   D1, A0 ; Increment pointer to register
    LSL.W   #1, D0 ; Shift left to check next bit
    CMP.W   #$0000, D0 ; Test to see if no more bits in list
    BNE     GET_MOVEM_LIST_LOOP
    
    MOVE.B  #$00, (A4) ; Add string terminator    
    RTS

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
