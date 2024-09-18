inchuoi macro chuoi
    mov ah, 09h
    lea dx, chuoi
    int 21h
inchuoi endm

.model small
.stack 100h
.data
    noti db "---------------------------Xoa tep tin--------------------------$"
    msg db 10, 13, "Nhap ten file can xoa: $"
    success db 10, 13, "Xoa file thanh cong $"
    error db 10, 13, "That bai$" 
    file db 50 dup(?), 0
     thefile dw ?
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
        
 ;tao file txt 
tao_file:
    mov ah,03Ch
    lea dx,file
    mov cx,0h
    int 21h
    
    jc err
    
    mov thefile,ax
    
    mov ah,03Eh
    mov bx,thefile
    int 21h
        
xoa_file:  
    mov byte ptr file[si], 0  
    lea dx, file
    mov ah, 41h              
    int 21h
    jc err          

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
