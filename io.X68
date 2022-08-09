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
        
        MOVEA.L SOURCE,A1
        CMP.B   #0,(A1)
        BEQ     SKIP_TO_CRLF
        
        ; Tab
        LEA     sym_tab,A1
        TRAP    #15
        
        ; Source
        MOVEA.L SOURCE,A1
        TRAP    #15
        
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
        MOVE.W  D1,ADDRESS_TO_CONVERT
        CLR.L   D2
        MOVE.L  D1,D3
        
IMM_LOOP:
        LSR.L   #4,D3
        ADD.B   #1,D2
        CMP.L   #0,D3
        BNE     IMM_LOOP
        
        MOVE.L  #8,D3
        SUB.L   D2,D3
IMM_SHIFT_LOOP:
        LSL.L   #4,D1
        SUB.L   #1,D3
        CMP.L   #0,D3
        BNE     IMM_SHIFT_LOOP
        
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



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
