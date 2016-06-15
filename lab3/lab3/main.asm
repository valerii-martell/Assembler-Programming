.586
.model flat, stdcall
option casemap :none
include \masm32\include\kernel32.inc
include \masm32\include\user32.inc
include \masm32\include\windows.inc
includelib \lib\kernel32.lib
includelib \lib\user32.lib
include \masm32\modules\module.inc

.data
   TextBuf db 64 dup (?)

   Value1 db 00010101b
   Value2 db 11101010b

   Value3 dw 0000000000010101b
   Value4 dw 1111111111101010b

   Value5 dd 00000000000000000000000000010101b
   Value6 dd 11111111111111111111111111101010b

   Value7 dq 21
   Value8 dq -21
   Value9 dd 21.0
   Value10 dd -42.0
   Value11 dd 21.21
   Value12 dq 21.0
   Value13 dq -42.0
   Value14 dq 21.21
   Value15 dt 21.0
   Value16 dt -42.0
   Value17 dt 21.21
  
  Caption db 'Lab 3', 0
  Caption1 db '64', 0

.code
main:
	push offset TextBuf
	push offset Value1
	push 8
	call StrHex_MY
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption, MB_ICONINFORMATION  
	
	push offset TextBuf
	push offset Value2
	push 8
	call StrHex_MY 
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption, MB_ICONINFORMATION 

	push offset TextBuf
	push offset Value3
	push 16
	call StrHex_MY 
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption, MB_ICONINFORMATION 

	push offset TextBuf
	push offset Value4
	push 16
	call StrHex_MY 
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption, MB_ICONINFORMATION 

	push offset TextBuf
	push offset Value5
	push 32
	call StrHex_MY 
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption, MB_ICONINFORMATION 

	push offset TextBuf
	push offset Value6
	push 32
	call StrHex_MY 
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption, MB_ICONINFORMATION 

	push offset TextBuf
	push offset Value7
	push 64
	call StrHex_MY 
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption, MB_ICONINFORMATION 

	push offset TextBuf
	push offset Value8
	push 64
	call StrHex_MY 
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption, MB_ICONINFORMATION 

	push offset TextBuf
	push offset Value9
	push 32
	call StrHex_MY 
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption, MB_ICONINFORMATION 

	push offset TextBuf
	push offset Value10
	push 32
	call StrHex_MY 
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption, MB_ICONINFORMATION 

	push offset TextBuf
	push offset Value11
	push 32
	call StrHex_MY 
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption, MB_ICONINFORMATION 

	push offset TextBuf
	push offset Value12
	push 64
	call StrHex_MY 
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption1, MB_ICONINFORMATION 

	push offset TextBuf
	push offset Value13
	push 64
	call StrHex_MY 
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption, MB_ICONINFORMATION 

	push offset TextBuf
	push offset Value14
	push 64
	call StrHex_MY 
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption, MB_ICONINFORMATION 

	push offset TextBuf
	push offset Value15
	push 80
	call StrHex_MY 
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption, MB_ICONINFORMATION 

	push offset TextBuf
	push offset Value16
	push 80
	call StrHex_MY 
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption, MB_ICONINFORMATION 

	push offset TextBuf
	push offset Value17
	push 80
	call StrHex_MY 
	invoke MessageBoxA, 0, ADDR TextBuf, ADDR Caption, MB_ICONINFORMATION 

  invoke ExitProcess, 0
end main