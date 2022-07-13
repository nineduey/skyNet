* This function prints the strings in A2, A3, A4, & A5 formatted
* A2 = OPCode, A3 = Size, A4 = Source, A5 = Destination
* Register needs to be sym_NULL if blank
PRINT:
        MOVEM.L A1/D0,-(SP)

        ; tab
        MOVE.B  #14,D0
        LEA     sym_tab,A1
        TRAP    #15

        ; OPCode
        MOVEA.L A2,A1
        TRAP    #15
        
        ; Size
        MOVEA.L A3,A1
        TRAP    #15
        
        CMP.B   #0,(A4)
        BEQ     SKIP_TO_CRLF
        
        ; x2 Tabs
        LEA     sym_tab,A1
        TRAP    #15
        TRAP    #15
        
        ; Source
        MOVEA.L A4,A1
        TRAP    #15
        
        CMP.B   #0,(A5)
        BEQ     SKIP_TO_CRLF
        
        ; Comma
        LEA     sym_comma,A1
        TRAP    #15
        
        ; Space
        LEA     sym_space,A1
        TRAP    #15
        
        ; Destination
        MOVEA.L A5,A1
        TRAP    #15
        
SKIP_TO_CRLF:        
        ; New Line
        LEA     sym_crlf,A1
        TRAP    #15
        
        MOVEM.L (SP)+,A1/D0
        RTS

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
