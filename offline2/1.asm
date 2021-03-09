.MODEL MEDIUM

.STACK 100H

.DATA
    CR EQU 0DH
    LF EQU 0AH
    X DB ?
    Y DB ?
    Z DB ?
    LARGEST2 DB ?
    
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
;input X    
    MOV AH, 1
    INT 21H                      
    SUB AL,48 
    MOV X,AL     
;print user prompt for Y
    LEA DX, MSG2
    MOV AH, 9
    INT 21H
;input Y     
    MOV AH, 1
    INT 21H
    SUB AL,48
    MOV Y,AL
    CMP X,Y
    JLE LARGEST2Y
    JG LARGEST2X  
;print user prompt for Z
    LEA DX, MSG3
    MOV AH, 9
    INT 21H
;input Z     
    MOV AH, 1
    INT 21H
    SUB AL,48
    MOV Z,AL
    CMP LARGEST2,Z
    JL LARGEST2Z
    JE EQUALCASE
    JMP SHOWRESULT 
LARGEST2Z:
    MOV LARGEST2,Z
    JMP SHOWRESULT
LARGEST2Y:
    MOV LARGEST2,Y
LARGEST2X:
    MOV LARGEST2,X
SHOWRESULT:
    ADD LARGEST2,48
    LEA DX, MSG
    MOV AH, 9
    INT 21H    
    MOV AH, 2
    MOV DL, LARGEST2
    INT 21H
EQUALCASE:
        
;DOX exit
    MOV AH, 4CH
    INT 21H
  
MAIN ENDP

    END MAIN