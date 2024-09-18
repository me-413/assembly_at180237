inchuoi macro chuoi
    mov ah, 09h
    lea dx, chuoi
    int 21h
inchuoi endm

.model small
.stack 100h
.data
    noti db "--------------Dao nguoc chuoi ky tu---------------$"
    msg db 10, 13, "Nhap chuoi ky tu: $"
    msg1 db 10, 13, "Chuoi ky tu da duoc dao la:  $"
    
.code
main proc
    mov ax, @data
    mov ds, ax
    
    inchuoi noti
    inchuoi msg
    
    mov cx, 0
loop_nhap:
    mov ah, 01h
    int 21h
    cmp al, 13
    je nhap_xong
    xor ah, ah
    push ax
    inc cx
    jmp loop_nhap
    
 nhap_xong: 
    inchuoi msg1
  
loop_xuat:
    pop dx
    mov ah, 02h
    int 21h
    loop loop_xuat
    
    mov ah, 08h
    int 21h
    mov ah, 4Ch
    int 21h
    
main endp
end main