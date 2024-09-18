

inchuoi macro chuoi
    mov ah, 09h
    lea dx, chuoi
    int 21h
inchuoi endm

.model small
.stack 100h
.data
    noti db "---------------------------Dem so nguyen to-------------------------$"
    msg db 10, 13, " Nhap so phan tu: $"
    msg1 db 10, 13, "Nhap cac phan tu: $"
    xdong db 10, 13, "$"
    msg2 db 10, 13, " So cac phan tu la so nguyen to: $"

    n dw ?
    x dw ?
    y dw ?
    base dw 10
    dem dw ?


.code
main proc

    mov ax, @data
    mov ds, ax

    inchuoi noti
    inchuoi msg
    call nhap_n 
    mov n, ax

    ;nhap cac phan tu vao mang 
    inchuoi msg1
    mov di, 0  
    mov cx, n
nhap_arr:
    inchuoi xdong
    call nhap_n
    call check_snt
    mov bx, x
    cmp bx, 1
    jne pass
    inc di
pass: 

    loop nhap_arr

    ; dem so cac so ngto 
done:


dem_xong: 
    mov dem, di

    ; in ket qua
    inchuoi msg2 
    mov ax, dem
    call in_n
     
exit:
    mov ah, 08h
    int 21h

    mov ah, 4Ch
    int 21h

main endp

nhap_n proc
    mov x, 0
    mov y, 0  
    mov si, 0
nhap:
    mov ah, 01h
    int 21h
    cmp al, 13
    je nhap_xong
    cmp al, "-"
    je so_am
    sub al, 30h
    xor ah, ah
    mov y, ax
    mov ax, x
    mul base
    add ax, y
    mov x, ax
    jmp nhap   

so_am:
    mov si, 1
nhap2: 
    mov ah, 01h
    int 21h
    cmp al, 13
    je nhap_xong
    sub al, 30h
    xor ah, ah
    mov y, ax
    mov ax, x
    mul base
    add ax, y
    mov x, ax
    jmp nhap2
       
nhap_xong: 
    mov ax, x
    ret

nhap_n endp


check_snt proc 
    cmp si, 1
    je not_snt
    cmp ax, 1
    jle not_snt
    
    mov y, ax
    mov bx, 2

lap_snt:
    mov ax, y
    xor dx, dx
    div bx
    cmp dx, 0
    je not_snt
    inc bx
    cmp bx, y
    jl lap_snt

end_check:
    mov x, 1
    ret

not_snt:
    mov x, 0
    ret
check_snt endp

in_n proc 
    mov cx, 0

in_stack:
    xor dx, dx
    div base
    push dx
    inc cx
    cmp ax, 0
    je out_stack   
    jmp in_stack

out_stack:
    pop dx
    add dx, 30h
    mov ah, 02h
    int 21h
    loop out_stack
    ret 
in_n endp
end main

