inchuoi macro chuoi
    mov ah, 09h
    lea dx, chuoi
    int 21h
inchuoi endm

.model small
.stack 100h
.data
    noti db "---------------------------Thay doi tep tin--------------------------$"

    success db 10, 13, "Thay doi file thanh cong $"
    error db 10, 13, "That bai$" 
    oldfile db "D:\old.txt",0
    newfile db "D:\new.txt",0   
    thefile dw ?    
    
.code
main proc
    mov ax, @data
    mov ds, ax  
    mov es, ax

    inchuoi noti
    
;tao file txt 
tao_file:
    mov ah,03Ch
    lea dx,oldfile
    mov cx,0h
    int 21h
    
    jc err
    
    mov thefile,ax
    
    mov ah,03Eh
    mov bx,thefile
    int 21h

      
        
change_file:
    mov ah, 56h
    lea dx, oldfile
    lea di, newfile
    int 21h
    
    jc err
    
    inchuoi success
    jmp exit
    
err: inchuoi error

exit:
    mov ah, 08h
    int 21h
    mov ah, 4Ch
    int 21h

main endp
end main
