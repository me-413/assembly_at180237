inchuoi macro chuoi 
    mov ah, 09h
    lea dx, chuoi   
    int 21h
    
inchuoi endm

.model small
.stack 100h
.data
    noti db "--------------------So sanh chuoi--------------------$"
    msg db 10, 13, "   Nhap chuoi 1: $"
    msg1 db 10, 13, "   Nhap chuoi 2: $"
    success db 10, 13, "Hai chuoi giong nhau$"
    error db 10, 13, "Hai chuoi khac nhau$"
    
    str1 db 50 dup(?)
    str2 db 50 dup(?)
     
    
    
.code 
main proc
    
    mov ax, @data
    mov ds, ax
    
    inchuoi noti
    inchuoi msg
    
    mov si, 0
nhap_1:
    mov ah, 01h
    int 21h
    cmp al, 13
    je nhap_xong1
    mov str1[si], al
    inc si
    jmp nhap_1
    
 
 
 nhap_xong1:
     inchuoi msg1
    mov di, 0  
  
nhap_2: 
    mov ah, 01h  
    int 21h
    cmp al, 13
    je nhap_xong2
    mov str2[di], al
    inc di
    jmp nhap_2
    
nhap_xong2: 
    
    cmp si, di
    jne err
    
    mov si, 0
loop_check:
    mov al, str1[si]
    mov bl, str2[si]
    
    cmp al, bl
    jne err
    inc si 
    cmp si,di
    jne loop_check
    
    inchuoi success
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


    
    