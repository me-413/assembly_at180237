inchuoi macro chuoi
    mov ah, 09h
    lea dx, chuoi
    int 21h
inchuoi endm

.model small
.stack 100h
.data  
    noti db "-----------------------Chuyen thuong thanh HOA-------------------------------$"
    msg db 10, 13,"Nhap chuoi: $"
    msg1 db 10, 13, "Chuoi sau chuyen doi: $"

    string db 50 dup(?)

.code 
main proc
    mov ax, @data
    mov ds, ax

    inchuoi noti
    inchuoi msg

    mov si, 0
nhap:
    mov ah, 01h
    int 21h
    cmp al, 13
    je end_nhap
    cmp al, 'A'
    jl not_convert
    cmp al, 'Z'
    jg not_convert
    add al, 20h

not_convert:    
    mov string[si], al  
    inc si
    jmp nhap

end_nhap:
    mov cx, si

    inchuoi msg1
    mov si,0
xuat:   
    mov dl, string[si]
    mov ah, 02h
    int 21h
    inc si
    loop xuat
    
    mov ah, 08h
    int 21h
    mov ah, 4Ch
    int 21h

main endp
end main