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
    MOVE.L  #sym_NULL,(SIZE)
    MOVE.L  #sym_NULL,(SOURCE)
    MOVE.L  #sym_NULL,(DEST)
    JSR     PRINT   
    ADD.L   #2,A6
    RTS
    
EA_ADDA_W:
    MOVE.L  #sym_NULL,(SIZE)
    MOVE.L  #sym_NULL,(SOURCE)
    MOVE.L  #sym_NULL,(DEST)
    JSR     PRINT   
    ADD.L   #2,A6
    RTS
    
EA_ADDA_L:
    MOVE.L  #sym_NULL,(SIZE)
    MOVE.L  #sym_NULL,(SOURCE)
    MOVE.L  #sym_NULL,(DEST)
    JSR     PRINT   
    ADD.L   #2,A6
    RTS
    
EA_ADDQ:
    MOVE.L  #sym_NULL,(SIZE)
    MOVE.L  #sym_NULL,(SOURCE)
    MOVE.L  #sym_NULL,(DEST)
    JSR     PRINT   
    ADD.L   #2,A6
    RTS
    
EA_AND:
    MOVE.L  #sym_NULL,(SIZE)
    MOVE.L  #sym_NULL,(SOURCE)
    MOVE.L  #sym_NULL,(DEST)
    JSR     PRINT   
    ADD.L   #2,A6
    RTS
    
EA_ASL_MEMORY:
    MOVE.L  #sym_NULL,(SIZE)
    MOVE.L  #sym_NULL,(SOURCE)
    MOVE.L  #sym_NULL,(DEST)
    JSR     PRINT   
    ADD.L   #2,A6
    RTS
    
EA_ASL_REGISTER:
    MOVE.L  #sym_NULL,(SIZE)
    MOVE.L  #sym_NULL,(SOURCE)
    MOVE.L  #sym_NULL,(DEST)
    JSR     PRINT   
    ADD.L   #2,A6
    RTS
    
EA_ASR_REGISTER:
    MOVE.L  #sym_NULL,(SIZE)
    MOVE.L  #sym_NULL,(SOURCE)
    MOVE.L  #sym_NULL,(DEST)
    JSR     PRINT   
    ADD.L   #2,A6
    RTS
    
EA_ASR_MEMORY:
    MOVE.L  #sym_NULL,(SIZE)
    MOVE.L  #sym_NULL,(SOURCE)
    MOVE.L  #sym_NULL,(DEST)
    JSR     PRINT   
    ADD.L   #2,A6
    RTS
    
EA_LEA:
    MOVE.L  #sym_NULL,(SIZE)
    MOVE.L  #sym_NULL,(SOURCE)
    MOVE.L  #sym_NULL,(DEST)
    JSR     PRINT   
    ADD.L   #2,A6
    RTS
    
EA_MOVE_B:
    MOVE.L  #sym_NULL,(SIZE)
    MOVE.L  #sym_NULL,(SOURCE)
    MOVE.L  #sym_NULL,(DEST)
    JSR     PRINT   
    ADD.L   #2,A6
    RTS
    
EA_MOVE_W:
    MOVE.L  #sym_NULL,(SIZE)
    MOVE.L  #sym_NULL,(SOURCE)
    MOVE.L  #sym_NULL,(DEST)
    JSR     PRINT   
    ADD.L   #2,A6
    RTS
    
EA_MOVE_L:
    MOVE.L  #sym_NULL,(SIZE)
    MOVE.L  #sym_NULL,(SOURCE)
    MOVE.L  #sym_NULL,(DEST)
    JSR     PRINT   
    ADD.L   #2,A6
    RTS

EA_MOVEA_W:
    MOVE.L  #sym_NULL,(SIZE)
    MOVE.L  #sym_NULL,(SOURCE)
    MOVE.L  #sym_NULL,(DEST)
    JSR     PRINT   
    ADD.L   #2,A6
    RTS
EA_MOVEA_L:
    MOVE.L  #sym_NULL,(SIZE)
    MOVE.L  #sym_NULL,(SOURCE)
    MOVE.L  #sym_NULL,(DEST)
    JSR     PRINT   
    ADD.L   #2,A6
    RTS
    
EA_SUB:
    MOVE.L  #sym_NULL,(SIZE)
    MOVE.L  #sym_NULL,(SOURCE)
    MOVE.L  #sym_NULL,(DEST)
    JSR     PRINT   
    ADD.L   #2,A6
    RTS
    


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
