 format PE console
include 'win32ax.inc'

section '.code' code readable executable

start:
        cinvoke printf, "Wybierz liczbe 1:"
        cinvoke scanf,  "%s", num1
        cinvoke printf, "num1 = %s%c", num1, 10

        cinvoke printf, "Wybierz operacje arytmetyczna!%c", 10
        cinvoke printf, "1.+ 2.- 3.* 4./ "
        cinvoke scanf,  "%s", choice2

        mov EAX, [choice2]
        cmp EAX, 0x2F
        JE .wprowadzanie2
        JNE .wprowadzanie1


        .wprowadzanie1:
        cinvoke printf, "Wybierz liczbe 2:"
        cinvoke scanf,  "%s", num2
        cinvoke printf, "num2 = %s%c", num2, 10
        jmp .kontynuj

        .wprowadzanie2:
        cinvoke printf, "Wybierz liczbe 2:"
        cinvoke scanf,  "%X", num2
        cinvoke printf, "num2 = %X%c", [num2], 10
        jmp .kontynuj

        .kontynuj:
        mov esi, num1

        mov EAX, [choice2]
        cmp EAX, 0x2B
        JE .Operacjadodawania
        cmp EAX, 0x2D
        JE .Operacjaodejmowania
        cmp EAX, 0x2A
        JE .Operacjamnozenia
        cmp EAX, 0x2F
        JE .Operacjadzielenia
        cmp EAX, 0x2B
        JNE .end0

.Operacjadodawania:

 .zliczanie1:
        mov eax, 0
        mov al, [esi]
        cmp al, 0
        JZ .rozkladliczby1
        inc esi
        jmp .zliczanie1

 .rozkladliczby1:
        mov eax, 0
        dec esi
        sub esi, num1
        mov [num1size], esi
        add esi, num1
        mov al, [esi]
        cmp al, 0x39
        JA .asciiDInt
        sub al, 0x30
        cmp [zmiennaTymczasowa], 1
        JZ .zapisliczby2
        jmp .zapisliczby1

  .rozkladliczby1_2:
        dec esi
        mov al, [esi]
        cmp al, 0x39
        JA .asciiDInt
        sub al, 0x30
        cmp [zmiennaTymczasowa], 1
        JZ .zapisliczby2
        jmp .zapisliczby1

 .asciiDInt:
        cmp al, 0x46
        JA .asciiMInt
        sub al, 0x37
        cmp [zmiennaTymczasowa], 1
        JZ .zapisliczby2
        jmp .zapisliczby1

 .asciiMInt:
        sub al, 0x57
        cmp [zmiennaTymczasowa], 1
        JZ .zapisliczby2
        jmp .zapisliczby1

 .zapisliczby1:
        mov [zmiennaTymczasowa], 1

        mov edi, num1_2
        add edi, 0
        mov [edi], al

        inc edi

        mov eax, 0
        jmp .rozkladliczby1_2

 .zapisliczby2:


        mov [edi], al
        sub edi, num1_2
        cmp edi, [num1size]
        JAE .wyniktymczasowy

        add edi, num1_2
        inc edi
        mov eax, 0
        jmp .rozkladliczby1_2

 .wyniktymczasowy:
         mov eax, 0
         mov esi, 0
         mov edi, 0
         mov ebx, 0

         mov [zmiennaTymczasowa],0
         ;cinvoke printf, "num1_2 = %X%c", [num1_2], 10
         ;invoke getch
         mov eax, 0
         mov esi, num2
         jmp .zliczanie2




 .zliczanie2:
        mov eax, 0
        mov al, [esi]
        cmp al, 0
        JZ .rozkladliczby2
        inc esi
        jmp .zliczanie2

.rozkladliczby2:
        mov eax, 0
        dec esi
        sub esi, num2
        mov [num2size], esi
        add esi, num2
        mov al, [esi]
        cmp al, 0x39
        JA .asciiDInt2
        sub al, 0x30
        cmp [zmiennaTymczasowa], 1
        JZ .zapisliczby22
        jmp .zapisliczby21

  .rozkladliczby2_2:
        dec esi
        mov al, [esi]
        cmp al, 0x39
        JA .asciiDInt2
        sub al, 0x30
        cmp [zmiennaTymczasowa], 1
        JZ .zapisliczby22
        jmp .zapisliczby21

 .asciiDInt2:
        cmp al, 0x46
        JA .asciiMInt2
        sub al, 0x37
        cmp [zmiennaTymczasowa], 1
        JZ .zapisliczby22
        jmp .zapisliczby21

 .asciiMInt2:
        sub al, 0x57
        cmp [zmiennaTymczasowa], 1
        JZ .zapisliczby22
        jmp .zapisliczby21


 .zapisliczby21:
        mov [zmiennaTymczasowa], 1

        mov edi, num2_2
        add edi, 0
        mov [edi], al
        inc edi

        mov eax, 0
        jmp .rozkladliczby2_2

 .zapisliczby22:

        mov [edi], al
        sub edi, num2_2
        cmp edi, [num2size]
        JAE .wyniktymczasowy2

        add edi, num2_2
        inc edi
        mov eax, 0
        jmp .rozkladliczby2_2

 .wyniktymczasowy2:
         mov eax, 0
         mov esi, 0
         mov edi, 0
         mov ebx, 0

         mov [zmiennaTymczasowa],0
         ;cinvoke printf, "num2_2 = %X%c", [num2_2], 10
         ;invoke getch
         mov eax, 0
         mov esi, num1_2  ; to do pobieranie
         mov edi, num2_2
         jmp .pobieranie


 .pobieranie:
         mov al, [esi]
         inc esi
         mov bl, [edi]
         inc edi

         jmp .dodawanie


 .dodawanie:
         add eax, [przeniesienie]
         mov [przeniesienie], 0x0
         add eax, ebx

         cmp eax, 0xF
         JA .dodawanie2

         jmp .konwersja1

 .dodawanie2:
         sub eax, 0x10
         mov [przeniesienie], 0x1
         jmp .konwersja1

 .konwersja1:
         cmp al, 0x09
         JA .konwersja2
         add al, 0x30
         cmp [zmiennaTymczasowa2], 1
         JE .zapis2
         jmp .zapis1

 .konwersja2:
         add al, 0x37
         cmp [zmiennaTymczasowa2], 1
         JE .zapis2
         jmp .zapis1

 .zapis1:
        mov [zmiennaTymczasowa2], 1
        mov ebx, 0
        mov edx, 0
        mov ebx, [num1size]
        mov edx, [num2size]
        cmp ebx, edx
        JAE .obliczsume1
        JB .obliczsume2

 .obliczsume1:
        mov [sumaSize], ebx
        jmp .zapis1_2

 .obliczsume2:
        mov [sumaSize], edx
        jmp .zapis1_2

 .zapis1_2:
        mov ecx, suma
        add ecx, [sumaSize]
        add ecx, 1
        mov [ecx], al
        dec ecx


        mov eax, 0
        mov ebx, 0
        mov edx, 0
        jmp .pobieranie

 .zapis2:
        mov [ecx], al

        sub ecx, suma
        cmp ecx, 0
        JE .wynik
        add ecx, suma
        dec ecx
        mov eax, 0
        mov ebx, 0
        jmp .pobieranie


 .wynik:
        cinvoke printf, "suma = %s%c", suma, 10
        invoke getch
        mov eax, 0
        mov ebx, 0
        mov ecx, 0
        mov edx, 0
        mov esi, 0
        mov edi, 0
        jmp .end0
;-----------------------------------------------------------------------------------odejmowanie-------------------------------------
 .Operacjaodejmowania:

    .zliczanie1o:
        mov eax, 0
        mov al, [esi]
        cmp al, 0
        JZ .rozkladliczby1o
        inc esi
        jmp .zliczanie1o

 .rozkladliczby1o:
        mov eax, 0
        dec esi
        sub esi, num1
        mov [num1size], esi
        add esi, num1
        mov al, [esi]
        cmp al, 0x39
        JA .asciiDInto
        sub al, 0x30
        cmp [zmiennaTymczasowa], 1
        JZ .zapisliczby2o
        jmp .zapisliczby1o

  .rozkladliczby1_2o:
        dec esi
        mov al, [esi]
        cmp al, 0x39
        JA .asciiDInto
        sub al, 0x30
        cmp [zmiennaTymczasowa], 1
        JZ .zapisliczby2o
        jmp .zapisliczby1o

 .asciiDInto:
        cmp al, 0x46
        JA .asciiMInto
        sub al, 0x37
        cmp [zmiennaTymczasowa], 1
        JZ .zapisliczby2o
        jmp .zapisliczby1o

 .asciiMInto:
        sub al, 0x57
        cmp [zmiennaTymczasowa], 1
        JZ .zapisliczby2o
        jmp .zapisliczby1o

 .zapisliczby1o:
        mov [zmiennaTymczasowa], 1

        mov edi, num1_2
        add edi, 0
        mov [edi], al

        inc edi

        mov eax, 0
        jmp .rozkladliczby1_2o

 .zapisliczby2o:


        mov [edi], al
        sub edi, num1_2
        cmp edi, [num1size]
        JAE .wyniktymczasowyo

        add edi, num1_2
        inc edi
        mov eax, 0
        jmp .rozkladliczby1_2o

 .wyniktymczasowyo:
         mov eax, 0
         mov esi, 0
         mov edi, 0
         mov ebx, 0

         mov [zmiennaTymczasowa],0
        ; cinvoke printf, "num1_2 = %X%c", [num1_2], 10
        ; invoke getch
         mov eax, 0
         mov esi, num2
         jmp .zliczanie2o




 .zliczanie2o:
        mov eax, 0
        mov al, [esi]
        cmp al, 0
        JZ .rozkladliczby2o
        inc esi
        jmp .zliczanie2o

.rozkladliczby2o:
        mov eax, 0
        dec esi
        sub esi, num2
        mov [num2size], esi
        add esi, num2
        mov al, [esi]
        cmp al, 0x39
        JA .asciiDInt2o
        sub al, 0x30
        cmp [zmiennaTymczasowa], 1
        JZ .zapisliczby22o
        jmp .zapisliczby21o

  .rozkladliczby2_2o:
        dec esi
        mov al, [esi]
        cmp al, 0x39
        JA .asciiDInt2o
        sub al, 0x30
        cmp [zmiennaTymczasowa], 1
        JZ .zapisliczby22o
        jmp .zapisliczby21o

 .asciiDInt2o:
        cmp al, 0x46
        JA .asciiMInt2o
        sub al, 0x37
        cmp [zmiennaTymczasowa], 1
        JZ .zapisliczby22o
        jmp .zapisliczby21o

 .asciiMInt2o:
        sub al, 0x57
        cmp [zmiennaTymczasowa], 1
        JZ .zapisliczby22o
        jmp .zapisliczby21o


 .zapisliczby21o:
        mov [zmiennaTymczasowa], 1

        mov edi, num2_2
        add edi, 0
        mov [edi], al
        inc edi

        mov eax, 0
        jmp .rozkladliczby2_2o

 .zapisliczby22o:

        mov [edi], al
        sub edi, num2_2
        cmp edi, [num2size]
        JAE .wyniktymczasowy2o

        add edi, num2_2
        inc edi
        mov eax, 0
        jmp .rozkladliczby2_2o

 .wyniktymczasowy2o:
         mov eax, 0
         mov esi, 0
         mov edi, 0
         mov ebx, 0

         mov [zmiennaTymczasowa],0
       ;  cinvoke printf, "num2_2 = %X%c", [num2_2], 10
       ;  invoke getch
         mov eax, 0
         mov esi, num1_2  ; to do pobieranie
         mov edi, num2_2
         jmp .pobieranieo


 .pobieranieo:
         mov al, [esi]
         inc esi
         mov bl, [edi]
         inc edi

         jmp .dodawanieo


 .dodawanieo:
         cmp eax, [przeniesienie]
         JB .dodawanie3o
         sub  eax, [przeniesienie]
         mov [przeniesienie], 0x0


         cmp eax, ebx
         JB .dodawanie2o
         sub eax, ebx

         jmp .konwersja1o

 .dodawanie3o:
         add eax, 0x10
         sub  eax, [przeniesienie]
         sub eax, ebx
         mov [przeniesienie], 0x1
         jmp .konwersja1o

 .dodawanie2o:
         add eax, 0x10
         sub eax, ebx
         mov [przeniesienie], 0x1
         jmp .konwersja1o

 .konwersja1o:
         cmp al, 0x09
         JA .konwersja2o
         add al, 0x30
         cmp [zmiennaTymczasowa2], 1
         JE .zapis2o
         jmp .zapis1o

 .konwersja2o:
         add al, 0x37
         cmp [zmiennaTymczasowa2], 1
         JE .zapis2o
         jmp .zapis1o

 .zapis1o:
        mov [zmiennaTymczasowa2], 1
        mov ebx, 0
        mov edx, 0
        mov ebx, [num1size]
        mov edx, [num2size]
        cmp ebx, edx
        JAE .obliczsume1o
        JB .obliczsume2o

 .obliczsume1o:
        mov [sumaSize], ebx
        jmp .zapis1_2o

 .obliczsume2o:
        mov [sumaSize], edx
        jmp .zapis1_2o

 .zapis1_2o:
        mov ecx, suma
        add ecx, [sumaSize]
        mov [ecx], al
        dec ecx


        mov eax, 0
        mov ebx, 0
        mov edx, 0
        jmp .pobieranieo

 .zapis2o:
        mov [ecx], al

        sub ecx, suma
        cmp ecx, 0
        JE .wyniko
        add ecx, suma
        dec ecx
        mov eax, 0
        mov ebx, 0
        jmp .pobieranieo


 .wyniko:
        cinvoke printf, "suma = %s%c", suma, 10
        invoke getch
        mov eax, 0
        mov ebx, 0
        mov ecx, 0
        mov edx, 0
        mov esi, 0
        mov edi, 0
        jmp .end0
 ;-------------------------------------------------------------------------------mnozenie------------------------------------------------------------
 .Operacjamnozenia:

 .zliczanie1m:
        mov eax, 0
        mov al, [esi]
        cmp al, 0
        JZ .rozkladliczby1m
        inc esi
        jmp .zliczanie1m

 .rozkladliczby1m:
        mov eax, 0
        dec esi
        sub esi, num1
        mov [num1size], esi
        add esi, num1
        mov al, [esi]
        cmp al, 0x39
        JA .asciiDIntm
        sub al, 0x30
        cmp [zmiennaTymczasowa], 1
        JZ .zapisliczby2m
        jmp .zapisliczby1m

  .rozkladliczby1_2m:
        dec esi
        mov al, [esi]
        cmp al, 0x39
        JA .asciiDIntm
        sub al, 0x30
        cmp [zmiennaTymczasowa], 1
        JZ .zapisliczby2m
        jmp .zapisliczby1m

 .asciiDIntm:
        cmp al, 0x46
        JA .asciiMIntm
        sub al, 0x37
        cmp [zmiennaTymczasowa], 1
        JZ .zapisliczby2m
        jmp .zapisliczby1m

 .asciiMIntm:
        sub al, 0x57
        cmp [zmiennaTymczasowa], 1
        JZ .zapisliczby2m
        jmp .zapisliczby1m

 .zapisliczby1m:
        mov [zmiennaTymczasowa], 1

        mov edi, num1_2
        add edi, 0
        mov [edi], al

        inc edi

        mov eax, 0
        jmp .rozkladliczby1_2m

 .zapisliczby2m:

        mov [edi], al
        sub edi, num1_2
        cmp edi, [num1size]
        JAE .wyniktymczasowym

        add edi, num1_2
        inc edi
        mov eax, 0
        jmp .rozkladliczby1_2m

 .wyniktymczasowym:
         mov eax, 0
         mov esi, 0
         mov edi, 0
         mov ebx, 0

         mov [zmiennaTymczasowa],0
         mov eax, 0
         mov esi, num2
         jmp .zliczanie2m

 .zliczanie2m:
        mov eax, 0
        mov al, [esi]
        cmp al, 0
        JZ .rozkladliczby2m
        inc esi
        jmp .zliczanie2m

.rozkladliczby2m:
        mov eax, 0
        dec esi
        sub esi, num2
        mov [num2size], esi
        add esi, num2
        mov al, [esi]
        cmp al, 0x39
        JA .asciiDInt2m
        sub al, 0x30
        cmp [zmiennaTymczasowa], 1
        JZ .zapisliczby22m
        jmp .zapisliczby21m

  .rozkladliczby2_2m:
        dec esi
        mov al, [esi]
        cmp al, 0x39
        JA .asciiDInt2m
        sub al, 0x30
        cmp [zmiennaTymczasowa], 1
        JZ .zapisliczby22m
        jmp .zapisliczby21m

 .asciiDInt2m:
        cmp al, 0x46
        JA .asciiMInt2m
        sub al, 0x37
        cmp [zmiennaTymczasowa], 1
        JZ .zapisliczby22m
        jmp .zapisliczby21m

 .asciiMInt2m:
        sub al, 0x57
        cmp [zmiennaTymczasowa], 1
        JZ .zapisliczby22m
        jmp .zapisliczby21m


 .zapisliczby21m:
        mov [zmiennaTymczasowa], 1

        mov edi, num2_2
        add edi, 0
        mov [edi], al
        inc edi

        mov eax, 0
        jmp .rozkladliczby2_2m

 .zapisliczby22m:

        mov [edi], al
        sub edi, num2_2
        cmp edi, [num2size]
        JAE .wyniktymczasowy2m

        add edi, num2_2
        inc edi
        mov eax, 0
        jmp .rozkladliczby2_2m

 .wyniktymczasowy2m:
         mov eax, 0
         mov esi, 0
         mov edi, 0
         mov ebx, 0

         mov [zmiennaTymczasowa],0
         mov eax, 0
         mov esi, num1_2
         mov edi, num2_2
         jmp .pobieraniem


;----------------------------------------------------mnozenie------------------------------------------------------------------

 .pobieraniem:

         sub esi, num1_2
         cmp esi, [num1size]
         JA .pobieranie2m
         add esi, num1_2

         mov al, [esi]
         inc esi
         mov bl, [edi]

         jmp .dodawaniem

 .pobieranie2m:
         mov esi, num1_2
         inc edi
         jmp .dodawaniem

 .dodawaniem:

         imul eax, ebx
         add eax, [przeniesienie]
         mov [przeniesienie], 0

 .dodawanie2m:
         cmp  eax, 0x0F
         JA .liczprzeniesienie

         cmp [zmiennaTymczasowa], 1
         JE .zapis1m
         jmp .petla

 .liczprzeniesienie:
         sub eax, 0x10
         add [przeniesienie], 0x1
         jmp .dodawanie2m

 .petla:
         mov ecx, [num1size]
         add ecx, 1
         mov [sumaSize], ecx
         mov [zmiennaTymczasowa], 1
         mov ecx, 0
         mov edx, 0

         mov edx, sumapomocnicza


         jmp  .zapis1m

 .zapis1m:
         add [edx], al
         inc edx


         mov ebx, [przeniesienie]
         mov [przeniesienie], 0
         add [edx], ebx


         sub edx, sumapomocnicza
         cmp edx, [sumaSize]
         JA .zapis2m
         add edx, sumapomocnicza

         mov eax, 0
         mov ebx, 0
         jmp .pobieraniem

  .zapis2m:
         mov edx, sumapomocnicza

         jmp .zapis3m

  .zapis3m:
         inc ecx
         add edx, ecx
         add [sumaSize], ecx

         sub edi, num2_2
         cmp edi, [num2size]
         JA .pobieranie3m
         add edi, num2_2
         jmp .pobieraniem

  .pobieranie3m:
         mov eax, 0
         mov ebx, 0
         mov ecx, 0
         mov edx, 0
         mov edi, 0
         mov esi, 0
         mov [zmiennaTymczasowa], 0
         mov [zmiennaTymczasowa2], 0
         mov [przeniesienie], 0
         mov esi, sumapomocnicza
         mov edi, suma
         jmp .pobieranie4m

 .pobieranie4m:
         ;ten kod moze musi byc w tym miejscu mozliwe ze wczesniej tez trzeba przerzucic

         mov al, [esi]

         add eax, [przeniesienie]
         mov [przeniesienie], 0 ;ten kod
         jmp .pobieranie5m

  .sprawdzenie:
         sub esi, sumapomocnicza
         cmp esi, [sumaSize]
         JA .sumatostring
         add esi, sumapomocnicza
         jmp .pobieranie4m


 .pobieranie5m:
         cmp eax, 0x0F
         JA .zapisdosumy2m
         inc esi
         jmp .zapisdosumy1m

 .zapisdosumy1m:

         add [edi], al
         inc edi

         jmp .sprawdzenie

 .zapisdosumy2m:
         sub eax, 0x10
         add [przeniesienie], 0x1
         jmp .pobieranie5m

 .sumatostring:
         mov eax, 0
         mov ebx, 0
         mov ecx, 0
         mov edx, 0
         mov edi, 0
         mov esi, 0
         mov [zmiennaTymczasowa], 0
         mov [zmiennaTymczasowa2], 0
         mov [przeniesienie], 0
         mov esi, suma
         mov edi, suma2
         add edi, [sumaSize]
         jmp .pobieranie6m

  .pobieranie6m:
         sub esi, suma
         cmp esi, [sumaSize]
         JA .wynikm
         add esi, suma
         mov al, [esi]
         inc esi
         jmp .konwersja1m

 .konwersja1m:
         cmp al, 0x09
         JA .konwersja2m
         add al, 0x30
         jmp .zapisdosumy3m

 .konwersja2m:
         add al, 0x37
         jmp .zapisdosumy3m

 .zapisdosumy3m:
         mov [edi], al
         dec edi
         mov eax, 0
         jmp .pobieranie6m

 .wynikm:
        cinvoke printf, "suma = %s%c", suma2, 10
        invoke getch
        mov eax, 0
        mov ebx, 0
        mov ecx, 0
        mov edx, 0
        mov esi, 0
        mov edi, 0
        jmp .end0
 ;---------------------------------------------------------dzielenie---------------------------------------
 .Operacjadzielenia:

 .zliczanie1d:
        mov eax, 0
        mov al, [esi]
        cmp al, 0
        JZ .rozkladliczby1d
        inc esi
        jmp .zliczanie1d

 .rozkladliczby1d:
        mov eax, 0
        dec esi
        sub esi, num1
        mov [num1size], esi
        add esi, num1
        mov al, [esi]
        cmp al, 0x39
        JA .asciiDIntd
        sub al, 0x30
        cmp [zmiennaTymczasowa], 1
        JZ .zapisliczby2d
        jmp .zapisliczby1d

  .rozkladliczby1_2d:
        dec esi
        mov al, [esi]
        cmp al, 0x39
        JA .asciiDIntd
        sub al, 0x30
        cmp [zmiennaTymczasowa], 1
        JZ .zapisliczby2d
        jmp .zapisliczby1d

 .asciiDIntd:
        cmp al, 0x46
        JA .asciiMIntd
        sub al, 0x37
        cmp [zmiennaTymczasowa], 1
        JZ .zapisliczby2d
        jmp .zapisliczby1d

 .asciiMIntd:
        sub al, 0x57
        cmp [zmiennaTymczasowa], 1
        JZ .zapisliczby2d
        jmp .zapisliczby1d

 .zapisliczby1d:
        mov [zmiennaTymczasowa], 1

        mov edi, num1_2
        add edi, 0
        mov [edi], al

        inc edi

        mov eax, 0
        jmp .rozkladliczby1_2d

 .zapisliczby2d:

        mov [edi], al
        sub edi, num1_2
        cmp edi, [num1size]
        JAE .wyniktymczasowyd

        add edi, num1_2
        inc edi
        mov eax, 0
        jmp .rozkladliczby1_2d

 .wyniktymczasowyd:
         mov eax, 0
         mov esi, 0
         mov edi, 0
         mov ebx, 0
         mov ecx, 0
         ;przypisanie potrzebnych do dizelenia zmeinnych do rejestrów
         mov edx, [num1size]
         dec edx
         mov [num2size], edx

         mov edx, 0
         mov [zmiennaTymczasowa],0

         mov esi, num1_2  ;zapisujemy adres esi
         add esi, [num1size]

         ;przeniesienie liczby 1 i 2 do rejestru
         mov al, [esi]
         mov ebx, [num2]
         mov edi, suma



 .pobieranied:
         cmp eax, ebx
         JAE .operacja2d  ; Sprawdzenie, tak --> op2, nie --> op1
         JB .operacja1d

 ;inkrementacja liczby1 do czasu pierwszego dizelneia
 .operacja1d:
         sub esi, num1_2
         cmp esi, 0
         JBE .konwersjad
         add esi, num1_2

         imul eax, 0x10
         dec esi
         add al, [esi]


         jmp .pobieranie3d

 ;sprawdzanie liczby mo¿liwy zapis 0
 .pobieranie3d:

         cmp eax, ebx
         JAE .operacja2d  ; Sprawdzenie, tak --> op2, nie --> op1

         cmp [zmiennaTymczasowa], 1
         JE .operacja3d
         JNE .operacja1d

 ;zapis zer w wyniku
 .operacja3d:
         inc edi
         sub esi, num1_2
         cmp esi, 0
         JBE .konwersjad
         add esi, num1_2

         imul eax, 0x10
         dec esi
         add al, [esi]
         mov edx, 0
         mov [edi], ecx
         mov edx, 0


         jmp .pobieranie3d

;zapis wyniku bez 0
.operacja2d:
         mov edx, 0
         mov [zmiennaTymczasowa], 1
         cmp eax, ebx
         JB .przesuniecied

         sub eax, ebx
         inc ecx
         jmp .operacja2d

 .przesuniecied:
         mov [edi], ecx
         mov ecx, 0
         inc edi
         jmp .pobieranie2d


 .pobieranie2d:

         sub esi, num1_2
         cmp esi, 0
         JBE .konwersjad
         add esi, num1_2

         cmp eax, ebx
         JAE .operacja2d
         JB .operacja1d

;przejscie do konewrjsi na ascii i zapisu wyniku wynik trzeba odwróciæ
.konwersjad:
        mov [reszta], eax
        sub edi, suma
        mov [sumaSize], edi
        add edi, suma
        cinvoke printf, "reszta = %X%c", [reszta], 10
        jmp .wynikd


.wynikd:
         mov esi, 0
         mov edi, 0
         mov ebx, 0
         mov ecx, 0
         mov edx, 0
         mov [zmiennaTymczasowa], 0
         mov edi, suma



 .wynik2d:
         sub edi, suma
         cmp edi, [sumaSize]
         JE .wynik3d
         add edi, suma
         mov al, [edi]
         inc edi
         jmp .konwersja1d

 .konwersja1d:
         cmp al, 0x09
         JA .konwersja2d
         add al, 0x30
         cmp [zmiennaTymczasowa], 1
         JE .zapis2d
         jmp .zapis1d

 .konwersja2d:
         add al, 0x37
         cmp [zmiennaTymczasowa], 1
         JE .zapis2d
         jmp .zapis1d

 .zapis1d:
        mov [zmiennaTymczasowa], 1
        mov esi, suma2
        mov [esi], al
        inc esi
        jmp .wynik2d


 .zapis2d:
        mov [esi], al
        inc esi
        jmp .wynik2d

 .wynik3d:
        cinvoke printf, "iloraz = %s%c", suma2, 10
        invoke getch

 .end0:
        ret 0

section '.data' data readable writeable
num1 dd 200 dup (?)
num1_2 dd 200 dup (?)
num2 dd 200 dup (?)
num2_2 dd 200 dup (?)
choice2 dd ?
num1size dd ?
num2size dd ?
suma dd 201 dup (?)
suma2 dd 201 dup (?)
sumapomocnicza dd 201 dup (?)
sumaSize dd ?
przeniesienie dd 0x0
przeniesienie2 dd 0x0
zmiennaTymczasowa dd 0x0
zmiennaTymczasowa2 dd 0x0
iloraz dd 0x0
reszta dd 0x0

section '.idata' import data readable

library msvcrt, 'msvcrt.dll',kernel32,'kernel32.dll'
import msvcrt,printf,'printf',getch,'_getch',scanf,'scanf'