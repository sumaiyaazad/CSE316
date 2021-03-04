.MODEL MEDIUM

.STACK 100H

.DATA
    CR EQU 0DH
    LF EQU 0AH
    Z DB ?
    
    MSG DB CR, LF,'RESULT: $'
    MSG1 DB CR, LF,'ENTER A NUMBER(X): $' 
    MSG2 DB CR,LF,'ENTER ANOTHER NUMBER(Y): $'
    MSG3 DB CR, LF, 'X-2Y: $'
    MSG4 DB CR, LF, '25-(X+Y): $' 
    MSG5 DB CR, LF, '2X-3Y: $'
    MSG6 DB CR, LF, 'Y-X+1: $'

.CODE

MAIN PROC
;initialize DS
    MOV AX, @DATA
    MOV DS, AX

;print user operation
    LEA DX, MSG3
    MOV AH, 9
    INT 21H   
;print user prompt
    LEA DX, MSG1
    MOV AH, 9
    INT 21H
;input X    
    MOV AH, 1
    INT 21H                      
    SUB AL,48 
    MOV Z,AL     
;print user prompt
    LEA DX, MSG2
    MOV AH, 9
    INT 21H
;input Y     
    MOV AH, 1
    INT 21H
    SUB AL,48
    SUB Z,AL
    SUB Z,AL
    ADD Z,48   
;display on the next line
    LEA DX, MSG
    MOV AH, 9
    INT 21H   
;display Z  
    MOV AH, 2
    MOV DL, Z
    INT 21H
   
     
;print user operation
    LEA DX, MSG4
    MOV AH, 9
    INT 21H
;print user prompt
    LEA DX, MSG1
    MOV AH, 9
    INT 21H
;input X    
    MOV AH, 1
    INT 21H                     
    SUB AL,48 
    MOV Z,AL     
;print user prompt
    LEA DX, MSG2
    MOV AH, 9
    INT 21H
;input Y     
    MOV AH, 1
    INT 21H
    SUB AL,48
    ADD Z,AL
    NEG Z
    ADD Z,73    
;display on the next line
    LEA DX, MSG
    MOV AH, 9
    INT 21H    
;display Z  
    MOV AH, 2 
    MOV DL, Z
    INT 21H   
       
             
;print user operation
    LEA DX, MSG5
    MOV AH, 9
    INT 21H
;print user prompt
    LEA DX, MSG1
    MOV AH, 9
    INT 21H
;input X    
    MOV AH, 1
    INT 21H                     
    SUB AL,48 
    MOV Z,AL
    ADD Z,AL     
;print user prompt
    LEA DX, MSG2
    MOV AH, 9
    INT 21H
;input Y     
    MOV AH, 1
    INT 21H
    SUB AL,48
    SUB Z,AL
    SUB Z,AL
    SUB Z,AL
    ADD Z,48    
;display on the next line
    LEA DX, MSG
    MOV AH, 9
    INT 21H         
;display Z  
    MOV AH, 2 
    MOV DL, Z
    INT 21H 
       
       
;print user operation
    LEA DX, MSG6
    MOV AH, 9
    INT 21H
;print user prompt
    LEA DX, MSG1
    MOV AH, 9
    INT 21H
;input X    
    MOV AH, 1
    INT 21H                     
    SUB AL,48 
    MOV Z,AL
    NEG Z     
;print user prompt
    LEA DX, MSG2
    MOV AH, 9
    INT 21H
;input Y     
    MOV AH, 1
    INT 21H
    SUB AL,48
    ADD Z,AL
    ADD Z,49    
;display on the next line
    LEA DX, MSG
    MOV AH, 9
    INT 21H         
;display Z  
    MOV AH, 2 
    MOV DL, Z
    INT 21H       
;DOX exit
    MOV AH, 4CH
    INT 21H
  
MAIN ENDP

    END MAIN