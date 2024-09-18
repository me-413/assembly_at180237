; bai a
inchuoi macro chuoi
    mov ah, 09h
    lea dx, chuoi
    int 21h
inchuoi endm

.model small
.stack 100h
.data 
    noti db "Ma sinh vien: $"
    msg db 10, 13,  "Ho va ten: PHAM HONG NGAT $"
    err db 10, 13, "Nhap lai: $"
    xdong db 10, 13, "$"
    msv1 db "AT180237"
    msv2 db "at180237"

    msv db 50 dup(?)

.code 
main proc 
    mov ax, @data
    mov ds, ax
    
    inchuoi noti

nhap_lai:
    mov si, 0
    nhap_msv:
    mov ah, 01h
    int 21h
    cmp al, 0Dh
    je nhap_xong
    mov msv[si], al
    inc si
    jmp nhap_msv

    nhap_xong:
    cmp si, 8
    je check
    jmp error

    check:
    mov di, 0
    lap_check:
    mov al, msv[di]
    mov bl, msv1[di]
    cmp al, bl
    jne check2
    inc di
    cmp di, 8
    je xuat
    jmp lap_check

    lap_check2:
    mov al, msv[di]
    check2:
    mov cl, msv2[di]
    cmp al, cl
    jne error
    inc di
    cmp di, 8
    je xuat
    jmp lap_check2

    xuat:
    inchuoi msg
    jmp exit 

    error:
    inchuoi err 
    inchuoi xdong
    jmp nhap_lai   
    
    
    exit:
    mov ah, 08h
    int 21h
    
    mov ah, 4Ch  
    int 21h


main endp
end main