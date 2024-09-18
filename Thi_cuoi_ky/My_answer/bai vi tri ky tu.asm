inchuoi macro chuoi
    mov ah, 09h
    lea dx, chuoi
    int 21h
inchuoi endm

.model small
.stack 100h
.data
    noti db "-------------Tim ky tu trong chuoi---------------$"
    msg db 10, 13, "Nhap chuoi ky tu: $"
    kytu db 10, 13, "Ky tu can tim :  $"   
    err db 10, 13, "Not found!!!$"   
    result db 10, 13, "So ky tu tim thay trong chuoi: $"
    result1 db 10, 13, "Vi tri cac ky tu tim duoc la: $" 
    xdong db 10, 13, "$"
    sign db ?
    n dw ?  ; so phtu
    str db ?
    vitri dw 50 dup(?)
    base dw 10 
    count dw ?
.code
main proc
    mov ax, @data
    mov ds, ax
    
    inchuoi noti
    inchuoi msg
    
    mov si, 0
nhap_chuoi: 
    mov ah, 01h
    int 21h
    cmp al, 13
    je nhap_xong
    mov str[si], al
    inc si 
    jmp nhap_chuoi
    
    
 nhap_xong: 

    mov n , si
    inchuoi kytu
    mov ah, 01h
    int 21h
    mov sign, al 
    

    mov si, 0
    mov di, 0
loop_xuat:
    mov al, str[si] 
    cmp al, sign
    jne pass  
    mov bx, si
    add bx, 1
    mov vitri[di], bx
    inc di
    
pass:   
    inc si
    cmp si , n
    jne loop_xuat
    
    
    ; ket qua
    mov count, di
    cmp di, 0
    je not_found 
    
    inchuoi  result
    mov ax, count
    call in_n
    
    inchuoi result1 
    mov di, 0
in_vitri:   
    inchuoi xdong
    mov ax, vitri[di]  
    xor ah, ah
    call in_n
    inc di
    cmp di, count
    jne in_vitri
    jmp exit
     
not_found:
    inchuoi err
    
exit:  
    mov ah, 08h
    int 21h
    mov ah, 4Ch
    int 21h
    
main endp    

in_n proc
    mov cx, 0
    
in_stack:
    xor dx, dx
    div base
    push dx
    inc cx
    cmp ax, 0
    jne in_stack

out_stack:
    pop dx
    add dl, 30h
    mov ah, 02h
    int 21h
    loop out_stack
    ret
end main