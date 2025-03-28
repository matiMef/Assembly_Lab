.386
.model flat, c
.stack 4096

.data

.code

option language: syscall
_Mnozenie@8 proc
enter 0, 0

finit 
fld [ebp+8]
fmul [ebp+12]
FSTP eax

 leave
 ret
_Mnozenie@8 endp
option language: c
end 