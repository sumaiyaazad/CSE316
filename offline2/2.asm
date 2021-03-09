.MODEL MEDIUM

.STACK 100H

.DATA
    CR EQU 0DH
    LF EQU 0AH
    CHECKDIG DB  0
    CHECKUP DB 0
    CHECKLOW DB 0
    
    MSG DB CR,LF,'Enter password: $'
    MSG1 DB CR,LF,'Valid password $'
    MSG2 DB CR,LF,'Invalid password $'

.CODE

MAIN PROC
;initialize DS
    MOV AX, @DATA
    MOV DS, AX
;print user prompt for PASSWORD
    LEA DX, MSG
    MOV AH, 9
    INT 21H
;input X
USERINPUT:    
    MOV AH, 1
    INT 21H
    CMP AL,21H
    JNGE VALIDITY
    CMP AL,7EH
    JNLE VALIDITY
    CMP AL,30H
    JNGE USERINPUT
    CMP AL,39H
    JLE DIG1                      
    CMP AL,41H
    JNGE USERINPUT
    CMP AL,5AH
    JLE UP1
    CMP AL,61H
    JNGE USERINPUT
    CMP AL,7AH
    JLE LOW1
    JMP USERINPUT
DIG1:
    MOV CHECKDIG,1
    JMP USERINPUT   
UP1:
    MOV CHECKUP,1
    JMP USERINPUT
LOW1:
    MOV CHECKLOW,1
    JMP USERINPUT
VALIDITY:
    CMP CHECKDIG,1
    JNE INVALID
    CMP CHECKUP,1
    JNE INVALID
    CMP CHECKLOW,1
    JNE INVALID
    LEA DX, MSG1
    MOV AH, 9
    INT 21H
    JMP EXIT
INVALID:
    LEA DX, MSG2
    MOV AH, 9
    INT 21H   
;DOX exit
EXIT:
    MOV AH, 4CH
    INT 21H
MAIN ENDP
    END MAIN