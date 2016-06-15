.586
.model flat, stdcall

include \masm32\include\kernel32.inc
include \masm32\include\user32.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib
include module.inc
include longop.inc

.data

nfact db "52!", 0 
nn db "52!*52!", 0

n32TextBuf db 273 dup(? )
nnTextBuf db 546 dup(? )
ct dd 52
fact_result db 1, 31 dup (0)
buf db 32 dup (0)
fact_sqr_result db 64 dup (0)
fact_text db 64 dup (0)
fact_sqr_text db 128 dup (0)
test1 dd 5 dup (1)
repeatByA dd 5            
repeatByB dd 3				
repeatcounter dd 0                          
nF32 dd 0FFFFFFFFh             
nNF32 dd 5 dup (0FFFFFFFFh)
nFN dd 5 dup (0FFFFFFFFh)
nNFN dd 5 dup (0FFFFFFFFh)
testcounter dd 0                        
counterAI dd 0                      
counterBJ dd 0                      
counter_result dd 0
result_Nx32 dd 6 dup(0)
result_NxN dd 18 dup(0)
Caption_Nx32 db "Test  Nx32", 0
Caption_NxN db "Test NxN", 0
TextBuf_Nx32 dw 12 dup(?)
TextBuf_NxN db 32 dup(?)

.code
main :

@cycle:
mov esi, offset fact_result
mov edi, offset buf
mov ecx, 8
rep movsd
mov eax, 0
mov edi, offset fact_result
mov ecx, 8
rep stosd
push offset buf
push ct
push offset fact_result
push 32
call Mul_N_32_LONGOP
dec ct
cmp ct, 1
jg @cycle

push offset fact_text
push offset fact_result
push 256
call StrHex_MY
invoke MessageBoxA, 0, ADDR fact_text, ADDR nfact, 0

mov eax, 0
mov edi, offset fact_sqr_result
mov ecx, 16
stosd
push offset fact_result
push offset fact_result
push offset fact_sqr_result
push 32
call Mul_N_N_LONGOP

push offset fact_sqr_text
push offset fact_sqr_result
push 512
call StrHex_MY
invoke MessageBoxA, 0, ADDR fact_sqr_text, ADDR nn, 0

mov ebx, nF32  
cycle_Mult:	
     mov ecx, testcounter
	 mov eax, dword ptr [nNF32+4*ecx]
	 mul ebx
	 add dword ptr[result_Nx32+4*ecx], eax   
	 inc ecx  
	 add dword ptr[result_Nx32+4*ecx], edx
	 mov testcounter, ecx    
	 mov ecx, repeatByA   
	 dec ecx  
	 mov repeatByA, ecx 
jnz cycle_Mult	

push offset TextBuf_Nx32
push offset result_Nx32
push 512
call StrHex_MY 
invoke MessageBoxA, 0, ADDR TextBuf_Nx32, ADDR Caption_Nx32,0
	 	 
mov repeatByA, 4
mov testcounter, 0
mov ecx, 0
clc
@cycle_Higher:
	mov ecx, repeatcounter
	cmp ecx, repeatByB
	jg @exit
	mov ecx, counterBJ
	mov counter_result, ecx
	mov ebx , dword ptr [nFN+4*ecx]    
	inc ecx
	mov repeatcounter, ecx
	cycle_Mult1:	
		mov ecx, counterAI                       
		mov eax, dword ptr [nNFN+4*ecx]     
		inc ecx                              
		mov counterAI, ecx            
		mov ecx, counter_result                 
		mul ebx                           
	   	add dword ptr[result_NxN+4*ecx], eax   
		inc ecx  
		adc dword ptr[result_NxN+4*ecx], edx
		mov counter_result, ecx   
		CF_spred:				
			inc ecx
			mov eax, 0
			adc dword ptr[result_NxN+4*ecx], eax
		jc CF_spred
	    clc
		mov ecx, repeatByA  
		dec ecx  
	    mov repeatByA, ecx 
	jnz cycle_Mult1
	mov repeatByA, 4
	mov ecx, 0
	mov counterAI, ecx
	mov ecx, counterBJ
	inc ecx
	mov counterBJ, ecx		
jmp @cycle_Higher

@exit:
push offset TextBuf_NxN 
push offset result_NxN
push 256
call StrHex_MY 
invoke MessageBoxA, 0, ADDR TextBuf_NxN, ADDR Caption_NxN,0

invoke ExitProcess, 0
end main