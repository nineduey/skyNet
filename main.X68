*-----------------------------------------------------------
* Title      : CSS 422 - Skynet (Group 1) - Disassembly Project
* Written by : Amanda Todakonzie, Blaine Wenzel, Irwin Li
* Date       : 7/8/2022
* Description: This program disassembles instructions loaded
*              into a location in memory
*-----------------------------------------------------------
    ORG    $1000
START:
    MOVEA.L #$00009000, A6 ; A6 holds the current memory location of the disassembler
    
    ; Loop through the designated memory
DIS_LOOP:
    ; Code goes here to check opcode word and additional words if necessary
    ; Increment A6 according to how many bytes the instruction takes



    ; If next word in memory is FFFF, then we have hit end of disassembly code
    CMPI.W  #$FFFF,(A6)
    BEQ     END_JMP
    JMP     DIS_LOOP
END_JMP JMP END

; Example code that needs to be disassembled, starting at memory location $9000
    INCLUDE 'dis_test.x68'

END:
    END    START
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~