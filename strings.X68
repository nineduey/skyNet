op_ADD   DC.B   'ADD',0
op_ADDA  DC.B   'ADDA',0
op_ADDQ  DC.B   'ADDQ',0
op_AND   DC.B   'AND',0
op_ASL   DC.B   'ASL',0
op_ASR   DC.B   'ASR',0
op_BEQ   DC.B   'BEQ',0
op_BGT   DC.B   'BGT',0
op_BLE   DC.B   'BLE',0
op_BRA   DC.B   'BRA',0
op_JSR   DC.B   'JSR',0
op_LEA   DC.B   'LEA',0
op_LSL   DC.B   'LSL',0
op_LSR   DC.B   'LSR',0
op_MOVE  DC.B   'MOVE',0
op_MOVEA DC.B   'MOVEA',0
op_MOVEM DC.B   'MOVEM',0
op_MOVEQ DC.B   'MOVEQ',0
op_NOP   DC.B   'NOP',0
op_NOT   DC.B   'NOT',0
op_OR    DC.B   'OR',0
op_ROL   DC.B   'ROL',0
op_ROR   DC.B   'ROR',0
op_RTS   DC.B   'RTS',0
op_SUB   DC.B   'SUB',0

reg_D0   DC.B   'D0',0
reg_D1   DC.B   'D1',0
reg_D2   DC.B   'D2',0
reg_D3   DC.B   'D3',0
reg_D4   DC.B   'D4',0
reg_D5   DC.B   'D5',0
reg_D6   DC.B   'D6',0
reg_D7   DC.B   'D7',0
reg_A0   DC.B   'A0',0
reg_A1   DC.B   'A1',0
reg_A2   DC.B   'A2',0
reg_A3   DC.B   'A3',0
reg_A4   DC.B   'A4',0
reg_A5   DC.B   'A5',0
reg_A6   DC.B   'A6',0
reg_A7   DC.B   'A7',0

reg_A0i   DC.B   '(A0)',0
reg_A1i   DC.B   '(A1)',0
reg_A2i   DC.B   '(A2)',0
reg_A3i   DC.B   '(A3)',0
reg_A4i   DC.B   '(A4)',0
reg_A5i   DC.B   '(A5)',0
reg_A6i   DC.B   '(A6)',0
reg_A7i   DC.B   '(A7)',0

reg_A0ipi   DC.B   '(A0)+',0
reg_A1ipi   DC.B   '(A1)+',0
reg_A2ipi   DC.B   '(A2)+',0
reg_A3ipi   DC.B   '(A3)+',0
reg_A4ipi   DC.B   '(A4)+',0
reg_A5ipi   DC.B   '(A5)+',0
reg_A6ipi   DC.B   '(A6)+',0
reg_A7ipi   DC.B   '(A7)+',0

reg_A0ipd   DC.B   '-(A0)',0
reg_A1ipd   DC.B   '-(A1)',0
reg_A2ipd   DC.B   '-(A2)',0
reg_A3ipd   DC.B   '-(A3)',0
reg_A4ipd   DC.B   '-(A4)',0
reg_A5ipd   DC.B   '-(A5)',0
reg_A6ipd   DC.B   '-(A6)',0
reg_A7ipd   DC.B   '-(A7)',0

size_B      DC.B '.B',0
size_W      DC.B '.W',0
size_L      DC.B '.L',0

sym_literal DC.B '#',0
sym_hex     DC.B '$',0
sym_comma   DC.B ',',0
sym_space   DC.B ' ',0
sym_crlf    DC.B CR,LF,0
sym_tab     DC.B TAB,0
sym_NULL    DC.B 0


CR      EQU     $0D
LF      EQU     $0A
TAB     EQU     $09

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
