.586
.model flat, c

.data
	x dd 0
	y dd 0
	ten dd 10
.code


Sin_Funct proc 
	push ebp
	mov ebp, esp

	mov edi, [ebp + 8] 
	mov esi, [ebp + 12] 
	mov eax, [ebp + 16] 
	mov ecx, [ebp + 20] 

	xor ebx, ebx
	fld1
	fld dword ptr[esi]
	inc ebx

	@cycle:
		fld dword ptr[esi + 4*ebx]
		fld dword ptr[edi]
		fmul st(0), st(3)
		fsin

		fmulp st(1), st(0)
		faddp st(1), st(0)

		fld1
		faddp st(2), st(0)

		inc ebx
		cmp ebx, ecx
		jne @cycle
	fstp dword ptr[eax] 

	mov esp, ebp
	pop ebp
	ret 16
Sin_Funct endp

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

COPY_LONGOP proc 
	push ebp 
	mov ebp, esp 

	mov esi, [ebp + 12] 
	mov edi, [ebp + 8] 

	mov ecx, 12

	@change: 
		mov ebx, dword ptr[edi + 4 *  ecx - 4]
		mov dword ptr[esi + 4 * ecx - 4], ebx
		mov dword ptr[edi + 4 * ecx - 4], 0 
		dec ecx
	jnz @change

pop ebp 
ret 12

COPY_LONGOP endp

Div10_LONGOP proc
	push ebp
	mov ebp, esp
		mov edi, [ebp + 8] 
		mov ecx, [ebp + 12] 
	xor edx, edx
	dec ecx
	@cycle:
		mov eax, dword ptr[edi + ecx*4]
		div ten
		mov dword ptr[edi + ecx*4], eax 
		dec ecx
		cmp ecx, -1
	jne @cycle 

	pop ebp
	ret 8
Div10_LONGOP endp

end


