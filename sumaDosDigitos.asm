.model small
.stack
.data
num1 db 0
num2 db 0
num3 db 0

mensaje db 10,13,7, "Primer numero: ", "$"
mensaje2 db 10,13,7, "Segundo numero: ", "$"
mensaje3 db 10,13,7, "La suma es: ", "$"

.code
main proc
mov ax, SEG @data
mov ds,ax

mov ah,09h
lea dx,mensaje
int 21h

mov ah,01h
int 21h
sub al,30h
mov num1,al

mov ah,09h
lea dx,mensaje2
int 21h

mov ah,01h
int 21h
sub al,30h
mov num2,al

mov al,num1
add al,num2
add al,30h
mov num3,al

mov ah,09
lea dx,mensaje3
int 21h
mov ah,02
mov dl,num3
int 21h

main endp

end main