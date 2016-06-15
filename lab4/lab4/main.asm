.586
.model flat, stdcall

option casemap :none
include \masm32\include\kernel32.inc
include \masm32\include\user32.inc
include \masm32\include\windows.inc
include module.inc
include longop.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib

.const
.data

.data
Valueb1 db 31

Caption1 db "A+B (1 variant)",0
Caption2 db "A+B (2 variant)",0
Caption3 db "A-B ",0

TextBuf1 db 52 dup(?)
TextBuf2 db 52 dup(?)
TextBuf3 db 88 dup(?)

ValueA1 dd 52 dup(?) 
ValueB1 dd 52 dup(?) 
ValueA2 dd 52 dup(?) 
ValueB2 dd 52 dup(?) 
ValueA3 dd 88 dup(?)
ValueB3 dd 88 dup(?)

Result1 dd 52 dup(0)
Result2 dd 52 dup(0)  
Result3 dd 88 dup(0)

.code
main:

;А+B 1
mov eax , 80010001h
mov ecx, 52   ; ECX = потрібна кількість повторень 
mov edx,0
cycleAB1:
mov DWord ptr[ValueA1+4*edx], eax
mov DWord ptr[ValueB1+4*edx], 80000001h
add eax , 10000h
inc edx
dec ecx        ; лічильник зменшуємо на 1 
jnz cycleAB1

push offset ValueA1
push offset ValueB1
push offset Result1
call Add_416_LONGOP
push offset TextBuf1 
push offset Result1
push 416
call StrHex_MY 

invoke MessageBoxA, 0, ADDR TextBuf1, ADDR Caption1,0

;А+B 2
mov eax , 0Bh
mov ecx, 52   ; ECX = потрібна кількість повторень 
mov edx,0
cycleAB2: 
mov DWord ptr[ValueA2+4*edx], eax
mov DWord ptr[ValueB2+4*edx], 00000001h
add eax , 1h
inc edx
dec ecx        ; лічильник зменшуємо на 1 
jnz cycleAB2

push offset ValueA2
push offset ValueB2
push offset Result2
call Add_416_LONGOP
push offset TextBuf2 
push offset Result2 
push 416
call StrHex_MY 

invoke MessageBoxA, 0, ADDR TextBuf2, ADDR Caption2,0

;А-B 
mov eax , 0Bh
mov ecx, 88   ; ECX = потрібна кількість повторень 
mov edx,0
cycleAB3: 
mov DWord ptr[ValueA3+4*edx], 0
mov DWord ptr[ValueB3+4*edx], eax
add eax , 1h
inc edx
dec ecx        ; лічильник зменшуємо на 1 
jnz cycleAB3

push offset ValueA3
push offset ValueB3
push offset Result3
call Sub_704_LONGOP
push offset TextBuf3 
push offset Result3
push 704
call StrHex_MY 

invoke MessageBoxA, 0, ADDR TextBuf3, ADDR Caption3,0

invoke ExitProcess, 0
end main