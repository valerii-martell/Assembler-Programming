.586
.model flat, stdcall

option casemap :none
include \masm32\include\windows.inc
include module.inc
include longop.inc
include \masm32\include\kernel32.inc 
include \masm32\include\user32.inc
include \masm32\include\comdlg32.inc
  
includelib \masm32\lib\kernel32.lib 
includelib \masm32\lib\user32.lib
includelib \masm32\lib\comdlg32.lib 

.data
	Caption db "LabWork 9", 0
	pSizeFileName dd ?
	hFile dd 0
	pRes dd 0
	
	nextLine db 13, 10

	value dd 00000001h, 00000000h, 00000000h,
			00000000h, 00000000h, 00000000h,
			00000000h, 00000000h, 00000000h,
			00000000h, 00000000h, 00000000h

	fact dd 00000001h
	temp dd 12 dup(0)
	result dd 0
	TextBuff1 db 384 dup(?)

	count dd -1
.code

MySaveFileName proc
	LOCAL ofn : OPENFILENAME
	invoke RtlZeroMemory, ADDR ofn, SIZEOF ofn    ; спочатку усі поля обнулюємо	
	mov ofn.lStructSize, SIZEOF ofn
	mov eax, pSizeFileName
	mov ofn.lpstrFile, eax
	mov ofn.nMaxFile, 256
	invoke GetSaveFileName,ADDR ofn               ; виклик вікна File Save AS
	ret
MySaveFileName endp
 

main:
	invoke GlobalAlloc, GPTR, 256
	mov pSizeFileName, eax

	call MySaveFileName
	
	cmp eax, 0                                ; перевірка: якщо у вікні було натиснуто кнопку Cancel, то EAX=0 
	je @exit


	invoke CreateFile, pSizeFileName,
						GENERIC_WRITE,
						FILE_SHARE_WRITE,
						0, CREATE_ALWAYS,
						FILE_ATTRIBUTE_NORMAL,
						0
	cmp eax, INVALID_HANDLE_VALUE
	je @exit                                    ;доступ до файлу неможливий
	mov hFile, eax
	
	@cycle:
		push offset value
		push fact
		push offset temp
		call Multip_Nx32_LONGOP

		push offset TextBuff1
		push offset value
		push 384
		call StrHex_MY

		invoke lstrlen, ADDR TextBuff1 
		invoke WriteFile, hFile, ADDR TextBuff1, eax, ADDR pRes, 0 
	
		invoke lstrlen, ADDR nextLine 
		invoke WriteFile, hFile, ADDR nextLine,  2, ADDR pRes, 0

		inc fact
		inc count
		cmp count, 78

		push offset value
		push offset temp

		call COPY_LONGOP

	jb @cycle
	
	invoke GlobalFree, pSizeFileName

@exit:
	invoke CloseHandle, hFile
	invoke ExitProcess, 0
end main
	