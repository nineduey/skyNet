*-----------------------------------------------------------
* Title      : CSS 422 - Skynet (Group 1) - Disassembly Project
* Written by : Amanda Todakonzie, Blaine Wenzel, Irwin Li
* Date       : 7/8/2022
* Description: This program disassembles instructions loaded
*              into a location in memory
*-----------------------------------------------------------
    ORG    $1000
START:
    JSR     GET_MEMORY_ADDRESS_RANGE
    
    CLR.L   D0
    MOVE.W (STARTING_ADDRESS), D0
    MOVE.L  D0, A6

    ; Loop through the designated memory
DIS_LOOP:
    ; Code goes here to check opcode word and additional words if necessary
    ; Increment A6 according to how many bytes the instruction takes
    MOVE.W  A6,(ADDR)
    JSR     GET_OPCODE
    
    ;Check to see if we have hit the last address
    CLR.L   D0
    MOVE.W (ENDING_ADDRESS), D0
    CMP.L   D0, A6
    BLT     DIS_LOOP
    JMP END
    
    ; Extension files
    INCLUDE 'io.x68'
    INCLUDE 'opcode.x68'
    INCLUDE 'ea.x68'
    INCLUDE 'strings.x68'
    
    ; Example code that needs to be disassembled, starting at memory location $9000
    INCLUDE 'dis_test.x68'   

END:
    END    START





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
