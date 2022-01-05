;					І. Заголовок програми
IDEAL
MODEL small
STACK 256
;					ІІ. Макроси
;					ІІІ. Початок сегменту даних
DATASEG
exCode db 0
messsage_wrong_numer db 10, 13,"You entred wrong input ", "$"
messsage db "We accept only number between -255 and 255: ", "$"
space db 10, 13, "Output: ", "$"
buffer db 5, ? , 7 dup(' ') 
number_length db 0
number dw 0

;					IV. Початок сегменту коду
CODESEG
Start:
;---------------1. Ініціалізація DS та ES----------------
	mov ax, @data	; @data ідентифікатор, що створюються директивою MODEL
	mov ds, ax		; Завантаження початку сегменту даних в регістр DS
	mov es, ax		; Завантаження початку сегменту даних в регістр ES
;---------------2. лаба 2----------------------

	; входное сообщение.
	mov dx, offset messsage
	mov ah, 09h
	int 21h

	; считываем строку с консоли, макс символов указан в buffer.
	mov dx, offset buffer 
 	mov ah, 0ah 
 	int 21h

	xor ax, ax
	mov si, offset buffer+2; cмещаем указатель к началу числа.
	mov al, [si-1]; получаем длинну строки.
	
	xor dx, dx
	mov dl, [si]
	cmp dl, '-' ; Дополнительные действия если работаем с отрицательным числом.
	jne To_number
	push dx ; перекидываем информацию в низ :)
	

	To_number:
	mov bx, offset number_length
	mov [bx], al ; записуем длинну цифры
	xor ah, ah

	mov si, offset buffer+2; cмещаем указатель к началу числа.
	add si, [bx]; передвигаем каретку к концу строки.
	dec si; сдвигаем на 1 влево, так как последний элемент. Это перевод на новую сточку.
	

	cmp dl, '-' ;
	jne Skip
	mov bx, offset number_length
	dec al ; уменьшаем длинну на 1, так как "-"
	mov [bx], al ; записуем длинну цифры
	Skip:


	mov cl, 0 ; установка счетчика для цикла
	Cycle:
	; переводим строковое представление в число
	mov ah, [si]
	sub ah, "0"
	mov [si], ah 

	; Вычисление степени 10тки
	xor ax, ax ; обнуляем 
	inc ax

	cmp cl, 0; Проверяем, если у нас крайнее правое число
	je skip_ten; то для него не надо вычислять степень 10.

	mov bh, cl ; записываем степень 10тки. она зависит от итерации.
	Ten_power:
		mov dl, 10
		mul dl
		dec bh
		cmp bh, 0
		jne  Ten_power

	skip_ten: ; метка для пропуска 

	mov dh, [si] ; получаем цифру из инпута
	mul dh ; умножаем её на степень 10ти


	mov bx, offset number ; получаем число которое мы приводим
	mov dx, [bx] 
	add dx, ax ; добавляем след. разряд.
	mov [bx], dx ; записываем.


	inc cl ; увеличиваем разрядность
	dec si ; переходим на число левее

	mov al, [number_length]
	cmp cl, al ; проверка не закончилось ли наше число
	jne  Cycle


	

	mov bx, offset number ; получаем число которое мы приводим
	mov dx, [bx]

	cmp dx, 255d ; если число больше 255 то вылет.
	ja Error_large_number


	mov ax, dx ; копия вводимиого числа.
	pop bx
	cmp bx, "-"
	jne Ordinary_number
	
	sub dx, 67
	neg dx

	cmp dx, 67 ; если число меньше 99, то оно будет отрицательным и нужны доп действия.
	mov si, offset buffer
	jb skip_steps_for_negative_number

	jmp Negative_step

	Ordinary_number: ;number that >=0


	add dx, 67	; 03. +67 моё задание.
	mov si, offset buffer
	jmp skip_steps_for_negative_number

	
	Negative_step:
	mov si, offset buffer
	neg dx
	mov [si], "-"
	inc si

	skip_steps_for_negative_number:
	
	mov [bx], dx 

	;Дальше идет перевод из числа в строку.
	mov ax, dx; с прошлого задания наше число было в dx и мы записуемо его в ax
	mov bl, 0	; 0 для проверки на последний разряд, можно было флажок использовать.
	Number_to_String_Pars:
	; Смотрим, в каком разряде вы находимся
	cmp ax, 100d
	ja three_digit

	cmp ax, 10d
	ja two_digit

	mov cx, 1d
	mov bl, 1	; Вот мы и на последнем разряде!
	jmp divide

	three_digit:
	mov cx, 100d
	jmp divide
	two_digit:
	mov cx, 10d
	jmp divide

	divide:
	; Получаем нашу цифру, делением с остатком
	; AX <- Делимое, потом результат деления с остатком
	; CX <- Делитель
	; DX <- Остаток
	xor dx, dx
	div cx
	cmp ax, 0
	
	add ax, "0" ;  переводим цифру в строковое значение
	mov [si], ax ; заносим значение в буффер
	
	; Повторить BL раз
	mov ax, dx ; записываем остаток от деления в ax, чтобы дальше с ним работать.
	inc si ; переходим на след. байт
	cmp bl, 1

	jne Number_to_String_Pars

	mov [si], "$" ; дописываем доллар для прерывания дос.

	; выводим наш буфер обратно на консоль.
	mov ah, 09h
	mov dx, offset space
	int 21h
	mov dx, offset buffer
	int 21h
	jmp Exit


	Error_large_number:
	mov ah, 09h
	mov dx, offset messsage_wrong_numer
	int 21h
	jmp Exit


	;---------------4. Вихід із програми---------------------]
	Exit:
	mov ah, 4ch			; Завантаження числа 01h до регістру AH 
	mov al, [exCode]	; Завантаження значення exCode до регістру AL
	int 21h				; Виклик преривання 21h (AH = 4ch, AL = код виходу - команда виходу із програми)

	end Start