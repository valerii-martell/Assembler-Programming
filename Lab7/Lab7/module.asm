.586
.model flat, c
include longop.inc

.data
	number dd 12 dup(0)
	quotient dd 12 dup(0)
	remainder dd 0

	counter dd 0
	Nbit dd 0

.code
    ;процедура StrHex_MY записуЇ текст ш≥стнадц€тькового коду
    ;перший параметр - адреса буфера результату (р€дка символ≥в)
	;другий параметр - адреса числа
	;трет≥й параметр - розр€дн≥сть числа у б≥тах (маЇ бути кратна 8)
StrHex_MY proc
	push ebp
	mov ebp,esp
	mov ecx, [ebp+8]		;к≥льк≥сть б≥т≥в числа
	cmp ecx, 0
	jle @exitp
	shr ecx, 3				;к≥льк≥сть байт≥в числа
	mov esi, [ebp+12]		;адреса числа
	mov ebx, [ebp+16]		;адреса буфера результату
@cycle:
	mov dl, byte ptr[esi+ecx-1]		;байт числа - це дв≥ hex-цифри
 
	mov al, dl
	shr al, 4						;старша цифра
	call HexSymbol_MY
	mov byte ptr[ebx], al
 
	mov al, dl						;молодша цифра
	call HexSymbol_MY
	mov byte ptr[ebx+1], al

	mov eax, ecx
	cmp eax, 4
	jle @next
	dec eax
	and eax, 3						;пром≥жок розд≥люЇ групи по в≥с≥м цифр
	cmp al, 0
	jne @next
	mov byte ptr[ebx+2], 32			;код символа пром≥жку
	inc ebx

@next:
	add ebx, 2
	dec ecx
	jnz @cycle
	mov byte ptr[ebx], 0			;р€док зак≥нчуЇтьс€ нулем
@exitp:
	pop ebp
	ret 12
StrHex_MY endp

;ц€ процедура обчислюЇ код hex-цифри
;параметр - значенн€ AL
;результат -> AL
HexSymbol_MY proc
	and al, 0Fh
	add al, 48							;так можна т≥льки дл€ цифр 0-9
	cmp al, 58
	jl @exitp
	add al, 7							;дл€ цифр A,B,C,D,E,F
@exitp:
	ret
HexSymbol_MY endp


StrDec proc
	push ebp
	mov ebp, esp

	mov esi, [ebp+16] 
	mov edi, [ebp+12] 
	mov ebx, [ebp+8] 

	mov Nbit, ebx
	shr ebx, 5 
	dec ebx

	mov ecx, ebx
	@copy:
		mov eax, dword ptr[edi + 4*ecx]
		mov dword ptr[number + 4*ecx], eax

		dec ecx
		cmp ecx, 0
		jge @copy
	
	@cycle:
		push ebx
		push esi
		push edi
		
		push offset number
		push 10
		push Nbit
		push offset quotient
		push offset remainder
		call Div10_LONGOP

		pop edi
		pop esi
		pop ebx

		mov al, byte ptr[remainder]
		add al, 48
		mov byte ptr[esi], al
		inc counter

		mov ecx, counter
		@shift:
			mov dl, byte ptr[esi + ecx - 1]
			mov byte ptr[esi + ecx - 1], 48
			mov byte ptr[esi + ecx], dl

			dec ecx
			cmp ecx, 0
			jne @shift

		mov ecx, ebx
		@change:
			mov eax, dword ptr[quotient + 4*ecx]
			mov dword ptr[number + 4*ecx], eax
			mov dword ptr[quotient + 4*ecx], 0

			dec ecx
			cmp ecx, 0
			jge @change

		mov dword ptr[remainder], 0

		mov ecx, ebx
		@get:
			mov eax, dword ptr[number + 4*ecx]
			
			cmp eax, 0
			jne @cycle

			dec ecx
			cmp ecx, 0
			jge @get

	mov esp, ebp
	pop ebp
	ret 12
StrDec endp

end