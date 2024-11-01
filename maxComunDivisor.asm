section .data
    num1 dd 48           ; Primer número
    num2 dd 18           ; Segundo número
    result dd 0          ; Variable para almacenar el resultado

section .text
    global _start

_start:
    ; Cargar los números en registros
    mov eax, [num1]      ; Cargar num1 en EAX
    mov ebx, [num2]      ; Cargar num2 en EBX

mcd_loop:
    cmp ebx, 0           ; Comparar EBX con 0
    je  end_mcd          ; Si EBX es 0, saltar a end_mcd

    xor edx, edx         ; Limpiar EDX antes de la división
    div ebx              ; EAX = EAX / EBX (EAX = num1, EBX = num2)

    mov eax, ebx         ; Mover el divisor (EBX) a EAX
    mov ebx, edx         ; Mover el residuo (EDX) a EBX
    jmp mcd_loop         ; Repetir el ciclo

end_mcd:
    mov [result], eax    ; Almacenar el resultado

    ; Salir del programa
    mov eax, 1           ; syscall: sys_exit
    xor ebx, ebx         ; estado de salida: 0
    int 0x80             ; llamada al sistema
