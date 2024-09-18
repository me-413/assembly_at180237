; bai 2b 

inchuoi macro chuoi
    mov ah, 09h
    lea dx, chuoi
    int 21h
inchuoi endm

.model small
.stack 100h
.data
    noti db "CHUONG TRINH TINH GIAI THUA CUA N $"
    msg1 db 10,13, "Nhap vao n (0-8): $"
    msg2 db 10, 13, "Giai thua cua n la: $"
    loading db 10, 13, "Loading ... $"       
    nhaplai db 10, 13, "Hay nhap lai n (0-8): $"

    result dw ?
    x dw ?
    y dw ?
    base dw 10
    n dw ?

.code 
main proc 
    mov ax, @data
    mov ds, ax

    inchuoi noti
    inchuoi msg1  

nhap_lai:

    call nhap_n
    mov n, ax

    inchuoi loading 
    xor ax, ax
    mov ax, n
    cmp ax, 8
    jna continue 
    inchuoi nhaplai
    jmp nhap_lai
     
continue:

    call fact_n
    mov result, ax

    inchuoi msg2
    call in_n

    mov ah, 08h
    int 21h
    mov ah, 4Ch
    int 21h

main endp

nhap_n proc
    mov x, 0
    ;mov y, 0

nhap_dec:
    mov ah, 01h
    int 21h
    cmp al, 13
    je nhap_xong  
    
    sub al, 30h        ; dua ve gia tri so
    xor ah, ah
    mov y, ax
    mov ax, x
    mul base
    add ax, y
    mov x, ax
    jmp nhap_dec

nhap_xong:
    mov ax, x
    ret

nhap_n endp

    
fact_n proc
    mov ax, n
    cmp ax, 0
    je fact_01
    cmp ax, 1
    je fact_01  
    
    sub ax, 1
    mov cx, ax 
    mov ax, n 

fact_loop:
    mul cx
    loop fact_loop
    ret 

fact_01:
    mov ax, 1
    ret

fact_n endp 

in_n proc
    mov ax, result
    mov cx, 0

in_stack: 
    xor dx, dx
    div base
    push dx
    inc cx
    cmp ax, 0
    je out_stack
    jne in_stack

out_stack:
    pop dx
    add dl, 30h
    mov ah, 02h
    int 21h
    loop out_stack
    ret

in_n endp
      
      
end main