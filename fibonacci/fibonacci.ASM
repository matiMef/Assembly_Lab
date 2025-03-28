format PE console 4.0
entry start

section '.code' code readable executable
  start:
    ; Define your stack frame
    push ebp
    mov ebp, esp

    ; Load the first argument into EAX
    mov eax, [ebp + 8]

    ; Call the Fibonacci function
    push eax
    call Fibonacci
    add esp, 4

    ; Output the result
    call PrintInt ; Assuming you have an output procedure to print integers

    ; Exit the program
    pop ebp
    ret

  Fibonacci:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    cmp eax, 1
    ja Recurse

    mov ecx, 1
    jmp Exit

  Recurse:
    dec eax
    mov edx, eax
    push eax
    call Fibonacci
    add esp, 4
    mov ebx, ecx
    dec edx
    push edx
    call Fibonacci
    add esp, 4
    add ecx, ebx

  Exit:
    mov eax, ecx
    pop ebp
    ret

section '.data' data readable writeable
  ; Data section where you can store variables if needed

section '.idata' import data readable
  ; Assuming you have a Windows import section with functions like WriteConsoleA
 PrintInt  dd 0, 0, 0, 0, 0  ; Import table must be here but might not need actual imports