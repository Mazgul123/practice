section .text
global change_to_number
change_to_number:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    mov esi, dword[ebp+8]; *x
    mov bl, 10; делитель
    xor ecx, ecx
    .cycle:  
        ;Завершаем выполнение, когда встречается 0
        cmp byte[esi+ecx], 0
        je .exit

        ;Определяем является ли символ заглавной буквой
        cmp byte[esi+ecx], 'A'
        jl .looper
        cmp byte[esi+ecx], 'Z'
        jg .looper

        ;Получаем порядковое число буквы в алфавите
        mov al, byte[esi+ecx]
        sub al, 'A'
        inc al

        ;Берем остаток от деление на 10 порядкого номера буквы
        xor ah, ah
        div bl
        add ah, '0'

        mov byte[esi+ecx], ah ;Помещаем вместо буквы число N mod 10, N - порядковый номер буквы
        .looper:
            inc ecx; переходим к следующему элементу массива
        jmp .cycle

    .exit:
    pop esi
    pop ebx
    leave
    ret

global invert_str   
invert_str:
    push ebp
    mov ebp, esp
    push ebx

    mov eax, dword[ebp+8]; *x
    xor ecx, ecx; i:=0

    ;Помещаем элементы массива в системный стек
    push dword 0; Помещаем в стек 0, который попадет в конец перевернутого массива
    .in_stack:
        ;когда встречается 0, завершаем добавление элементов массива в стек
        cmp byte[eax+ecx], 0
        je .exit_in_stack

        movzx edx, byte[eax+ecx]; переносим код символа в регистр без уч. знака
        push edx; помещаем в стек код символа
        inc ecx; i++
        jmp .in_stack

    .exit_in_stack:
    xor ebx, ebx; i:=0
    inc ecx; увеличиваем ecx на 1, тк из стека еще необходимо извлечь нулевой элемент
    
    ;Вытаскиваем элементы из стека в массив
    .out_stack:
        pop edx
        ;Во младшей части регистра edx находится код символа
        mov byte[eax+ebx], dl; переносим код символа в массив
        inc ebx; i++
        loop .out_stack

    pop ebx
    leave
    ret
