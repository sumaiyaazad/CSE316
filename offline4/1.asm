.model medium

.stack 100H

.data
    cr equ 0DH
    lf equ 0AH
    space equ 020h
    arr1 db 4 dup(0)
    arr2 db 4 dup(0)
    result db 4 dup<0>
    
    msgresult db cr,lf,' Result: $'
    msg1 db cr,lf,' Array1 values: $'
    msg2 db cr,lf,' Array2 values: $'
    msg0 db cr,lf,' Enter 4 values: $'
    
    MSGBR1 DB '[$'
    MSGBR2 DB ']$' 
    MSG DB CR,LF,' $'
    MINUS DW '-$'
    EQUAL DW '=$'

.CODE
main proc
    mov ax,@data
    mov ds,ax
    lea dx, msg1
    mov ah,09h
    int 21h
;array1 input   
    mov cx,4
    lea si,arr1
    lea bx,result
    lea dx, msg0
    mov ah,9
    int 21h
    valueinput1:
        mov ah,1
        int 21h 
        sub al,48
        mov [si],al
        mov [bx],al
        inc si;
        inc bx;
        loop valueinput1 
    lea dx, msg2
    mov ah,9
    int 21h
;array2 input   
    mov cx,4
    lea si,arr2
    lea dx, msg0
    mov ah,9
    int 21h
    valueinput2:
        mov ah,1
        int 21h 
        sub al,48
        mov [si],al
        inc si;
        loop valueinput2
;result calculate
    xor ax,ax
    lea si,result
    lea bx,arr2
    mov cx,4
addop:
    mov al,[bx] 
    add [si],al
    inc si;
    inc bx;
    loop addop 
;print result
    mov cx,2
    xor dx,dx
    lea dx, msg
    mov ah,9
    int 21h 
    lea si,result
printresult1st:
    mov ax,[si]
    mov dl,10
    xor ah,ah
    div dl
    mov bl,ah
    ;compare quotient with 0
    cmp al,0
    je remainderprint1
    add al,48 
    mov ah, 2
    mov dl,al 
    int 21h
    remainderprint1:
    add bl,48
    mov ah, 2
    mov dl,bl 
    int 21h 
    inc si
    mov dl,020h
    mov ah,2
    int 21h
    loop printresult1st
    ;for matrix print
    mov cx,2
    lea dx, msg
    mov ah,9
    int 21h
printresult2nd:
    mov ax,[si]
    mov dl,10
    xor ah,ah
    div dl
    mov bl,ah
    ;compare quotient with 0
    cmp al,0
    je remainderprint2
    add al,48 
    mov ah, 2
    mov dl,al 
    int 21h
    remainderprint2:
    add bl,48
    mov ah, 2
    mov dl,bl 
    int 21h 
    inc si
    mov dl,020h
    mov ah,2
    int 21h
    loop printresult2nd     
    main endp
end main