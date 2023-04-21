section .text
global change_to_number
change_to_number:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    mov esi, dword[ebp+8]; *x
    mov ecx, dword[ebp+12]; i:=N
    mov bl, 10; делитель
    .cycle:  
        ;Определяем является ли символ заглавной буквой
        cmp byte[esi+ecx-1], 'A'
        jl .looper
        cmp byte[esi+ecx-1], 'Z'
        jg .looper

        ;Получаем порядковое число буквы в алфавите
        mov al, byte[esi+ecx-1]
        sub al, 'A'
        inc al

        ;Берем остаток от деление на 10 порядкого номера буквы
        xor ah, ah
        div bl
        add ah, '0'

        mov byte[esi+ecx-1], ah ;Помещаем вместо буквы N mod 10, N - порядковый номер буквы
        .looper:
            loop .cycle; --i
    
    pop esi
    pop ebx
    leave
    ret

global invert_str   
invert_str:
    push ebp
    mov ebp, esp

    mov eax, dword[ebp+8]; *x
    mov ecx, dword[ebp+12]; i:=N
    ;Помещаем элементы массива в системный стек
    .in_stack:
        movzx edx, byte[eax+ecx-1]; переносим код символа в регистр без уч. знака
        push edx; помещаем в стек
        loop .in_stack; --i

    mov ecx, dword[ebp+12]; i:=N

    ;Вытаскиваем элементы из стека в массив
    .out_stack:
        pop edx; извлекаем из стека
        ;Во младшей части регистра edx находится код символа
        mov byte[eax+ecx-1], dl; переносим код символа в массив
        loop .out_stack; --i
    leave
    ret
