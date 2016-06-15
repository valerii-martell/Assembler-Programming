.586
.model flat, c

.code

mov_longop proc 

push ebp 
mov ebp, esp 
mov ecx, [ebp + 8] ;розрядність маски 
mov edx, [ebp + 12] ;номер біта
mov edi, [ebp + 16] ;адреса вихідного рядка

shr ecx, 3 
shr edx, 3

cycleMOV: 
add edx, ecx
mov byte ptr [edi + edx - 1], 17
sub edx, ecx
dec ecx
jnz cycleMOV

pop ebp 
ret 16
mov_longop endp

mov0_longop proc 

push ebp 
mov ebp, esp 
mov ecx, [ebp + 8] ;розрядність маски 
mov edx, [ebp + 12] ;номер біта
mov edi, [ebp + 16] ;адреса вихідного рядка

shr ecx, 3 
shr edx, 3

cycleMOV: 
add edx, ecx
mov byte ptr [edi + edx - 1], 0
sub edx, ecx
dec ecx
jnz cycleMOV

pop ebp 
ret 16
mov0_longop endp

end
