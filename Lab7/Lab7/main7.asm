.586
.model flat, stdcall

option casemap :none
include \masm32\include\windows.inc
include module.inc
include longop.inc
include \masm32\include\kernel32.inc 
include \masm32\include\user32.inc  
includelib \masm32\lib\kernel32.lib 
includelib \masm32\lib\user32.lib

.data
	
	value dd 00000001h, 00000000h, 00000000h,
	00000000h, 00000000h, 00000000h,
	00000000h, 00000000h, 00000000h,
	00000000h, 00000000h, 00000000h
	fact dd 00000001h
	temp dd 12 dup(0)
	result dd 0
	count dd 0
	
	Caption1 db "Факторіал в шістнадцятковій системі числення", 0
	Caption2 db "Факторіал в десятковій системі числення", 0
	Caption3 db "Обчислення функції", 0
	
	TextBuff1 db 384 dup(?)
	TextBuff2 db 384 dup(?)	
	TextBuff3 db ?

.code

main:

	@cycle:
		push offset value
		push fact
		push offset temp
		call Multip_Nx32_LONGOP
		inc fact
		inc count
		cmp count, 78

		mov ecx, 12
		@change: 
			mov ebx, dword ptr[temp+4*ecx-4]
			mov dword ptr[value+4*ecx-4], ebx
			mov dword ptr[temp+4*ecx-4], 0 
			dec ecx
		jnz @change
	jb @cycle

	push offset TextBuff1
	push offset value
	push 384
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR TextBuff1, ADDR Caption1, MB_ICONINFORMATION

	push offset TextBuff1
	push offset value
	push 384
	call StrDec
	invoke MessageBoxA, 0, ADDR TextBuff1, ADDR Caption2, 0

	push offset result
	push 10   
	push 2     
	call Function_LONGOP

	push offset TextBuff3
	push offset result
	push 32
	call StrDec
	invoke MessageBoxA, 0, ADDR TextBuff3, ADDR Caption3, 0

	invoke ExitProcess, 0

end main
