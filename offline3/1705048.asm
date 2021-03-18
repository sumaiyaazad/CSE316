.MODEL MEDIUM

.STACK 100H

.DATA
    CR EQU 0DH
    LF EQU 0AH
    OPERAND1 DW 0
    OPERAND2 DW 0
    OPERATOR DB 0
    SIGN1 DB 0 
    SIGN2 DB 0 
    RESULT DW 0
    RESULTSIGN DB 0
    
    MSGERROR DB CR,LF,' Wrong operator $'
    MSG1 DB CR,LF,' Enter operand1: $'
    MSG2 DB CR,LF,' Enter operand2: $'
    MSG3 DB CR,LF,' Enter operator: $'
    
    MSGBR1 DB '[$'
    MSGBR2 DB ']$' 
    MSG DB CR,LF,' $'
    MINUS DW '-$'
    EQUAL DW '=$'

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
    MOV OPERAND1,BX
    LEA DX, MSG3
    MOV AH, 9
    INT 21H
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
    JE PRINT1
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
PRINT1:
    MOV OPERAND2,BX 
    LEA DX, MSG
    MOV AH, 9
    INT 21H
    LEA DX, MSGBR1
    MOV AH, 9
    INT 21H
    CMP SIGN1,1
    JNE OUTPUTNUMBER1 
    LEA DX, MINUS
    MOV AH, 9
    INT 21H     
OUTPUTNUMBER1: 
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
    LEA DX, MSGBR2
    MOV AH, 9
    INT 21H 
OPERATORPRINT:
    ; operator print
    LEA DX, MSGBR1
    MOV AH, 9
    INT 21H
    MOV DL,OPERATOR
    MOV AH,2
    INT 21H
    LEA DX, MSGBR2
    MOV AH, 9
    INT 21H
PRINT2:
    LEA DX, MSGBR1
    MOV AH, 9
    INT 21H
    CMP SIGN2,1
    JNE OUTPUTNUMBER2 
    LEA DX, MINUS
    MOV AH, 9
    INT 21H
OUTPUTNUMBER2:
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
    LEA DX, MSGBR2
    MOV AH, 9
    INT 21H 
    ;print equal sign
    LEA DX, EQUAL
    MOV AH, 9
    INT 21H
OPERATORCHECK:
    CMP OPERATOR,42
    JE MULTIPLICATION
    CMP OPERATOR,43
    JE ADDITION1
    CMP OPERATOR,45
    JE SUBTRACTION1 
DIVISION:
    MOV AL,SIGN2
    MOV RESULTSIGN,AL
    MOV AL,SIGN1
    XOR RESULTSIGN,AL
    ;ADD RESULTSIGN,48 
    MOV AX,OPERAND1
    XOR DX,DX
    DIV OPERAND2
    MOV RESULT,AX
    JMP PRINTSIGN
SUBTRACTION1:
    CMP SIGN1,1
    JNE SUBTRACTION2
    CMP SIGN2,0 
    JNE SUBTRACTION3 
    ;sign of 1st operand is 1 and sign of 2nd operand is 0, so resultsign 1
    MOV RESULTSIGN,1
    MOV BX,OPERAND1
    MOV RESULT,BX
    MOV BX,OPERAND2
    ADD RESULT,BX   
    JMP PRINTSIGN
;sign of the 1st operand is 0
SUBTRACTION2:
    CMP SIGN2,1
    JE SUBTRACTION4 
    ;sign of both operands 0
    MOV BX,OPERAND2
    CMP OPERAND1,BX
    JL RESULTSIGN3
    ;result sign 0 cause 1st operand is greater or equal and both sign 0
    MOV RESULTSIGN,0
    MOV BX,OPERAND1
    MOV RESULT,BX
    MOV BX,OPERAND2
    SUB RESULT,BX
    JMP PRINTSIGN
;both operand sign 0 but operand2>operand1 so result sign 1
RESULTSIGN3:
    MOV RESULTSIGN,1
    MOV BX,OPERAND2
    MOV RESULT,BX
    MOV BX,OPERAND1
    SUB RESULT,BX
    JMP PRINTSIGN
;both operand sign 1
SUBTRACTION3:
   MOV BX,OPERAND1
   CMP OPERAND2,BX
   JL  RESULTSIGN4
   ;both sign 1 but operand2>=operand1 so result sign 0
   MOV RESULTSIGN,0
   MOV BX,OPERAND2
   MOV RESULT,BX
   MOV BX,OPERAND1
   SUB RESULT,BX
   JMP PRINTSIGN
;both operand sign 1 and operand2<operand1 , so result sign 1
RESULTSIGN4:
   MOV RESULTSIGN,1
   MOV BX,OPERAND1
   MOV RESULT,BX
   MOV BX,OPERAND2
   SUB RESULT,BX
   JMP PRINTSIGN  
;sign of the 1st operand is 0 and sign of the 2nd operand is 1 so result sign 0
SUBTRACTION4:
    MOV RESULTSIGN,0
    MOV BX,OPERAND1
    MOV RESULT,BX
    MOV BX,OPERAND2
    ADD RESULT,BX
    JMP PRINTSIGN
ADDITION1:
    CMP SIGN1,1
    JNE ADDITION2
    CMP SIGN2,1 
    JNE ADDITION3 
    ;sign of both operand is 1
    MOV RESULTSIGN,1
    MOV BX,OPERAND1
    MOV RESULT,BX
    MOV BX,OPERAND2
    ADD RESULT,BX   
    JMP PRINTSIGN
;sign of the 1st operand is 0
ADDITION2:
    CMP SIGN2,0
    JE ADDITION4
    ;sign of the 2nd operand is 1
    MOV BX,OPERAND2
    CMP OPERAND1,BX
    JL RESULTSIGN1
    ;operand1 gretaer than or equal to operand2, result sign 0
    MOV RESULTSIGN,0 
    MOV BX,OPERAND1
    MOV RESULT,BX
    MOV BX,OPERAND2
    SUB RESULT,BX
    JMP PRINTSIGN
RESULTSIGN1:
    ;2nd operand is greater than 1st operand and result sign 1(1st operand + and 2nd opearnd -)
    MOV RESULTSIGN,1
    MOV BX,OPERAND2
    MOV RESULT,BX
    MOV BX,OPERAND1
    SUB RESULT,BX
    JMP PRINTSIGN
;sign of the 1st opearnd is 1 and 2nd operand is 0
ADDITION3:
    MOV BX,OPERAND1 
    CMP OPERAND2,BX
    JL RESULTSIGN2
    ;2nd operand is greater than or equal to 1st operand
    MOV RESULTSIGN,0
    MOV BX,OPERAND2
    MOV RESULT,BX
    MOV BX,OPERAND1
    SUB RESULT,BX
    JMP PRINTSIGN
RESULTSIGN2:
    ;1st operand sign - and 2nd operand sign + but 1st oprand is greater than 2nd operand
    MOV RESULTSIGN,1
    MOV BX,OPERAND1
    MOV RESULT,BX 
    MOV BX,OPERAND2
    SUB RESULT,BX
    JMP PRINTSIGN
;both operands are positive
ADDITION4:
    MOV RESULTSIGN,0
    MOV BX,OPERAND1
    MOV RESULT,BX
    MOV BX,OPERAND2
    ADD RESULT,BX
    JMP PRINTSIGN
MULTIPLICATION:
    MOV AL,SIGN2
    MOV RESULTSIGN,AL
    MOV AL,SIGN1
    XOR RESULTSIGN,AL
    ;ADD RESULTSIGN,48 
    MOV AX,OPERAND1
    MUL OPERAND2
    MOV RESULT,AX
PRINTSIGN: 
    LEA DX, MSGBR1
    MOV AH, 9
    INT 21H
    ;SUB RESULTSIGN,48
    CMP RESULTSIGN,1
    JNE PRINTRESULT
    LEA DX, MINUS
    MOV AH, 9
    INT 21H
PRINTRESULT:
    MOV AX,RESULT
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
    LEA DX, MSGBR2
    MOV AH, 9
    INT 21H
;DOX exit
EXIT:
    MOV AH, 4CH
    INT 21H
MAIN ENDP
    END MAIN
    
     
    
    
           
    
    
     
    


