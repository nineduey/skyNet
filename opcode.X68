* D2 Keeps track of the size of the instruction

* NOP Op-Code 
NOP_OPCODE:     
                MOVE.B      #'N',(A2)+
                MOVE.B      #'O',(A2)+
                MOVE.B      #'P',(A2)+
                
                RTS

* MOVE.B Op-Code
MOVEB_OPCODE:
                MOVE.B      #'M',(A2)+
                MOVE.B      #'O',(A2)+
                MOVE.B      #'V',(A2)+
                MOVE.B      #'E',(A2)+
                MOVE.B      #'.',(A2)+
                
                
                CLR.L       D2              ; Clear the contents of D2 which keeps track of the size of the instruction
                JSR         PRINT_SIZE
                
* Subroutine: SIZE
* Determines the size and adds it to the string
PRINT_SIZE:
                CMP.B       #0,D2           ; Is the size of the instruction a byte (.B)?
                BEQ         SIZE_BYTE       ; If so branch to SIZE_BYTE
                
                CMP.B       #1,D2           ; Is the size of the instruction a word (.W)?
                BEQ         SIZE_WORD       ; If so branch to SIZE_WORD
                
                CMP.B       #2,D2           ; Is the size of the instruction a long-word (.L)?
                BEQ         SIZE_LONG       ; If so branch to SIZE_LONG
                
SIZE_BYTE:
                MOVE.B      #'B',(A2)+      ; Add the byte indicator (.B) to the string
                MOVE.B      #' ',(A2)+
                RTS
SIZE_WORD:
                MOVE.B      #'W',(A2)+      ; Add the word indicator (.W) to the string
                MOVE.B      #' ',(A2)+      
                RTS
SIZE_LONG:
                MOVE.B      #'L',(A2)+      ; Add the long-word indicator (.L) to the string
                MOVE.B      #' ',(A2)+  
                RTS











*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
