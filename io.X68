; Variables
ADDR        DCB.L  1,0 ; Raw address, not ASCII, will be converted to ASCII and printed
OPCODE      DCB.L  1,0 ; Address, will print whatever is at this address
SIZE        DCB.L  1,0 ; Address, will print whatever is at this address
SOURCE      DCB.L  1,0 ; Address, will print whatever is at this address
DEST        DCB.L  1,0 ; Address, will print whatever is at this address
DATA        DCB.L  1,0 ; Raw data, not ASCII, will be converted to ASCII and printed
ADDR_STR    DCB.B 10,0 ; Raw data
DATA_STR    DCB.B 10,0 ; Raw data
SOURCE_STR  DCB.B 10,0 ; Raw data
DEST_STR    DCB.B 10,0 ; Raw data
MOVEM_STR   DCB.B 49,0 ; String for MOVEM, 16 registers max, each one requires 3 characters
        NOP

* This function prints the strings at ADDR formatted
* A1 = Memory Address, A2 = OPCode, A3 = Size, A4 = Source, A5 = Destination
* Register needs to be sym_NULL if blank
PRINT:
        MOVEM.L A1/D1,-(SP)
        MOVE.B  #14,D0
        
        ; Memory Address
        MOVE.W  (ADDR),D1
        LEA     ADDR_STR,A1
        JSR     CONVERT_TO_ASCII_W
        TRAP    #15

        ; Tab
        LEA     sym_tab,A1
        TRAP    #15

        ; OPCode
        MOVEA.L OPCODE,A1
        TRAP    #15
        
        ; Size
        MOVEA.L SIZE,A1
        TRAP    #15
        
        ;Skip rest if no source
        MOVEA.L SOURCE,A1
        CMP.B   #0,(A1)
        BEQ     SKIP_TO_CRLF
        
        ;Count letters in Opcode and size to
        ;determine how many spaces to look nice
        MOVE.B  #0, D1
        MOVE.L  (OPCODE), A1
PRINT_COUNT_LOOP:
        ADD.B   #1, D1
        ADD.L   #1, A1
        CMP.B   #$00, (A1)
        BNE     PRINT_COUNT_LOOP
        
        MOVE.L  (SIZE), A1
        CMP.B   #$00, (A1)
        BEQ     PRINT_COUNT_CONTINUE
        ADD.B   #2, D1
PRINT_COUNT_CONTINUE:
        
        LEA     sym_space,A1
PRINT_SPACE_LOOP:
        TRAP    #15
        ADD.B   #1, D1
        CMP.B   #9, D1
        BLT     PRINT_SPACE_LOOP
        
        ; Source
        MOVEA.L SOURCE,A1
        TRAP    #15
        
        ;Skip rest if no dest
        MOVEA.L DEST,A1
        CMP.B   #0,(A1)
        BEQ     SKIP_TO_CRLF
        
        ; Comma
        LEA     sym_comma,A1
        TRAP    #15
        
        ; Space
        LEA     sym_space,A1
        TRAP    #15
        
        ; Destination
        MOVEA.L DEST,A1
        TRAP    #15
        
SKIP_TO_CRLF:        
        ; New Line
        LEA     sym_crlf,A1
        TRAP    #15
        
        MOVEM.L (SP)+,A1/D1
        RTS

; Converts the value in D1 to ASCII characters and stores it at A1
CONVERT_TO_ASCII_L:
        MOVEM.L D1-D4/A2-A3,-(SP)
        MOVE.L  D1,ADDRESS_TO_CONVERT
        MOVE.B  #8,D2
        MOVEA.L A1,A2
        BRA     CONVERT_TO_ASCII

CONVERT_TO_ASCII_W:
        MOVEM.L D1-D4/A2-A3,-(SP)
        MOVE.W  D1,ADDRESS_TO_CONVERT
        MOVE.B  #4,D2
        MOVEA.L A1,A2
        BRA     CONVERT_TO_ASCII
        
CONVERT_TO_ASCII_IMMEDIATE:
        MOVEM.L D1-D4/A2-A3,-(SP)
        MOVE.L  D1,ADDRESS_TO_CONVERT
        CLR.L   D2
        MOVE.L  D1,D3
        
IMM_LOOP:
        LSR.L   #4,D3
        ADD.B   #1,D2
        CMP.L   #0,D3
        BNE     IMM_LOOP
        
        MOVE.L  #8,D3
        SUB.L   D2,D3
        
        CMP.L   #0,D3
        BEQ     IMM_SHIFT_LOOP_CONTINUE
        
IMM_SHIFT_LOOP:
        LSL.L   #4,D1
        SUB.L   #1,D3
        CMP.L   #0,D3
        BNE     IMM_SHIFT_LOOP
IMM_SHIFT_LOOP_CONTINUE:        
        MOVEA.L A1,A2
        MOVE.L  D1,ADDRESS_TO_CONVERT
        MOVE.B  #'#',(A2)+

CONVERT_TO_ASCII:
        ; A2 = Current spot within ADDRESS_STRING        MOVE.B  D4,D1G
        ; A3 = Current spot within ADDRESS_TO_CONVERT
        
        MOVE.B  #'$',(A2)+
        LEA ADDRESS_TO_CONVERT,A3
        MOVE.B  #0,D3
        
ASCII_LOOP:        
        ; Get nibble
        MOVE.B (A3),D1
        LSR.B   #4,D1
        
        ; Check if numeric or Hex
        CMP.B   #$09,D1
        BGT     MEM_CHR
        ADD.B   #$30,D1
        BRA     MEM_NUM
MEM_CHR:
        ADD.B   #$37,D1
MEM_NUM:
        ; Place ASCII
        MOVE.B  D1,(A2)+
        
        ; Slide over by 1 nibble
        MOVE.L  (A3),D4
        LSL.L   #4,D4
        MOVE.L D4,(A3)

        ;  Increment and compare/exit loop
        ADD.B   #1,D3
        CMP.B   D2,D3
        BLT     ASCII_LOOP

        MOVE.B  #0,(A2)
        MOVEM.L (SP)+,D1-D4/A2-A3
        RTS
ADDRESS_TO_CONVERT DCB.B 5,0
        NOP       
        


* This function prints the word length $data DATA variable
PRINT_DATA:
        MOVEM.L D0-D1/A1,-(SP)
        MOVE.B  #14,D0
        
        ; Memory Address
        MOVE.W  (ADDR),D1
        LEA     ADDR_STR,A1
        JSR     CONVERT_TO_ASCII_W
        TRAP    #15

        ; Tab
        LEA     sym_tab,A1
        TRAP    #15
        
        ; DATA
        LEA     op_DATA,A1
        TRAP    #15
        
        ; Tab
        LEA     sym_tab,A1
        TRAP    #15
        
        ; Data
        MOVE.W  (DATA),D1
        LEA     DATA_STR,A1
        JSR     CONVERT_TO_ASCII_W
        TRAP    #15
        
        ; New Line
        LEA     sym_crlf,A1
        TRAP    #15
        
        MOVEM.L (SP)+,D0-D1/A1
        RTS

        
MSG1    DC.B    'Welcome to Team Skynet''s disassembler!',CR,LF,CR,LF
        DC.B    'Please ensure that you have loaded any code that requires',CR,LF
        DC.B    'disassembly before continuing.',CR,LF,CR,LF
        DC.B    'Also, ensure that any addresses entered start with a "$".',CR,LF,CR,LF,0
MSG2    DC.B    'Please enter the starting address: ',0
MSG3    DC.B    CR,LF,'Please enter the ending address: ',0
MSG_ERR DC.B    CR,LF,'That address is in an incorrect format,',CR,LF
        DC.B    'It must be formatted as: $####',CR,LF,CR,LF,0
MSG_ERR_SEQ DC.B CR,LF,'The ending address is smaller than the starting address,',CR,LF
        DC.B    'The ending address must be greater to continue.',CR,LF,0
INPUT   DCB.B   80,0
STARTING_ADDRESS DC.W   $9000
ENDING_ADDRESS   DC.W   $933C
        NOP
GET_MEMORY_ADDRESS_RANGE:
        ;Print greeting message
        LEA     MSG1, A1
        MOVE.B  #14, D0
        TRAP    #15
        
CHECK_STARTING_ADDRESS:
        MOVE.B  #14, D0
        LEA     MSG2, A1
        TRAP    #15

        ;Get first address
        LEA     INPUT, A1
        MOVE.B  #2, D0
        TRAP    #15
        
        ;Get address
        LEA     STARTING_ADDRESS, A2
        JSR     CONVERT_ADDRESS
        
        CMP.B   #$00, (INPUT)
        BEQ     STARTING_ERROR
        
        BRA     CHECK_ENDING_ADDRESS

STARTING_ERROR:
        ;Print error message
        LEA     MSG_ERR, A1
        MOVE.B  #14, D0
        TRAP    #15
        BRA     CHECK_STARTING_ADDRESS
CHECK_ENDING_ADDRESS:
        ;Get ending address
        MOVE.B  #14, D0
        LEA     MSG3, A1
        TRAP    #15

        ;Get second address
        LEA     INPUT, A1
        MOVE.B  #2, D0
        TRAP    #15
        
        ;Get address
        LEA     ENDING_ADDRESS, A2
        JSR     CONVERT_ADDRESS
        
        CMP.B   #$00, (INPUT)
        BEQ     ENDING_ERROR
        
        MOVE.W  (ENDING_ADDRESS), D0
        CMP.W   (STARTING_ADDRESS), D0
        BLT     SEQUENTIAL_ERROR
        
        RTS

ENDING_ERROR:
        ;Print error message
        LEA     MSG_ERR, A1
        MOVE.B  #14, D0
        TRAP    #15
        BRA     CHECK_ENDING_ADDRESS
        
SEQUENTIAL_ERROR
        ;Print sequential error message
        LEA     MSG_ERR_SEQ, A1
        MOVE.B  #14, D0
        TRAP    #15
        BRA     CHECK_ENDING_ADDRESS

        
        
;Converts hex characters to ASCII characters found in INPUT
;And stores them at A2
;Must be in the format $####
;If error found, INPUT will be null #$00        
CONVERT_ADDRESS:
        LEA INPUT, A3 ;Pointer to ASCII character being converted
        ;Check for $ sign
        CMP.B   #'$', (A3)
        BNE     CONVERT_ADDRESS_ERR
        ADD.L   #1, A3
        
        MOVE.B  #0, D1
        
CONVERT_LOOP:
        ;Check for only 4 characters
        CMP.B   #2, D1
        BEQ     CONVERT_ADDRESS_ERR
        
        ;Check for correct hex characters
        CMP.B   #'0', (A3)
        BLT     CONVERT_ADDRESS_ERR
        CMP.B   #'F', (A3)
        BGT     CONVERT_ADDRESS_ERR
        CMP.B   #40, (A3)
        BEQ     CONVERT_ADDRESS_ERR
        ADD.L   #1, A3
        CMP.B   #'0', (A3)
        BLT     CONVERT_ADDRESS_ERR
        CMP.B   #'F', (A3)
        BGT     CONVERT_ADDRESS_ERR
        CMP.B   #40, (A3)
        BEQ     CONVERT_ADDRESS_ERR
        SUB.L   #1, A3
        
        ;Get 2 characters and move right nibble of each character to the right
        CLR.L     D0
        MOVE.W  (A3), D0
        LSL.B   #4, D0
        LSR.W   #4, D0
        
        ;Check if 1st number is alpha
        CMP.B   #$40, (A3)
        BLT     CONVERT_NUM2
        ADD.B   #$90, D0
CONVERT_NUM2:
        ADD.L   #1, A3
        ;Check if 2nd number is alpha
        CMP.B   #$40, (A3)
        BLT     CONVERT_CONTINUE
        ADD.B   #$9, D0
CONVERT_CONTINUE:
        ADD.L   #1, A3
        ;Move hex values to address
        MOVE.B  D0, (A2)
        ADD.L   #1, A2
        
        ;Increment counter
        ADD.L   #1, D1
        
        ;Check if end of string
        CMP.B   #$00, (A3)
        BNE     CONVERT_LOOP
        
        ;Make sure we have all 4 characters
        CMP.B   #2, D1
        BLT     CONVERT_ADDRESS_ERR
        
        RTS
        
CONVERT_ADDRESS_ERR:
        MOVE.B  #$00, (INPUT)
        RTS

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
