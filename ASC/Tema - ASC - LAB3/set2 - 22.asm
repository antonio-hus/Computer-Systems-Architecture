; Laboratory 3 Exercises | Multiplications, Divisions | Exercise 22

bits 32 
global start        

extern exit              
import exit msvcrt.dll    

;a,b,c-byte; e-doubleword; x-qword -- Signed
segment data use32 class=data
    a db -1
    b db -2
    c db -3
    e dd -4
    x dq -5
    
    tempb resb 1
    tempw resw 1
    tempw2 resw 1
    tempd resd 1
    tempd2 resd 1

segment code use32 class=code
    start:
        
        ; a/2+b*b-a*b*c+e+x
        
        ; tempb = a/2 = -1/2 = 0 rest -1 - AL = 0, AH = -1
        mov AL, [a]
        cbw
        
        mov BL, 2
        idiv BL
        
        mov byte[tempb], AL
        
        ; tempw = b*b = -2*-2 = 4
        mov AL, [b]
        cbw
        imul AL
        mov word[tempw], AX
        
        ; tempd = a*b*c = -1*-2*-3 = -6
        mov AL, [a]
        cbw
        
        ; a*b
        mov BL, [b]
        imul BL ; AX = AL*BL
        mov word[tempw2], AX
        
        ; tempd*c
        mov AL, [c]
        cbw
        cwde
        mov BX, [tempw2]
        imul BX
        
        mov dword[tempd], EAX
        
        ; EAX = tempb + tempw - tempd + [e] = a/2+b*b-a*b*c+e = 0 + 4 -  -6 + -4 = 6
        
        mov AL, [tempb]
        cbw
        cwde
        mov dword[tempd2], EAX
        
        mov AX, [tempw]
        cwde
        add EAX, [tempd2]
        
        sub EAX, [tempd]
        
        add EAX, [e]
        
        ; EDX:EAX = EDX:EAX + x = 6 + -5 = 1
        cdq
        
        mov EBX, [x+0]
        mov ECX, [x+4]
        
        clc
        add EAX, EBX
        adc EDX, ECX
        
        ; results in EDX:EAX
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
