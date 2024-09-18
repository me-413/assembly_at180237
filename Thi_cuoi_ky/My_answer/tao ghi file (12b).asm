inchuoi macro chuoi
    mov ah, 09h
    lea dx, chuoi
    int 21h
inchuoi endm

.model small
.stack 100h
.data
    noti db "---------------------------Tao va ghi tep tin--------------------------$"
    msg db 10, 13, "Nhap ten file: $"
    msg1 db 10, 13, "Nhap noi dung file: $"
    success db 10, 13, "Tao file thanh cong $"
    success1 db 10, 13, "Ghi file thanh cong $"
    error db 10, 13, "That bai"

    file db 50 dup(?)
    file_handle dw ?
    buffer db 50 dup(?)
    bytes_written dw ?

.code
main proc
    mov ax, @data
    mov ds, ax

    inchuoi noti
    inchuoi msg
    
    mov si, 0           
    mov file[si], 'c'  
    inc si
    mov file[si], ':'   
    inc si
    mov file[si], '\' 
    inc si

nhap_filename:
    mov ah, 01h
    int 21h
    cmp al, 13
    je tao_file
    mov file[si], al
    inc si
    jmp nhap_filename

tao_file: 
    mov ah, 3Ch
    lea dx, file
    mov cx, 0
    int 21h
    jc err
    mov file_handle, ax
    inchuoi success


    inchuoi msg1
    mov si, 0
nhap_content:
    mov ah, 01h
    int 21h
    cmp al, 13
    je ghi_file
    mov buffer[si], al
    inc si
    jmp nhap_content

ghi_file:   
    mov ah, 40h
    mov cx, si
    lea dx, buffer
    mov bx, file_handle
    int 21h
    
    jc err
    inchuoi success1
    mov bytes_written, ax


    ; dong file
    mov ah, 3Eh
    mov bx, file_handle
    int 21h
    jmp exit

err:
    inchuoi error

exit: 
    mov ah, 08h
    int 21h
    mov ah, 4Ch
    int 21h
    

main endp 
end main

