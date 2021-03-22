.model medium

.stack 100H

.data
    cr equ 0DH
    lf equ 0AH
    space equ 020h
    arr db 2 dup(0)
    result dw 100 dup<0>
    
    msginput db cr,lf,' Input(n): $'
    msgconfirm db cr,lf,' Your Input: $'
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
    lea dx, msginput
    mov ah,9
    int 21h
    ;1st digit input
    mov ah,1
    int 21h 
    sub al,48
    mov cl,10
    mul cl
    mov bx,ax
    ;2nd digit input
    mov ah,1
    int 21h 
    sub al,48
    mov cl,1
    mul cl
    add bx,ax
    ;store input number in cx 
    mov cl,bl
    lea dx, msgconfirm
    mov ah,9
    int 21h
;print input number
    mov ax,cx
    mov dl,10
    xor ah,ah
    div dl
    mov bl,ah
    ;compare quotient with 0
    cmp al,0
    je remainderprint
    add al,48 
    mov ah, 2
    mov dl,al 
    int 21h 
    remainderprint:
    add bl,48
    mov ah, 2
    mov dl,bl 
    int 21h
    lea dx, msg
    mov ah,9
    int 21h
    ;//changed dh to dx and bh to bx 
    mov dh,0
    mov bh,1
    lea si,result
    ;//changed dh to dx
    mov [si],dh
    cmp cl,2
    jl print
    mov al,cl
    sub al,1
    call fibonacci 
print:
    lea si,result
    ;//changed dl to dx
    mov dl,[si]
    add dl,48
    mov ah,2
    int 21h
    mov ch,0
    dec cl
    loop1:
        mov dl,44
        mov ah,2
        int 21h
        inc si
        mov ax,[si]
        mov dl,100
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
        mov ah,0 
        mov al,bl
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
        loop loop1
exit: 
    mov ah,4ch
    int 21h
    main endp
fibonacci proc
    inc si 
    ;//changed all h to x
    mov [si],bh 
    mov ah,bh
    add bh,dh
    mov dh,ah
    dec al
    cmp al,0
    je print
    call fibonacci
    ret 2
end main