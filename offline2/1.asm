.MODEL MEDIUM

.STACK 100H

.DATA
    CR EQU 0DH
    LF EQU 0AH
    LARGEST2 DB ?
    LARGEST DB ?
    
    MSG DB CR,LF,'RESULT: $'
    MSG0 DB CR,LF,'All the numbers are equal $'
    MSG1 DB CR,LF,'ENTER X: $' 
    MSG2 DB CR,LF,'ENTER Y: $'
    MSG3 DB CR,LF,'ENTER Z: $'

.CODE

MAIN PROC
;initialize DS
    MOV AX, @DATA
    MOV DS, AX
;print user prompt for X
    LEA DX, MSG1
    MOV AH, 9
    INT 21H
;input X as BL    
    MOV AH, 1
    INT 21H                      
    SUB AL,48 
    MOV BL,AL     
;print user prompt for Y
    LEA DX, MSG2
    MOV AH, 9
    INT 21H
;input Y AS CL    
    MOV AH, 1
    INT 21H
    SUB AL,48
    MOV CL,AL
    CMP BL,CL
    JG LARGEST2Y
    JLE LARGEST2X 
;print user prompt for Z 
Z:
    LEA DX, MSG3
    MOV AH, 9
    INT 21H
;input Z     
    MOV AH, 1
    INT 21H
    SUB AL,48
    CMP LARGEST2,AL
    JL LARGEST2Z
    JE EQUALITY
    JMP SHOWRESULT
EQUALITY:
    MOV DL,LARGEST
    CMP LARGEST2,DL
    JE EQUALCASE 
LARGEST2Z:
    MOV LARGEST2,AL
    CMP LARGEST,AL
    JL MOVE
    JMP SHOWRESULT
MOVE:
    MOV AL,LARGEST
    MOV LARGEST2,AL
    JMP SHOWRESULT
LARGEST2Y:
    MOV LARGEST2,CL
    MOV LARGEST,BL
    JMP Z 
LARGEST2X:
    MOV LARGEST2,BL
    MOV LARGEST,CL
    JMP Z
SHOWRESULT:
    ADD LARGEST2,48
    LEA DX, MSG
    MOV AH, 9
    INT 21H    
    MOV AH, 2
    MOV DL, LARGEST2
    INT 21H
    JMP EXIT
EQUALCASE:
    LEA DX, MSG0
    MOV AH, 9
    INT 21H   
;DOX exit
EXIT:
    MOV AH, 4CH
    INT 21H
MAIN ENDP
    END MAIN