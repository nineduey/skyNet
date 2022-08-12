op_ADD   DC.L   'ADD',0
op_ADDA  DC.L   'ADDA',0
op_ADDQ  DC.L   'ADDQ',0
op_AND   DC.L   'AND',0
op_JSR   DC.L   'JSR',0
op_LEA   DC.L   'LEA',0
op_MOVE  DC.L   'MOVE',0
op_MOVEA DC.L   'MOVEA',0
op_MOVEM DC.L   'MOVEM',0
op_MOVEQ DC.L   'MOVEQ',0
op_NOP   DC.L   'NOP',0
op_NOT   DC.L   'NOT',0
op_OR    DC.L   'OR',0
op_RTS   DC.L   'RTS',0
op_SUB   DC.L   'SUB',0
op_DATA  DC.L   'DATA',0

op_SET_SHIFT:
op_ASR   DC.L   'ASR',0
op_LSR   DC.L   'LSR',0
op_R_GAP DC.L   '   ',0
op_ROR   DC.L   'ROR',0
op_ASL   DC.L   'ASL',0
op_LSL   DC.L   'LSL',0
op_L_GAP DC.L   '   ',0
op_ROL   DC.L   'ROL',0

op_SET_BCC:
op_BRA   DC.L   'BRA',0
op_BF    DC.L   'BF',0
op_BHI   DC.L   'BHI',0
op_BLS   DC.L   'BLS',0
op_BCC   DC.L   'BCC',0
op_BCS   DC.L   'BCS',0
op_BNE   DC.L   'BNE',0
op_BEQ   DC.L   'BEQ',0
op_BVC   DC.L   'BVC',0
op_BVS   DC.L   'BVS',0
op_BPL   DC.L   'PL',0
op_BMI   DC.L   'BMI',0
op_BGE   DC.L   'BGE',0
op_BLT   DC.L   'BLT',0
op_BGT   DC.L   'BGT',0
op_BLE   DC.L   'BLE',0

reg_SET_D:
reg_D0   DC.L   'D0',0
reg_D1   DC.L   'D1',0
reg_D2   DC.L   'D2',0
reg_D3   DC.L   'D3',0
reg_D4   DC.L   'D4',0
reg_D5   DC.L   'D5',0
reg_D6   DC.L   'D6',0
reg_D7   DC.L   'D7',0

reg_SET_A:
reg_A0   DC.L   'A0',0
reg_A1   DC.L   'A1',0
reg_A2   DC.L   'A2',0
reg_A3   DC.L   'A3',0
reg_A4   DC.L   'A4',0
reg_A5   DC.L   'A5',0
reg_A6   DC.L   'A6',0
reg_A7   DC.L   'A7',0

reg_SET_Ai:
reg_A0i   DC.L   '(A0)',0
reg_A1i   DC.L   '(A1)',0
reg_A2i   DC.L   '(A2)',0
reg_A3i   DC.L   '(A3)',0
reg_A4i   DC.L   '(A4)',0
reg_A5i   DC.L   '(A5)',0
reg_A6i   DC.L   '(A6)',0
reg_A7i   DC.L   '(A7)',0

reg_SET_Aipi:
reg_A0ipi   DC.L   '(A0)+',0
reg_A1ipi   DC.L   '(A1)+',0
reg_A2ipi   DC.L   '(A2)+',0
reg_A3ipi   DC.L   '(A3)+',0
reg_A4ipi   DC.L   '(A4)+',0
reg_A5ipi   DC.L   '(A5)+',0
reg_A6ipi   DC.L   '(A6)+',0
reg_A7ipi   DC.L   '(A7)+',0

reg_SET_Aipd:
reg_A0ipd   DC.L   '-(A0)',0
reg_A1ipd   DC.L   '-(A1)',0
reg_A2ipd   DC.L   '-(A2)',0
reg_A3ipd   DC.L   '-(A3)',0
reg_A4ipd   DC.L   '-(A4)',0
reg_A5ipd   DC.L   '-(A5)',0
reg_A6ipd   DC.L   '-(A6)',0
reg_A7ipd   DC.L   '-(A7)',0

size_SET:
size_B      DC.L '.B',0
size_W      DC.L '.W',0
size_L      DC.L '.L',0

size2_SET:
size2_B      DC.L '.B',0
size2_L      DC.L '.L',0
size2_W      DC.L '.W',0

sym_literal DC.B '#',0
sym_hex     DC.B '$',0
sym_comma   DC.B ',',0
sym_space   DC.B ' ',0
sym_crlf    DC.B CR,LF,0
sym_tab     DC.B TAB,0
sym_NULL    DC.B 0
sym_8       DC.L '#$8',0
sym_TEST    DC.B 'ABCDEFG'
    NOT.L    D0


CR      EQU     $0D
LF      EQU     $0A
TAB     EQU     $09


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
