format PE console
include 'win32ax.inc'

section '.code' code readable executable

start:

        cinvoke printf, "Wybierz liczbe 1:"
        cinvoke scanf,  "%X", num1  ;num1 input
        cinvoke printf, "num1 = %X%c", [num1], 10

        cinvoke printf, "Wybierz operacje arytmetyczna!%c", 10  ;text, new line
        cinvoke printf, "1.+ 2.- 3.*%c", 10
        cinvoke scanf,  "%s", choice2 ;getting choice 2 as char
        cinvoke printf, "choice2 = %X%c", [choice2], 10  ;getting ASCII numerical value of choice2

        cinvoke printf, "Wybierz liczbe 2:"
        cinvoke scanf,  "%X", num2 ;num2 input
        cinvoke printf, "num2 = %X%c", [num2], 10

        mov EAX, [choice2]
        cmp EAX, 0x2B ;comparing EAX and + ASCII value
        JE .add  ;jumping to add if true
        cmp EAX, 0x2D
        JE .sub  ;jump if equal
        cmp EAX, 0x2A
        JE .mul
        cmp EAX, 0x2B
        JNE .end0 ;jump if not equal

.add:
        mov EAX, [num1] ;move num1 value to EAX
        mov EBX, [num2] ;move num 2value to EBX
        add EAX, EBX    ;add EBX to EAX
        mov [sum], EAX  ;move EAX to sum Value
        cinvoke printf, "sum = %X%c", [sum],10 ;print sum, new line
        invoke getch ;wait for sign
        ret

.sub:
        mov EAX, [num1]
        mov EBX, [num2]
        sub EAX, EBX
        mov [sum], EAX
        cinvoke printf, "sum = %X%c", [sum],10
        invoke getch ;wait for sign
        ret

.mul:
        mov EAX, [num1]
        mov EBX, [num2]
        imul EAX, EBX
        mov [sum], EAX
        cinvoke printf, "sum = %X%c", [sum],10
        invoke getch ;wait for sign
        ret

.end0:
        ret 0  ;program end


section '.data' data readable writeable

choice dd 0x0 ;used before choice2
num1 dd 0x0  ;variable, variable type, variable size
num2 dd 0x0
sum  dd 0x0
choice2 dd ?

section '.idata' import data readable

library msvcrt, 'msvcrt.dll',kernel32,'kernel32.dll'
import msvcrt,printf,'printf',getch,'_getch',scanf,'scanf'