; Laboratory 3 Exercises | Multiplications, Divisions | Exercise 7

bits 32 
global start        

extern exit              
import exit msvcrt.dll    

;a,b-byte; c-word; e-doubleword; x-qword -- Signed
segment data use32 class=data
    a db 0x73
    b db 0x61
    c dw 0xABCD
    e dd 0xABCDE
    x dq 0x12973912
    
    tempb resb 1
    tempd resd 1

segment code use32 class=code
    start:
        
        ; (a-2)/(b+c)+a*c+e-x
        
        ; tempb = a-2 = 5-2 = 3
        mov AL, [a]
        sub AL, 2
        mov byte[tempb], AL
        
        ; CX = b+c = 4+3 = 7
        mov AL, [b]
        cbw
        add AX, [c]
        mov CX, AX
        
        ; tempd = cwde(cbw(tempb))/CX = (a-2)/(b+c) = 3/7 = 0 rest 7
        mov AL,[tempb]  
        cbw
        cwde
        mov DX, 0
        idiv CX
        cwde
        mov dword[tempd], EAX
        
        ; EAX = a*c = 5*3 = 15
        mov AL, [a]
        cbw
        mov CX, [c]
        imul CX
        
        ; tempd = (a-2)/(b+c)+a*c+e = 0+15+2 = 17
        mov EBX, dword[tempd]
        add EBX, EAX
        add EBX, [e]
        mov dword[tempd], EBX
        
        ; EDX:EAX = cdq(tempd) - x = 17-1 = 16
        mov EAX, [tempd]
        cdq
        
        mov EBX, [x+0]
        mov ECX, [x+4]
        
        clc
        sub EAX, EBX
        sbb EDX, ECX
        
        ; results in EDX:EAX
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
