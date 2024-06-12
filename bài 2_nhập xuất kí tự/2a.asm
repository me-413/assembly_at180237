cseg segment
assume cs:cseg

start:
mov ah, 02h  ; ham 2, in 1 ky tu ra man hinh
mov dl, 'B'  ; dl chua ky tu B
int 21h
mov ah, 08h  ; ham 8, ngat 21h (?) de lam j
int 21h
mov ah, 4Ch
int 21h
cseg ends
end start


; sua chuong trinh de in ra ky tu D thi thay D vao B
; in so 9 thi co the la thay dx thanhf dl
; in so 89 thif phai dung ham 9
; cu phap
; mov ah, 09h
; mov dx, '89'
; int 21h
