.model medium

.stack 100H

.data
    cr equ 0DH
    lf equ 0AH
    space equ 020h
    storebx dw 0
    storedx dw 0
    
    msginput db cr,lf,' Input(n(1-25)): $'
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
    mov cx,bx
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
    mov dl,48
    mov ah, 2
    int 21h
    cmp cx,2
    jl exit
    dec cx
    mov dx,0
    mov bx,1
    call fibonacci 
exit: 
    mov ah,4ch
    int 21h
    main endp
fibonacci proc
        mov storebx,bx
        mov storedx,dx 
        mov dl,44
        mov ah,2
        int 21h
        mov ax,bx
        
        xor dx,dx
        mov bx,10000
        div bx
        ;save the remainder in bl
        mov bx,dx
        ;compare quotient with 0
        ;cmp ax,0
        add al,48 
        mov ah, 2
        mov dl,al 
        int 21h
        ;remainderop0:
        mov ah,0 
        mov ax,bx
        xor dx,dx
        mov bx,1000
        div bx
        ;save the remainder in bl
        mov bx,dx
        ;compare quotient with 0
        ;cmp ax,0
        ;je remainderop1
        add al,48 
        mov ah, 2
        mov dl,al 
        int 21h
        ;remainderop1:
        mov ah,0 
        mov ax,bx
        mov dl,100
        div dl
        mov bl,ah
        ;compare quotient with 0
        ;cmp al,0
        ;je remainderprint2
        add al,48 
        mov ah, 2
        mov dl,al 
        int 21h
        ;remainderprint2:
        mov ah,0 
        mov al,bl
        mov dl,10
        div dl
        mov bl,ah
        ;compare quotient with 0
        ;cmp al,0
        ;je remainderprint3
        add al,48 
        mov ah, 2
        mov dl,al 
        int 21h
        ;remainderprint3:
        add bl,48
        mov ah, 2
        mov dl,bl 
        int 21h 
        dec cx
        cmp cx,0
        je exit 
        mov bx,storebx
        mov dx,storedx
        add bx,dx
        mov dx,storebx
        call fibonacci
    ret 2
end main