; Laboratory 3 Exercises | Additions, subtractions | Subset One | Exercise 7

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
        
        ; c-(d+d+d)+(a-b) = 682D789h - 95 4F97 BE0A + B549 = FFFF FF6A B6EB CEC8
        
        ; d - quadword - EDX:EAX => d = d+d+d = 95 4F97 BE0A
        mov EAX, dword[d+0]
        mov EDX, dword[d+4]
        
        mov EBX, dword[d+0]
        mov ECX, dword[d+4]
        
        clc
        add EAX, EBX
        adc EDX, ECX
        
        clc
        add EAX, EBX
        adc EDX, ECX
        
        mov dword[d+0], EAX
        mov dword[d+4], EDX
        
        ; b = a-b
        mov EAX, 0
        mov AL, [a]
        sub AX, [b]
        mov word [b], AX
        
        ; EDX:EAX = c-d = c-(d+d+d)
        mov EAX, [c]
        mov EDX, 0
        
        mov EBX, dword[d+0]
        mov ECX, dword[d+4]
        
        clc
        sub EAX, EBX
        sbb EDX, ECX
        
        ; EDX:EAX = EDX:EAX + (a-b)
        ; EDX: EAX already in its place
        
        mov EBX, 0
        mov BX, [b]
        mov ECX, 0 
        
        clc
        add EAX, EBX
        adc EDX, ECX
        
        ; results in EDX:EAX =  FFFF FF6A : B6EB CEC8
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
