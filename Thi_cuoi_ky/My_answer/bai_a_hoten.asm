
; bai a nhap hoten

inchuoi macro chuoi
    mov ah, 09h
    lea dx, chuoi
    int 21h 
inchuoi endm

.model small
.stack 100h
.data
    noti db "--------------------Nhap ho ten, hien thi ma sinh vien:-------------$"
    msg db 10, 13, "Nhap ho ten:$"

    err db 10, 13, "Hay nhap lai ho ten: $"
    msg1 db 10, 13, "Ma sinh vien: AT180237$" 
    
    hoten db 50 dup(?)
    hoten1 db "PHAM HONG NGAT"
    hoten2 db "Pham Hong Ngat"
    hoten3 db "pham hong ngat"

.code
main proc
    mov ax, @data
    mov ds, ax

    inchuoi noti
    inchuoi msg

nhap_lai:
    mov si, 0
nhap:   
    mov ah, 01h
    int 21h
    cmp al, 13
    je nhap_xong
    mov hoten[si], al
    inc si
    jmp nhap
 
nhap_xong: 
    mov di, 0
 check1:  
    mov al, hoten[di]
    mov bl, hoten1[di]
    cmp al, bl
    jne check2
    inc di
    cmp di, si
    je in_masv
    jmp check1

check2: 
    mov al, hoten[di]

    mov bl, hoten2[di]
    cmp al, bl
    jne check3
    inc di
    cmp di, si
    je in_masv
    jmp check2

check3:
    mov al, hoten[di]   

    mov bl, hoten3[di]
    cmp al, bl
    jne error
    inc di
    cmp di, si
    je in_masv
    jmp check3

in_masv:     
    inchuoi msg1  
    jmp exit

error:
    inchuoi err
    jmp nhap_lai  
    
   
exit:
    mov ah, 08h
    int 21h
    mov ah, 4Ch
    int 21h
    
main endp
end main


