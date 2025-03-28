.XMM
.model flat, c
.stack 4096

.data
    samples dword 0
    samplescount dword 0
    alpha dword 0
    timeDiff dword 0 

.code

option language: syscall

_addEchoASM proc
    enter 0, 0

    mov eax, [ebp+8]
    mov [samples], eax
    mov ebx, [ebp+12]
    mov [samplescount], ebx
    mov ecx, [ebp+16]
    mov [alpha], ecx
    mov edx, [ebp+20]
    mov [timeDiff], edx

    xor ebx, ebx
    xor eax, eax 
    xor ecx, ecx
    xor edx, edx
    mov eax, alpha 

    movd xmm2, esi
    shufps xmm2, xmm2, 0 
    xorps xmm0, xmm0
    xorps xmm3, xmm3

SampleLoop:
    cmp ebx, samplescount
    jae EndProc

    cmp ebx, timeDiff
    jb BacktoLoop

    mov edi, [samples]

    mov esi, ebx
    sub esi, timeDiff
    shl esi, 2

    movq mm2, qword ptr [edi + ebx * 4]
    movq mm3, qword ptr [edi + esi]

    cvtpi2ps xmm0, mm3
    cvtpi2ps xmm1, mm2

    mulps xmm1, xmm2
    addps xmm0, xmm1
    cvtps2pi mm2, xmm0

    movq qword ptr [edi + ebx * 4], mm2

BacktoLoop:
    add ebx, 2
    jmp SampleLoop

EndProc:
    leave
    ret

_addEchoASM endp

option language: c
end