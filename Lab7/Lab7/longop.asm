.586
.model flat, c

.data

	temp dd 12 dup(0)
	buf dd 0
	Nbit dd 0

.code

Multip_Nx32_LONGOP proc
	push ebp
	mov ebp, esp
	mov esi, [ebp+16]
	mov ebx, [ebp+12]
	mov edi, [ebp+8]
	
	mov ecx, 0
	@cycle: 
		mov eax, dword ptr[esi + 4 * ecx]
		mul ebx
		add dword ptr[edi + 4 * ecx], eax
		add dword ptr[edi + 4 * ecx + 4], edx
		inc ecx
		cmp ecx, 12
	jb @cycle

	pop ebp
	ret 
Multip_Nx32_LONGOP endp

Div10_LONGOP proc
	push ebp
	mov ebp, esp

	mov esi, [ebp+24] ; ділене 
	mov eax, [ebp+20] ; дільник
	mov ebx, [ebp+16] ; розрядність діленого
	mov edi, [ebp+12] ; частка
	mov ecx, [ebp+8] ; остача

	mov buf, eax
	shr ebx, 3
	dec ebx

	xor eax, eax
	@cycle:
		mov al, byte ptr[esi + ebx]
		div byte ptr[buf]
		mov byte ptr[edi + ebx], al
		dec ebx
		cmp ebx, 0
		jge @cycle
	mov byte ptr[ecx], ah

	mov esp, ebp
	pop ebp
	ret 20
Div10_LONGOP endp

Function_LONGOP proc
	push ebp
	mov ebp, esp

	mov esi, [ebp+16] ; y
	mov ebx, [ebp+12] ; x
	mov cl, [ebp+8]  ; m

	cdq


	add ebx, 1
	mov eax, 11
	shl eax, cl
	idiv ebx

	mov dword ptr[esi], eax

	mov esp, ebp
	pop ebp
	ret 12
Function_LONGOP endp

end