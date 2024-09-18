; bai toan chia het 4b

inchuoi macro chuoi
    mov ah, 09h
    lea dx, chuoi
    int 21h
inchuoi endm

.model small
.stack 100h
.data
    noti db "------------------Bai toan chia het-------------------------$"
    msg db 10, 13, "So phan tu:  $"
    msg2 db 10, 13, "Nhap cac phan tu trong mang: $"
    msg3 db 10, 13, "Nhap so chia: $"
    xdong db 10, 13, "$"
    msg4 db 10, 13,"Ket qua: $"

    x dw ?
    y dw ?
    base dw 10
    n dw ?
    sochia dw ?
    arr dw ?
.code
main proc
    mov ax, @data
    mov ds, ax

    inchuoi noti
    inchuoi msg
    call nhap_n
    mov n, ax


    inchuoi msg2
    mov cx, 0
nhap_num: 
    inchuoi xdong
    call nhap_n
    push ax
    inc cx
    cmp cx, n
    jne nhap_num

    inchuoi msg3
    call nhap_n
    mov sochia, ax 
    
    inchuoi msg4

    mov si, 0
    mov di, 0
    mov cx, n
dem_so:     
    pop ax 
    xor dx, dx  
    div sochia
    cmp dx, 0
    jne pass
    inc di
pass:   
    loop dem_so

    mov ax, di
    call in_n

    mov ah, 08h
    int 21h
    mov ah, 4Ch
    int 21h

main endp

nhap_n proc
    mov x, 0
    mov y, 0

loop_nhap:
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
    jmp loop_nhap

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