.386
.model flat, c
.stack 4096

.data

.code

option language: syscall
_Odejmowanie@8 proc
enter 0, 0

finit
fld [ebp+8]
fsub [ebp+12]
FSTP eax

 leave
 ret
_Odejmowanie@8 endp
option language: c
end 