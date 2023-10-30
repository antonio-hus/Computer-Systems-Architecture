; category: additions / subtractions | problem set: a,b,c,d byte | problem: 22

bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a db 5
    b db 2
    c db 4
    d db 1

segment code use32 class=code
    start:
        
        ;(a+b+b)-(c+d)
        ; we cant have to variable operands so we use the registry AL as an auxiliary for most of our operations
        
        ; a = a+b+b = 5+2+2 = 9
        mov AL, [a]
        add AL, [b]
        add AL, [b]
        mov byte [a], AL
        
        ; c = c+d = 4+1 = 5
        mov AL, [c]
        add AL, [d]
        mov byte [c], AL
        
        
        ; a = a-c = (a+b+b)-(c+d) = 9-5 = 4
        mov AL, [a]
        sub AL, [c]
        mov byte [a], AL
        
        ;result is in a ( and also AL )
        
        push    dword 0
        call    [exit]