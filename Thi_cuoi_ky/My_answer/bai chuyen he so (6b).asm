; bai 6 chuyen he 10 -> 16 va 2

inchuoi macro chuoi
    mov ah, 09h
    lea dx, chuoi
    int 21h
inchuoi endm

.model small
.stack 100h
.data
    noti db "-----------------------Chuyen doi he so-----------------------$"
    msg db 10, 13, "Hay nhap so can chuyen doi he so: $"
    msg1 db 10, 13, "He 16: $"
    msg2 db 10, 13, "He 2: $"

    x dw ?
    y dw ?
    base dw 10 
    num dw ?

.code
main proc
    mov ax, @data
    mov ds, ax

    inchuoi noti
    inchuoi msg

    call nhap_n
    cmp bx, 1
    je tinh_bu_2
    mov num, ax
    jmp hien_thi

tinh_bu_2: 
    mov bx, 65535
    xor ax, bx
    add ax, 1
    mov num, ax
    jmp hien_thi

hien_thi:
    inchuoi msg1
    mov bx,num
    call hec_out   
    mov dl, "h"
    mov ah, 02h
    int 21h     
    
    inchuoi msg2 
    mov bx, num
    call bin_out

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
    je nhap_so_am
    sub al, 30h
    xor ah, ah
    mov y, ax
    mov ax, x
    mul base
    add ax, y
    mov x, ax
    jmp loop_nhap

nhap_so_am:
    mov bx, 1
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

hec_out proc
    mov cx, 4
loop_hec:  
    push cx
    mov cl, 4
    mov dl, bh
    shr dl, cl  
    cmp dl, 9
    jg kytu
    add dl, 30h 
    jmp print

kytu: 
    add dl, 37h
    
print: 
    mov ah, 02h
    int 21h
    shl bx, cl
    pop cx
    loop loop_hec
    ret

hec_out endp


bin_out proc
    mov cx, 16
loop_bin:  
    xor dx, dx
    shl bx, 1
    rcl dx, 1
    add dl, 30h
    mov ah, 02h
    int 21h
    loop loop_bin
    ret
bin_out endp
end main