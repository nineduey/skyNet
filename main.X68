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
    MOVE.W  A6,(ADDR)
    JSR     GET_OPCODE
    

    ; Print Examples (uncomment to see them print)
    ;Print data $ABC9
    ;MOVE.W  #$2000,(ADDR)
    ;MOVE.W  #$ABC9,(DATA)
    ;JSR     PRINT_DATA
    
    ; Print MOVE.B A1, A2
    ;MOVE.W  #$2010,(ADDR)
    ;MOVE.L  #op_MOVE,(OPCODE)
    ;MOVE.L  #size_B,(SIZE)
    ;MOVE.L  #reg_A1,(SOURCE)
    ;MOVE.L  #reg_A2,(DEST)
    ;JSR     PRINT
    
    ; Print ADD.B #$100, $FFFFAAAA
    ;MOVE.W  #$2020,(ADDR)
    ;MOVE.L  #op_ADD,(OPCODE)
    ;MOVE.L  #size_B,(SIZE)
    ; Convert #$1 to immediate string
    ;MOVE.L  #$100,D1
    ;MOVE.L  #SOURCE_STR,A1
    ;JSR     CONVERT_TO_ASCII_IMMEDIATE
    ;MOVE.L  #SOURCE_STR,(SOURCE)
    ; Convert #$FFFFAAAA to ASCII long
    ;MOVE.L  #$FFFFAAAA,D1
    ;MOVE.L  #DEST_STR,A1
    ;JSR     CONVERT_TO_ASCII_L
    ;MOVE.L  #DEST_STR,(DEST)
    ;JSR     PRINT
    
    ; Print NOP
    ;MOVE.W  #$2030,(ADDR)
    ;MOVE.L  #op_NOP,(OPCODE)
    ;MOVE.L  #sym_NULL,(SIZE)
    ;MOVE.L  #sym_NULL,(SOURCE)
    ;MOVE.L  #sym_NULL,(DEST)
    ;JSR     PRINT

    ; If next word in memory is FFFF, then we have hit end of disassembly code
    CMPI.W  #$FFFF,(A6)
    BNE     DIS_LOOP
    JMP END

    ; Example code that needs to be disassembled, starting at memory location $9000
    INCLUDE 'dis_test.x68'   
    
    ; Extension files
    INCLUDE 'io.x68'
    INCLUDE 'opcode2.x68'
    INCLUDE 'ea.x68'
    INCLUDE 'strings.x68'

END:
    END    START



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
