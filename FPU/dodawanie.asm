.386
.model flat, c
.stack 4096

.data

.code

option language: syscall
_Dodawanie@12 proc
enter 0, 0

finit 
fld [ebp+8]
fld [ebp+12]
fadd 

cmp [ebp+16], 1 
JE ziemia

ziemia:
FRNDINT

FSTP eax

 leave
 ret
_Dodawanie@12 endp
option language: c
end 