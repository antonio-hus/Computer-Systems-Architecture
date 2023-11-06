; Laboratory 3 Exercises | Additions, subtractions | Subset Two | Exercise 22

bits 32 
global start        

extern exit              
import exit msvcrt.dll    

;a - byte, b - word, c - double word, d - qword - Signed representation
segment data use32 class=data
    a db 0xF4
    b dw 0xB2A9
    c dd 0x93EA624F
    d dq 0x207621ACD

segment code use32 class=code
    start:
        
        ; c+b-(a-d+b)
        
        ; c = c+b = -3-1 = -4
        mov ECX, [c]
        mov AX, [b]
        cwde
        add ECX, EAX
        mov dword[c], ECX
        
        ; d = a-d = -2 - -4 = 2
        mov AL, [a]
        cbw
        cwde
        cdq ; EDX:EAX
        
        mov EBX, [d+0]
        mov ECX, [d+4]
        
        clc
        sub EAX, EBX
        sbb EDX, ECX
        
        mov dword[d+0], EAX
        mov dword[d+4], EDX
        
        ; d = d+b = (a-d+b) = 2-1 = 1
        mov AX, [b]
        cwde
        cdq
        
        mov EBX, dword[d+0]
        mov ECX, dword[d+4]
        
        clc
        add EAX, EBX
        adc EDX, ECX
        
        mov dword[d+0], EAX
        mov dword[d+4], EDX
        
        ; EDX:EAX = c-d = c+b-(a-d+b) = -4 - 1 = -5
        mov EAX, [c]
        cdq
        
        mov EBX, dword[d+0]
        mov ECX, dword[d+4]
        
        clc
        sub EAX, EBX
        sbb EDX, ECX
        
        ; results in EDX:EAX
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
