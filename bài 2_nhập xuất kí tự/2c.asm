dseg segment
tbao db 'Hay nhap vao mot ky tu bat ky ... $' ; dau $ de thong bao cho assembler het chuoi
dseg ends

; bien tbao duoc khai bao voi cu phap <ten_bien> <kieu_du_lieu> <gia_tri>
; kieu_du_lieu co 2 kieu db la byte ; dw la word; word to hon byte thoi chu ko co j

cseg segment
assume cs:cseg, ds:dseg ; cseg la doan lenh, dseg la doan du lieu

; dong assume .. -> thong bao cho assembler thanh ghi cs tro den cseg, ds tro den dseg -> thiet lap ngu canh

start:
mov ax, dseg  ; khoi dong dia chi doan du lieu
mov ds, ax

mov ah, 09h   ; ham 9, in ra mot chuoi ky tu
lea dx, tbao  ; dx <- dia chi offset cua bien tbao   (?) bat buoc phai la dx khong
int 21h        ; goi ngat de thuc hien ham

mov ah, 01h  ; ham 1, cho user an phim bat ky
int 21h   
; ki tu nhap vao duoc luu trong al

mov ah, 4Ch  ; tro ve he dieu hanh
int 21h

cseg ends
end start
