IDEAL
MODEL small
STACK 256

; ==================================== Макроси ====================================
; ---------------------------------------------------------------------------------
; Призначення: ініціалізація програми
; ---------------------------------------------------------------------------------
MACRO M_init		; Макрос для ініціалізації. Його початок
	mov ax, @data	; @data ідентифікатор, що створюються директивою MODEL
	mov ds, ax		; Завантаження початку сегменту даних в регістр DS
	mov es, ax		; Завантаження початку сегменту даних в регістр ES
	ENDM M_init		; Кінець макросу

; ---------------------------------------------------------------------------------
; Призначення: вихід із програми (із кодом 0)
; ---------------------------------------------------------------------------------
MACRO M_exit
	mov ah, 4ch
	mov al, 0
	int 21h
	ENDM M_exit

; ---------------------------------------------------------------------------------
; Призначення: вихід із програми (із кодом FF)
; ---------------------------------------------------------------------------------
MACRO M_error_exit
	mov ah, 4ch
	mov al, 0FFh
	int 21h
	ENDM M_error_exit

; ---------------------------------------------------------------------------------
; Призначення: сокращение количества кода в парсере
; ---------------------------------------------------------------------------------
MACRO M_4x4p_len_check
	mov dh, [si-1]
	cmp dh, 15d
	jne parse_4x4_error
	ENDM M_4x4p_len_check

; ---------------------------------------------------------------------------------
; Призначення: перевод строки
; ---------------------------------------------------------------------------------
MACRO M_crlf
	push ax
	push dx

	mov ah, 09h
	mov dx, offset crlf
	int 21h

	pop dx
	pop ax
	ENDM M_crlf

; ---------------------------------------------------------------------------------
; Призначення: сокращение количества кода
; DX <- сообщение для вывода
; ---------------------------------------------------------------------------------
MACRO M_print
	push ax
	mov ah, 09h
	int 21h
	pop ax
	ENDM M_print

; ---------------------------------------------------------------------------------
; Призначення: простая очистка экрана
; ---------------------------------------------------------------------------------
MACRO M_clearscreen
	push ax
	mov al, 2
	mov ah, 0
	int 10h
	pop ax
	ENDM M_clearscreen

; ---------------------------------------------------------------------------------
; Призначення: запам'ятовування значень регістрів
; ---------------------------------------------------------------------------------
MACRO M_push_all
	push ax
	push bx
	push cx
	push dx
	push bp
	push si
	push di
	ENDM M_push_all

; ---------------------------------------------------------------------------------
; Призначення: повернення значень регістрів
; ---------------------------------------------------------------------------------
MACRO M_pop_all
	pop di
	pop si
	pop bp
	pop dx
	pop cx
	pop bx
	pop ax
	ENDM M_pop_all

DATASEG
welcome_screen db "Man I love working with arrays", 10, 13
			   db "Type your values and I'll work with them for you", 10, 13
			   db "=====================", 10, 13
			   db "Choose what you want to do with future array", 10, 13
			   db "1 - Calculate sum of all array elements", 10, 13
			   db "2 - Find biggest value of array", 10, 13
			   db "3 - Find smallest value of array", 10, 13
			   db "4 - Sort your array", 10, 13
			   db "5 - Find coordinates of elemnt in 2d array", 10, 13
			   db "=====================", 10, 13
			   db "All values have to be itegers and vary from 0 to 255", 10, 13
			   db "1d arrays cannot be longer than 100 characters", 10, 13
			   db "2d arrays will be 4x4 elements long", 10, 13, "$"

opt1_msg db "You chose calculating sum of all elements. Good choise", 10, 13
		 db "All values have to be itegers and vary from 0 to 255", 10, 13
		 db "Expected input: 001,027,100,147 etc.", 10, 13
		 db 10, 13
		 db "Your input:", 10, 13, "$"

opt2_msg db "You chose search for biggest value in the array. Good choise", 10, 13
		 db "All values have to be itegers and vary from 0 to 255", 10, 13
		 db "Expected input: 001,027,100,147 etc.", 10, 13
		 db 10, 13
		 db "Your input:", 10, 13, "$"

opt3_msg db "You chose search for smallest value in the array. Good choise", 10, 13
		 db "All values have to be itegers and vary from 0 to 255", 10, 13
		 db "Expected input: 001,027,100,147 etc.", 10, 13
		 db 10, 13
		 db "Your input:", 10, 13, "$"

opt4_msg db "You chose sorting of the array (using selection sort btw). Good choise", 10, 13
		 db "All values have to be itegers and vary from 0 to 255", 10, 13
		 db "Expected input: 001,027,100,147 etc.", 10, 13
		 db 10, 13
		 db "Your input:", 10, 13, "$"

opt5_msg db "You chose seach for coordinates of the element in 2d array. Good choise", 10, 13
		 db "Write down 16 values in console 1 by 1", 10, 13
		 db "All values have to be itegers and vary from 0 to 255", 10, 13
		 db "Expected input: 001,027,100,147 etc.", 10, 13
		 db 10, 13
		 db "Your input:", 10, 13, "$"
opt5_row0_msg db "Row 0: ", "$"
opt5_row1_msg db "Row 1: ", "$"
opt5_row2_msg db "Row 2: ", "$"
opt5_row3_msg db "Row 3: ", "$"
opt5_lost_num db "Number to find: ", "$"

inp_arr db 101, 0
		db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
		db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
		db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
		db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
		db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
		db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
		db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
		db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
		db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
		db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

inp_arr0to3 db 16, 0
			db 0, 0, 0, 0
			db 0, 0, 0, 0
			db 0, 0, 0, 0
			db 0, 0, 0, 0

inp_arr4to7 db 16, 0
			 db 0, 0, 0, 0
			 db 0, 0, 0, 0
			 db 0, 0, 0, 0
			 db 0, 0, 0, 0

inp_arr8to11 db 16, 0
			 db 0, 0, 0, 0
			 db 0, 0, 0, 0
			 db 0, 0, 0, 0
			 db 0, 0, 0, 0

inp_arr12to15 db 16, 0
			  db 0, 0, 0, 0
			  db 0, 0, 0, 0
			  db 0, 0, 0, 0
			  db 0, 0, 0, 0

inp_lost_num db 6, 0, 0, 0, 0, 0

int_arr db 0, 0, 0, 0, 0
		db 0, 0, 0, 0, 0
		db 0, 0, 0, 0, 0
		db 0, 0, 0, 0, 0
		db 0, 0, 0, 0, 0
		db 0, 0, 0, 0, 0
		db 0, 0, 0, 0, 0

int_x db "xx"
int_y db "yy"

res_str db 0, 0, 0, 0, 0

res_arr db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
		db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
		db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
		db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
		db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
		db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
		db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
		db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
		db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
		db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

res1_msg db 10, 13, "Sum of elements: ", "$"
res2_msg db 10, 13, "Biggest element is ", "$"
res3_msg db 10, 13, "Smallest element is ", "$"
res4_msg db 10, 13, "Result:", 10, 13, "$"
res5_msg1 db 10, 13, "Y: "
res5_str1_val db 0, 0, 0, 0
res5_msg2 db 10, 13, "X: "
res5_str2_val db 0, 0, 0, 0
res5_msg3 db 10, 13, "There is no such number in array", "$"

overflow_err db 10, 13, 10, 13, "There is overflow in register!", 10, 13, "$"
too_long_err db 10, 13, 10, 13, "Input integer is too long!", 10, 13, "$"
wrong_input_err db 10, 13, 10, 13, "Wrong input!", 10, 13, "$"

crlf db 10, 13, "$"

CODESEG
Start:
	M_init

	M_clearscreen
	; Вступительное сообщение
	mov dx, offset welcome_screen
	M_print
	; Считывание символа с клавиатуры. Результат в AL
	mov ah, 07h
	int 21h

	; Смотрим, какую опцию выбрал пользователь
	cmp al, "1"
	je option1
	cmp al, "2"
	je option2
	cmp al, "3"
	je option3
	cmp al, "4"
	je option4
	cmp al, "5"
	je option5
	; Если ни одну из них, то выбрасываем ошибку
	mov bx, 2
	call error_manager

	option1:	; Найти сумму элеменов в массиве
		call task1

	option2:	; Найти самый большой элемент массива
		call task2

	option3:	; Найти самый маленький элемент массива
		call task3

	option4:	; Отсортировать массив
		call task4

	option5:	; Найти координату элемента в двухмерном массиве
		call task5

	; ---------------------------------------------------------------------------------
	; #################################################################################
	; ---------------------------------------------------------------------------------
	proc task1
		mov dx, offset opt1_msg		; Читаем ввод
		call read_1d_arr

		mov si, offset inp_arr+2	; Парсим массив-стринг в массив интов
		mov bx, offset int_arr
		call parse_1d_arr

		mov si, offset int_arr		; Считаем сумму элементов
		call calculate_sum

		mov si, offset res_str		; Переводим значение из АХ в стринг
		call dec2string

		M_crlf						; Принтим результат
		mov dx, offset res1_msg
		M_print
		mov dx, offset res_str
		M_print

		M_exit
	endp task1
	; ---------------------------------------------------------------------------------
	; #################################################################################
	; ---------------------------------------------------------------------------------
	proc task2
		mov dx, offset opt2_msg		; Читаем ввод
		call read_1d_arr

		mov si, offset inp_arr+2	; Парсим массив-стринг в массив интов
		mov bx, offset int_arr
		call parse_1d_arr

		mov si, offset int_arr		; Ищем самое большое значение
		call find_biggest

		mov si, offset res_str		; Переводим значение из АХ в стринг
		call dec2string

		M_crlf						; Принтим результат
		mov dx, offset res2_msg
		M_print
		mov dx, offset res_str
		M_print

		M_exit
	endp task2
	; ---------------------------------------------------------------------------------
	; #################################################################################
	; ---------------------------------------------------------------------------------
	proc task3
		mov dx, offset opt3_msg		; Читаем ввод
		call read_1d_arr

		mov si, offset inp_arr+2	; Парсим массив-стринг в массив интов
		mov bx, offset int_arr
		call parse_1d_arr

		mov si, offset int_arr		; Ищем самое большое значение
		call find_smallest

		mov si, offset res_str		; Переводим значение из АХ в стринг
		call dec2string

		M_crlf						; Принтим результат
		mov dx, offset res3_msg
		M_print
		mov dx, offset res_str
		M_print

		M_exit
	endp task3
	; ---------------------------------------------------------------------------------
	; #################################################################################
	; ---------------------------------------------------------------------------------
	proc task4
		mov dx, offset opt4_msg		; Читаем ввод
		call read_1d_arr
		
		mov si, offset inp_arr+2	; Парсим массив-стринг в массив чисел
		mov bx, offset int_arr
		call parse_1d_arr
		push cx
		
		mov si, offset int_arr		; Сортируем
		add cx, si
		dec cx
		call sort
		
		mov si, offset res_arr		; Конвертируем массив чисел в массив-стринг для вывода
		mov bx, offset int_arr
		pop cx
		call arr2str

		M_crlf						; Принтим результат
		mov dx, offset res4_msg
		M_print
		mov dx, offset res_arr
		M_print

		M_exit
	endp task4
	; ---------------------------------------------------------------------------------
	; #################################################################################
	; ---------------------------------------------------------------------------------
	proc task5
		mov dx, offset opt5_msg		; Читаем ввод
		call read_4х4_arr

		mov bx, offset int_arr		; Парсим массив-стринг в массив чисел
		call parse_4x4_arr

		mov si, offset int_arr		; Ищем элемент и получаем его координаты
		call bloodhound

		mov si, offset int_x		; Парсим числа в стринги, чтобы их можно было распечатать
		mov ax, [si]
		mov si, offset res5_str1_val
		call dec2string
		mov si, offset int_y
		mov ax, [si]
		mov si, offset res5_str2_val
		call dec2string

		mov dx, offset res5_msg1	; Печатаем
		M_print
		mov dx, offset res5_msg2
		M_print
		M_crlf
		
		M_exit
	endp task5
	; ---------------------------------------------------------------------------------
	; #################################################################################
	; ---------------------------------------------------------------------------------

	; =================================== Процедури ===================================
	; ---------------------------------------------------------------------------------
	; Предназначение: Считывание одномерного масива чисел из консоли
	; Ввод:
	; DX <- Доп сообщение для вывода
	; Вывод: ---
	; ---------------------------------------------------------------------------------
	proc read_1d_arr
		; Очистка консоли
		M_clearscreen
		; Вывод доп сообщения на консоль
		M_print		; DX нужен здесь
		
		; Чтение элементов
		mov ah, 0ah
		mov dx, offset inp_arr
		int 21h

		ret
	endp read_1d_arr

	; ---------------------------------------------------------------------------------
	; Предназначение: Считывание 4x4 чисел из консоли
	; Ввод:
	; DX <- Доп сообщение для вывода
	; Вывод: ---
	; ---------------------------------------------------------------------------------
	proc read_4х4_arr
		; Очистка консоли
		mov al, 2
		mov ah, 0
		int 10h
		; Вывод доп сообщения на консоль
		M_print		; DX нужен здесь
		
		; Чтение элементов
		mov dx, offset opt5_row0_msg
		M_print
		mov ah, 0ah
		mov dx, offset inp_arr0to3
		int 21h
		M_crlf

		mov dx, offset opt5_row1_msg
		M_print
		mov ah, 0ah
		mov dx, offset inp_arr4to7
		int 21h
		M_crlf

		mov dx, offset opt5_row2_msg
		M_print
		mov ah, 0ah
		mov dx, offset inp_arr8to11
		int 21h
		M_crlf

		mov dx, offset opt5_row3_msg
		M_print
		mov ah, 0ah
		mov dx, offset inp_arr12to15
		int 21h
		M_crlf

		M_crlf
		mov dx, offset opt5_lost_num
		M_print
		mov ah, 0ah
		mov dx, offset inp_lost_num
		int 21h
		M_crlf

		ret
	endp read_4х4_arr

	; ---------------------------------------------------------------------------------
	; Предназначение: парс массива-стринга в массив интов
	; Ввод:
	; SI <- ссылка на массив-стринг
	; BX <- ссылка на массив интов
	; Вывод:
	; CX <- длинна масива интов
	; ---------------------------------------------------------------------------------
	proc parse_1d_arr
		xor cx, cx
		parser_loop:
			push bx				; Сохраняем ссылку на массив интов

			; Проверяем, не спецсимвол ли следующий элемент
			mov dh, [si]		; СМР с [SI] работать не хотят, поэтому записываем 
			cmp dh, ","
			je comma			; [SI] == "," : Пропустить ее
			cmp dh, 0dh
			je parse_1d_end		; [SI] == "Enter" : Конец

			mov bh, 3			; Числа-стринги всегда длинной в 3 символа
			call string2dec		; Проебражаем

			pop bx				; Возвращаем ссылку на массив интов
			mov [bx], ax		; Записываем число в массив
			inc bx				; Идем к следующему элементу
			inc cx
			jmp parser_loop		; Идем к следующему числу

		comma:
			inc si		; Пропускаем запятую и забываем о ней
			add sp, 2	; Игнорируем последний элемент в стеке
			jmp parser_loop

		parse_1d_end:
		mov [bx], "$"	; Запишем в конце терминирующий символ, на который потом будет откликаться
		inc bx
		add sp, 2		; Если не заберем лишний элемент из стека, у нас исказится значение IP и из программы мы никогда не выйдем
		ret
	endp parse_1d_arr

	; ---------------------------------------------------------------------------------
	; Предназначение: парс 4 массивов-стрингов в 4 массива интов. При помощи процедуры для парса одногомерного массива лол
	; Ввод:
	; BX <- ссылка на начало массива интов
	; Вывод:
	; BP <- искомое число
	; ---------------------------------------------------------------------------------
	proc parse_4x4_arr
		mov si, offset inp_arr0to3 + 2
		M_4x4p_len_check
		call parse_1d_arr
		dec bx

		mov si, offset inp_arr4to7 + 2
		M_4x4p_len_check
		call parse_1d_arr
		dec bx

		mov si, offset inp_arr8to11 + 2
		M_4x4p_len_check
		call parse_1d_arr
		dec bx

		mov si, offset inp_arr12to15 + 2
		M_4x4p_len_check
		call parse_1d_arr

		mov si, offset inp_lost_num + 2
		mov bh, [si-1]
		cmp bh, 3d
		jne parse_4x4_error
		call string2dec
		mov bp, ax
		ret

		parse_4x4_error:
			mov bx, 2
			call error_manager
	endp parse_4x4_arr

	; ---------------------------------------------------------------------------------
	; Предназначение: Парс стринга в десятичное число
	; Вход:
	; BH <- Длинна стринга (1-3)
	; SI <- Адрес начала стринга
	; Выход:
	; AX <- результат, десятичное число
	; ---------------------------------------------------------------------------------
	proc string2dec
		push cx
		mov ax, 0	; Результат
		mov cx, 0	; Буфер для числа
		Str_parser:
			mov al, [si]	; Считываем чар из стринга

			; Проверка на конец стринга
			cmp al, 0dh		; 0dh = "Enter"
			je no_error

			; Проверяем, цифра ли это
			cmp al, "0"
			jb error
			cmp al, "9"
			ja error
			sub al, 30h		; Конвертируем чар в цифру

			; Увеличиваем число в зависимости от его разряда
			cmp bh, 3
			je mul_by_100
			cmp bh, 2
			je mul_by_10
			jmp str_continue

			mul_by_100:
			mov dx, 10d
			mul dx
			mul_by_10:
			mov dx, 10d
			mul dx

			str_continue:
			add cx, ax		; Сохраняем число в буфер
			inc si			; Двигаем указатель на следующий чар
			dec bh			; BH == 0 : Конец
			jnz Str_parser	; BH != 0 : Повтор
		mov ax, cx

		; Искусственное ограничение числа до 255
		; Оно необязательно, но я лучше себя заранее обезопашу от возможных трудностей...
		; ...с 2-байтными регистрами в будущем
		cmp ax, 255d
		jna no_error
		
		; Ашипка и терминация
		error:
		mov bx, 2
		call error_manager

		no_error:
		mov ax, cx
		pop cx
		ret
	endp string2dec

	; ---------------------------------------------------------------------------------
	; Предназначение: Парс массива чисел в 1 стринг
	; Ввод:
	; SI <- Ссылка на начало стринга для записи
	; BX <- Массив чисел для парса
	; CX <- Длинна массива
	; Вывод: ---
	; ---------------------------------------------------------------------------------
	proc arr2str
		xor ax, ax
		arr2str_loop:
			mov al, [bx]
			call dec2string	; Парсим число в стринг

			mov [si], ","	; Пишем после него запятую
			inc si			; Следующий элемент стринга
			inc bx			; Следующее число
			dec cx			; CX != 0 : Повтор
			jnz arr2str_loop; CX == 0 : Конец
		
		mov [si-1], "$"		; Дописываем в конце терминальный символ
		ret
	endp arr2str

	; ---------------------------------------------------------------------------------
	; Предназначение: Парс десятичного числа в стринг
	; Ввод:
	; SI <- Ссылка на начало стринга для записи
	; AX <- Число для парса
	; Вывод: ---
	; ---------------------------------------------------------------------------------
	proc dec2string
		push bx
		push cx

		mov bx, 10d		; 0 для проверки на последний разряд
		mov cx, 0
		Splitter:
			inc cx
			cmp ax, bx
			xor dx, dx	; Сбрасываем регистр DX, потому что иначе div начинает выкобениваться
			div bx		; Делим АХ на 10
			push dx		; Остаток (последняя цифра числа) записывается в стек. Так мы сможем получать их в правильном порядке потом
			xor dx, dx	; Сбрасываем регистр DX, потому что иначе div начинает выкобениваться
			cmp ax, 0
			jne Splitter
		
		Writer:
			pop dx			; Достаем последний доступный десяток
			add dx, 30h		; Делаем из числа символ цифры
			mov [si], dx	; Заносим цифру в стринг
			inc si
			dec cx
			jnz Writer
		
		mov [si], "$"
		pop cx
		pop bx
		ret
	endp dec2string

	; ---------------------------------------------------------------------------------
	; Предназначение: посчитать сумму элементов массива
	; Ввод:
	; SI <- ссылка на начало массива
	; CX <- длинна массива чисел
	; Вывод:
	; AX <- сумма всех элементов массива
	; ---------------------------------------------------------------------------------
	proc calculate_sum
		xor ax, ax					; Обнуляем регистр для результата
		xor dx, dx					; Обнуляем регистр для суммирования
		calculate_sum_loop:
			mov dl, [si]			; Достаем число
			add ax, dx				; Суммируем
			jo calculate_overflow	; Если регистр переполнен, идем делать ошибки

			inc si					; Следующее число
			dec cx					; СХ != 0 : Продолжить
			jnz calculate_sum_loop	; СХ == 0 : Конец
		ret

		calculate_overflow:
			mov bx, 0ffffh
			call error_manager
	endp calculate_sum

	; ---------------------------------------------------------------------------------
	; Предназначение: поиск самого большого числа в массиве
	; Ввод:
	; SI <- ссылка на начало массива
	; CX <- длинна массива чисел
	; Вывод:
	; AX <- самое большое число
	; ---------------------------------------------------------------------------------
	proc find_biggest
		xor ax, ax					; Обнуляем регистр для результата
		mov al, [si]				; Берем первое значение как самое большое
		inc si						; И идем к следующему
		find_biggest_loop:
			mov dl, [si]			; Достаем значение
			cmp dl, al				; Сравниваем с самым большим
			ja bigger				; DL > AL : AL = DL
			inc si					; Следующий элемент
			dec cx					; СХ != 0 : Продолжить
			jnz find_biggest_loop	; СХ == 0 : Конец
		ret

		bigger:
		mov al, dl
		inc si
		jmp find_biggest_loop
	endp find_biggest

	; ---------------------------------------------------------------------------------
	; Предназначение: поиск самого маленького числа в массиве
	; Ввод:
	; SI <- ссылка на начало массива
	; CX <- длинна массива чисел
	; Вывод:
	; AX <- самое маленькое число
	; ---------------------------------------------------------------------------------
	proc find_smallest
		xor ax, ax					; Обнуляем регистр для результата
		mov al, [si]				; Берем первое значение как самое маленькое
		inc si						; И идем к следующему
		find_smallest_loop:
			mov dl, [si]			; Достаем значение
			cmp dl, al				; Сравниваем с самым большим
			jb smaller				; DL < AL : AL = DL
			inc si					; Следующий элемент
			dec cx					; СХ != 0 : Продолжить
			jnz find_smallest_loop	; СХ == 0 : Конец
		ret

		smaller:
		mov al, dl
		inc si
		jmp find_smallest_loop
	endp find_smallest

	; ---------------------------------------------------------------------------------
	; Предназначение: сортировка методом выбора от большего к меньшему
	; Ввод:
	; SI <- ссылка на начало массива
	; CX <- ссылка на конец массива
	; Вывод: ---
	; ---------------------------------------------------------------------------------
	proc sort
		; SI Вказує на перший елемент (після першої ітерації - останній відсортований)
		SORT_START:
			mov bp, si				; Лічильник ітерацій у циклі пошуку
			inc bp
			mov bx, bp				; Адреса першого елементу у циклі пошуку 
			mov di, 0				; Зміщення адреси при пошуку найбільшого елементу
			mov ah, [bx]			; Перший елемент у циклі пошуку (після нього - найменший елемент після операції пошуку)
			
			HIGHEST_FINDER:			; Цикл пошуку найбільшого елементу після елементу за адресою DS:SI
			cmp bp, cx				; Умова виходу із циклу пошуку
			je SWAPPER				; Цикл буде перерваний, якщо ми дійшли до кінця таблиці при пошуку
			
			inc di
			cmp ah, [bx+di]			
			ja ISNT_HIGHEST			; Якщо елемент AH менший за [BX+SI], тоді ми НЕ ПЕРЕСТРИБУЄМО наступні до ISNT_HIGHEST
			add bx, di
			mov ah, [bx]
			mov di, 0
			ISNT_HIGHEST:
			inc bp
			jmp HIGHEST_FINDER
			
			SWAPPER:				; Цикл переміщення найбільшого елементу на його місце
			cmp [si], ah			
			ja NO_SWAP				; Якщо DS:SI більше AH, то ми змінюємо їх місцями (елемент вже стоїть на своєму місці)
			mov al, [si]
			mov [si], ah
			mov [bx], al
			
			NO_SWAP:				; Якщо ні, то стрибаємо сюди
			inc si
			cmp si, cx
			jne SORT_START			; Якщо ми пройшли увесь масив (SI = arrray_length), то ми ви
		ret
	endp sort

	; ---------------------------------------------------------------------------------
	; Предназначение: поиск числа в массиве
	; Ввод:
	; SI <- ссылка на начало массива интов
	; BP <- искомое число
	; Вывод:
	; AX <- Y искомого числа
	; DX <- X искомого числа
	; ---------------------------------------------------------------------------------
	proc bloodhound
		mov ax, 0		; Индекс числа в одномерном массиве
		mov cx, 15d		; Длинна массива
		xor dx, dx
		bloodhound_loop:
			mov dl, [si]
			cmp dx, bp				; BP == [SI] : Конец. Число было найдено
			je bloodhound_loophole	; BP != [SI] : Продолжить
			inc ax					; Следующий индекс
			inc si					; Следующее число
			cmp ax, cx				; AX == CX : Конец. Числа в массиве нету
			je bloodhound_error		; AX != CX : Продолжить
			jmp bloodhound_loop

		bloodhound_loophole:
		xor dx, dx	; Так надо, поверьте
		mov di, 4	; Делим АХ на 4, чтобы получить строку и колноку
		div di		; АХ <- результат деления с остатком, наш Y
		;dec dx		; DX <- остаток от деления, наш Х. Надо инкрементировать, чтобы вернуть корректность результата
		
		mov si, offset int_y
		mov [si], dx
		mov si, offset int_x
		mov [si], ax
		ret

		bloodhound_error:
		mov dx, offset res5_msg3
		M_print
		M_exit
	endp bloodhound

	; ---------------------------------------------------------------------------------
	; Предназначение: выбрасывание разных ошибок
	; Ввод:
	; BX <- код ошибки менеджера
	; Вывод: ---
	; ---------------------------------------------------------------------------------
	proc error_manager
		mov ah, 09h
		cmp bx, 1h		; too long input error
		je too_long_error
		cmp bx, 2h		; wrong input error
		je wrong_input_error
		cmp bx, 0ffffh	; overflow error
		je overflow_error
		jmp halt

		too_long_error:		; BX <- 1
			mov dx, offset too_long_err
			int 21h
			jmp halt
		wrong_input_error:	; BX <- 2
			mov dx, offset wrong_input_err
			int 21h
			jmp halt
		overflow_error:		; BX <- FFFFh
			mov dx, offset overflow_err
			int 21h
			jmp halt

		halt:
		M_error_exit
		ret
	endp error_manager

	end Start