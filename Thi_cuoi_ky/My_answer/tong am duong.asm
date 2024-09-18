;bai 2b _ tinh tong mang nhap vao
; nho xoa di

inchuoi macro chuoi
    mov ah, 09h
    lea dx, chuoi
    int 21h
inchuoi endm   

.model small
.stack 100h
.data
    noti db "--------------------TINH TONG MANG NHAP VAO---------------------------$"
    msg db 10, 13, "Nhap vao so phan tu: $"
    msg1 db 10, 13, "Nhap gia tri cua cac phan tu: $"     
    msg2 db 10, 13, "Ket qua: $"
    xdong db 10, 13, "$"
    ;arr dw 50 dup(?)  dung cho nhap vao mot chuoi ??
    result dw ?
    
    x dw ?
    y dw ?
    base dw 10 
    arr dw ? 
    dau dw ?
    n dw ?  
    tong_am dw 0
    tong_duong dw 0
       
.code 
main proc
    mov ax, @data
    mov ds, ax
    
    inchuoi noti
    inchuoi msg
    
    call nhap_n
    mov n, ax
    
    inchuoi msg1 
    mov cx, n
nhap_arr:
    inchuoi xdong
    call nhap_n 
    cmp bx, 1
    jne tong_d
    je tong_a
continue:
    inc si
    loop nhap_arr 
    jmp tinh_tong

tong_d:
    add ax, tong_duong
    mov tong_duong, ax
    jmp continue

tong_a: 
    add ax, tong_am
    mov tong_am, ax
    jmp continue
    
     
tinh_tong:
    mov ax, tong_duong
    mov bx, tong_am
    cmp ax, bx
    jge result1
    sub bx, ax
    mov result, bx 
    inchuoi msg2
    mov ah, 02h
    mov dl, "-"
    int 21h
    mov ax, result
    call in_n
    jmp exit
    
result1:  
    sub ax, bx
    mov result, ax
    inchuoi msg2 
    mov ax, result
    call in_n  
   
exit: 
    mov ah, 08h
    int 21h
    mov ah, 4Ch
    int 21h
    
main endp
    
    
nhap_n proc
    mov x, 0
    mov y, 0
    mov bx, 0
nhap_dec:
    mov ah, 01h
    int 21h
    cmp al, 13
    je nhap_xong 
    cmp al, "-"
    je so_am
    sub al, 30h
    xor ah, ah
    mov y, ax
    mov ax, x
    mul base
    add ax, y
    mov x, ax
    jmp nhap_dec


so_am:  
    mov bx, 1   
nhap_dec1:
    mov ah, 01h
    int 21h
    cmp al, 13
    je nhap_xong 
    sub al, 30h
    xor ah, ah
    mov y, ax
    mov ax, x
    mul base
    add ax, y
    mov x, ax
    jmp nhap_dec1
    
nhap_xong:
    mov ax, x
    ret 
nhap_n endp    



in_n proc 
    mov ax, result
    mov cx, 0
    
in_stack:
    xor dx, dx
    div base
    push dx
    inc cx
    cmp ax, 0
    je out_stack
    jmp in_stack
    
out_stack:
    pop dx      ; sai o loi nay hoi nhieu nha; chu y
    add dx, 30h  
    mov ah, 02h
    int 21h
    loop out_stack
    ret

in_n endp   

end main 