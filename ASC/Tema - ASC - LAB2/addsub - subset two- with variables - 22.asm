; category: additions / subtractions | problem set: a,b,c,d word | problem: 22

bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a dw 2
    b dw 9
    c dw 2
    d dw 3

segment code use32 class=code
    start:
        
        ;(b-a)-(c+c+d)
        ; we cant have to variable operands so we use the registry AX as an auxiliary for most of our operations
        
        ; b = b-a = 9-2 = 7
        mov AX, [b]
        sub AX, [a]
        mov word [b], AX
        
        ; c = c+c+d = 2+2+3 = 7
        mov AX, [c]
        add AX, [c]
        add AX, [d]
        mov word [c], AX
        
        ; a = b-c = (b-a)-(c+c+d) = 8-7 = 0
        mov AX, [b]
        sub AX, [c]
        mov word [a], AX
        
        
        ;result is in a ( and also AX )
        
        push    dword 0
        call    [exit]