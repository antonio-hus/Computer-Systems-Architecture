; Laboratory 3 Exercises | Additions, subtractions | Subset Two | Exercise 7

bits 32 
global start        

extern exit              
import exit msvcrt.dll    

;a - byte, b - word, c - double word, d - qword - Signed representation
segment data use32 class=data
    a db -2
    b dw -1
    c dd -3
    d dq -12

segment code use32 class=code
    start:
        
        ; (c+c+c)-b+(d-a)
        
        ; ECX = c+c+c = -3-3-3 = -9
        mov ECX, [c]
        add ECX, [c]
        add ECX, [c]
        
        ; c = (c+c+c)-b = -9 - (-1) = -8
        mov AX, [b]
        cwde 
        sub ECX, EAX
        mov dword[c], ECX
        
        ; ECX:EBX = d-a = -12 - (-2) = -10
        mov EBX,[d+0]
        mov ECX,[d+4]
        
        mov AL, [a]
        cbw
        cwde
        cdq
        
        clc
        sub EBX, EAX
        sbb ECX, EDX
        
        ; EDX:EAX = c + ECX:EBX = (c+c+c)-b+(d-a) = -8 + -10 = -18
        mov EAX, [c]
        cdq
        
        clc
        add EAX, EBX
        adc EDX, ECX
        
        ; results in EDX:EAX
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
