; Laboratory 3 Exercises | Additions, subtractions | Subset One | Exercise 22

bits 32 
global start        

extern exit              
import exit msvcrt.dll    

;a - byte, b - word, c - double word, d - qword - Unsigned representation
segment data use32 class=data
    a db 2Fh
    b dw 4AE6h
    c dd 682D789h
    d dq 31C53294AEh

segment code use32 class=code
    start:
        
        ; (d+c) - (c+b) - (b+a)
        
        ; d - quadword - EDX:EAX => d = d+c
        mov EAX, dword[d+0]
        mov EDX, dword[d+4]
        
        mov EBX, [c]
        mov ECX, 0
        
        clc
        add EAX, EBX
        adc EDX, ECX
        
        mov dword[d+0], EAX
        mov dword[d+4], EDX
        
        ; c = c+b
        mov EAX, [c]
        mov EBX, 0 
        mov BX, [b]
        add EAX, EBX
        mov dword[c], EAX
        
        ; b = b+a
        mov AX, [b]
        mov BX, 0
        mov BL, [a]
        add AX, BX
        mov word[b], AX
        
        ; EDX:EAX
        mov EAX, dword[d+0]
        mov EDX, dword[d+4]
        
        mov EBX, [c]
        mov ECX, 0
        
        clc
        sub EAX, EBX
        sbb EDX, ECX
        
        mov EBX, 0
        mov BX, [b]
        mov ECX, 0
        
        clc
        sub EAX, EBX
        sbb EDX, ECX
        
        ; results in EDX:EAX
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
