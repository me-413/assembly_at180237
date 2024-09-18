; bai so am so duong - 5b

inchuoi macro chuoi 
    mov ah, 09h
    lea dx, chuoi
    int 21h
inchuoi endm

.model small
.stack 100h
.data 
    noti db "------------------Dem so am, so duong----------------------$"
    msg db 10, 13, "Nhap so n: $"
    msg1 db 10, 13, "Nhap cac phan tu trong mang: $"
    msg2 db 10, 13, "So cac so am: $"
    msg3 db 10, 13, "So cac so duong: $"

    x dw ?
    y dw ?
    base dw 10
    n dw ?
    ;count_am dw ?     ; dung si thay cho bien nay
    ;count_duong dw ?     ; dung di thay cho bien nay
    xdong db 10, 13, "$"

.code
main proc   
    mov ax, @data
    mov ds, ax
    inchuoi noti
    inchuoi msg

    call nhap_n
    mov n, ax

    mov cx, n
    mov si, 0
    mov di, 0

nhap_arr: 
    inchuoi xdong
    call nhap_n
    cmp bx, 1
    je add_am 
    cmp ax, 0
    jg add_duong
    jmp continue

add_am: 
    inc si
    jmp continue

add_duong:
    inc di
    jmp continue

continue:  
    loop nhap_arr

    ; in ket qua
    inchuoi msg3
    mov ax, di
    call in_n

    inchuoi msg2
    mov ax, si
    call in_n

    mov ah, 08h
    int 21h
    mov ah, 4Ch 
    int 21h


main endp

nhap_n proc
    mov x, 0
    mov y, 0 
    mov bx, 0
loop_nhap:
    mov ah, 01h
    int 21h
    cmp al, 13
    je end_nhap 
    cmp al, "-"
    je so_am
    sub al, 30h
    xor ah, ah
    mov y, ax
    mov ax, x
    mul base
    add ax, y
    mov x, ax
    jmp loop_nhap

so_am:
    mov bx,1
    
loop_nhap1:
    mov ah, 01h
    int 21h
    cmp al, 13
    je end_nhap
    sub al, 30h
    xor ah, ah
    mov y, ax
    mov ax, x
    mul base
    add ax, y
    mov x, ax
    jmp loop_nhap1
    
end_nhap:   
    mov ax, x
    ret  
nhap_n endp

in_n proc
    mov cx, 0
in_stack:
    xor dx, dx
    div base
    push dx
    inc cx
    cmp ax, 0
    jne in_stack

out_stack:
    pop dx
    add dx, 30h
    mov ah, 02h
    int 21h
    loop out_stack
    ret

in_n endp
end main
