dseg segment
max db 30
len db 0
chuoi db 30 dup(?)
tbao db 'Hay nhap vao tu ban phim chuoi ky tu... $'
dseg ends

cseg segment
assume cs:cseg, ds:dseg

start:
mov ax, dseg
mov ds, ax

mov ah, 09h
lea dx, tbao
int 21h

mov ah, 0Ah
lea dx, max  ; dia chi bat dau chuoi
int 21h

mov ah, 4Ch
int 21h

cseg ends
end start
