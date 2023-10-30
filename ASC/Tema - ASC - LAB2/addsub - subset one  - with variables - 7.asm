; category: additions / subtractions | problem set: a,b,c,d byte | problem: 7

bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a db 5
    b db 2
    c db 10
    d db 1

segment code use32 class=code
    start:
        
        ; c-(d+d+d)+(a-b)
        ; we cant have to variable operands so we use the registry AL as an auxiliary for most of our operations

        ; d = d+d+d = 1+1+1 = 3
        mov AL, [d]
        add AL, [d]
        add AL, [d]
        mov byte [d], AL
        
        ; c = c - (d+d+d) = 10(0A in 16) - 3 = 7
        mov AL, [c]
        sub AL, [d]
        mov byte [c], AL
        
        ; a = a-b = 5-2 = 3
        mov AL, [a]
        sub AL, [b]
        mov [a], AL
        
        ; a = c-(d+d+d)+(a-b) = 7 = 3 = 10 ( 0A in 16 )
        mov AL, [c]
        add AL, [a]
        mov byte [a], AL
        
        ;result is in a ( and also AL )
        
        push    dword 0
        call    [exit]