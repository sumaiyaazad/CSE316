.MODEL SMALL

.STACK 100H

.DATA
    CR EQU 0DH
    LF EQU 0AH
    COMPLEMENT DB 0FFFFH
    
    MSG1 DB 'ENTER A UPPER CASE LETTER: $'
    MSG2 DB CR, LF, '1S COMPLEMENT OF THE LETTER: $'
    CHAR DB ?

.CODE

MAIN PROC
;initialize DS
    MOV AX, @DATA
    MOV DS, AX
    
;print user prompt
    LEA DX, MSG1
    MOV AH, 9
    INT 21H

;input a upper case character and convert it to lower case     
    MOV AH, 1
    INT 21H 
    SUB COMPLEMENT,AL
    
;display on the next line
    LEA DX, MSG2
    MOV AH, 9
    INT 21H  
    
;display the lower case character  
    MOV AH, 2
    MOV DL, COMPLEMENT
    INT 21H
    
    
;DOX exit
    MOV AH, 4CH
    INT 21H
  
MAIN ENDP

    END MAIN