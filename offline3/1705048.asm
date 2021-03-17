.MODEL MEDIUM

.STACK 100H

.DATA
    CR EQU 0DH
    LF EQU 0AH
    OPERAND1 DW 0
    OPERAND2 DW 0
    OPERATOR DB 0
    SIGN1 DW 0 
    SIGN2 DW 0
    SIGN DW 0
    
    MSGERROR DB CR,LF,' Wrong operator $'
    MSG1 DB CR,LF,' Enter 1st number: $'
    MSG2 DB CR,LF,' Enter 2nd number: $'
    MSG DB CR,LF,' $'

.CODE

MAIN PROC
;initialize DS
    MOV AX, @DATA
    MOV DS, AX 
;print user prompt for 1st number
NUMBER1:
    LEA DX, MSG1
    MOV AH, 9
    INT 21H
INPUTNUMBER1: 
    MOV SIGN1,0
    MOV BX,0
	MOV AH, 1
	INT 21H
	CMP AL,2DH
	JE SIGNCHANGE1
	MOV BL,AL  
	SUB BX,48
	JMP NUMBERIN1
SIGNCHANGE1:
    MOV SIGN1,1
NUMBERIN1:
    MOV AH, 1
    INT 21H
    CMP AL,0DH
    JE INPUTOPERATOR
    CMP AL,30H
    JL NUMBERIN1
    CMP AL,39H
    JG NUMBERIN1
    SUB AL,48
    ;save the input digit in cl
    MOV CL,AL 
    MOV AX,10
    MUL BX
    ;move the result of the multiplication to bx
    MOV BX,AX
    ;add input digit 
    ADD BL,CL
    JMP NUMBERIN1
INPUTOPERATOR:
    LEA DX, MSG
    MOV AH, 9
    INT 21H
    MOV OPERAND1,BX
    MOV AH,1
    INT 21H
    CMP AL,71
    JE EXIT
    CMP AL,42
    JE FIXOPERATOR
    CMP AL,43
    JE FIXOPERATOR
    CMP AL,45
    JE FIXOPERATOR
    CMP AL,47
    JE FIXOPERATOR
    LEA DX, MSGERROR
    MOV AH, 9
    INT 21H
    JMP EXIT
FIXOPERATOR:
    MOV OPERATOR,AL
;print user prompt for 2nd number
NUMBER2:
    LEA DX, MSG2
    MOV AH, 9
    INT 21H
INPUTNUMBER2: 
    MOV SIGN2,0
    MOV BX,0
	MOV AH, 1
	INT 21H
	CMP AL,2DH
	JE SIGNCHANGE2
	MOV BL,AL  
	SUB BX,48
	JMP NUMBERIN2
SIGNCHANGE2:
    MOV SIGN2,1
NUMBERIN2:
    MOV AH, 1
    INT 21H
    CMP AL,0DH
    JE OUTPUTNUMBER1
    CMP AL,30H
    JL NUMBERIN2
    CMP AL,39H
    JG NUMBERIN2
    SUB AL,48
    ;save the input digit in cl
    MOV CL,AL 
    MOV AX,10
    MUL BX
    ;move the result of the multiplication to bx
    MOV BX,AX
    ;add input digit 
    ADD BL,CL
    JMP NUMBERIN2 
OUTPUTNUMBER1:
    MOV OPERAND2,BX
    LEA DX, MSG
    MOV AH, 9
    INT 21H
    MOV AX,OPERAND1
    MOV CX,10000
    XOR DX,DX
    DIV CX
    ADD AX,48 
    MOV AH, 2
    ;move remaider to cx before changing dl
    MOV CX,DX
    MOV DL,AL 
    INT 21H
    ;move remainder to ax
    MOV AX,CX
    MOV CX,1000
    XOR DX,DX
    DIV CX
    ADD AX,48
    MOV AH, 2
    MOV CX,DX
    MOV DL,AL 
    INT 21H   
    MOV AX,CX
    MOV CX,100
    XOR DX,DX
    DIV CX
    ADD AX,48
    MOV AH, 2
    MOV CX,DX
    MOV DL,AL 
    INT 21H
    MOV AX,CX
    MOV CX,10 
    XOR DX,DX
    DIV CX
    ADD AX,48
    MOV AH, 2
    MOV CX,DX
    MOV DL,AL 
    INT 21H
    ADD CX,48
    MOV DL,CL
    MOV AH, 2
    INT 21H
    ; operator print
    MOV DL,OPERATOR
    MOV AH,2
    INT 21H
OUTPUTNUMBER2:
    MOV OPERAND2,BX
    MOV AX,OPERAND2
    MOV CX,10000
    XOR DX,DX
    DIV CX
    ADD AX,48 
    MOV AH, 2
    ;move remaider to cx before changing dl
    MOV CX,DX
    MOV DL,AL 
    INT 21H
    ;move remainder to ax
    MOV AX,CX
    MOV CX,1000
    XOR DX,DX
    DIV CX
    ADD AX,48
    MOV AH, 2
    MOV CX,DX
    MOV DL,AL 
    INT 21H   
    MOV AX,CX
    MOV CX,100
    XOR DX,DX
    DIV CX
    ADD AX,48
    MOV AH, 2
    MOV CX,DX
    MOV DL,AL 
    INT 21H
    MOV AX,CX
    MOV CX,10 
    XOR DX,DX
    DIV CX
    ADD AX,48
    MOV AH, 2
    MOV CX,DX
    MOV DL,AL 
    INT 21H
    ADD CX,48
    MOV DL,CL
    MOV AH, 2
    INT 21H 
;DOX exit
EXIT:
    MOV AH, 4CH
    INT 21H
MAIN ENDP
    END MAIN
    
     
    
    
           
    
    
     
    


