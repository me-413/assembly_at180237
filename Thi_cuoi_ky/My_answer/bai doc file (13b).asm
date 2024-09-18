inchuoi macro chuoi
    mov ah, 09h
    lea dx, chuoi
    int 21h
inchuoi endm

.model small
.stack 100h
.data
    noti db "---------------------------Doc tep tin--------------------------$"
    msg db 10, 13, "Nhap ten file can doc: $"
    msg1 db 10, 13, "Noi dung file: $"
    success db 10, 13, "Doc file thanh cong $"
    error db 10, 13, "That bai$" 

    file db 50 dup(?)
    file_handle dw ?
    buffer db 50 dup(?), "$"

.code
main proc
    mov ax, @data
    mov ds, ax

    inchuoi noti
    inchuoi msg

    mov si, 0
    mov file[si], 'd'
    inc si    
    mov file[si], ':'
    inc si
    mov file[si], '\'
    inc si
nhap_filename:
    mov ah, 01h
    int 21h
    cmp al, 13
    je mo_file
    mov file[si], al
    inc si
    jmp nhap_filename
    
mo_file:
    mov ah, 3Dh
    mov al, 0
    lea dx, file
    int 21h
    jc err 
    mov file_handle, ax


doc_file:   
    mov ah, 3Fh
    mov cx, 100
    lea dx, buffer
    mov bx, file_handle
    int 21h
    
    jc err

;dong file
    mov ah, 3Eh
    mov bx, file_handle
    int 21h 
   
   
    inchuoi success    
    inchuoi msg1
    inchuoi buffer   
    
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

