; category: additions / subtractions | problem set: a,b,c,d word | problem: 7

bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a dw 5
    b dw 2
    c dw 4
    d dw 6

segment code use32 class=code
    start:
        
        ;(c+c+c)-b+(d-a)
        ; we cant have to variable operands so we use the registry AX as an auxiliary for most of our operations
        
        ; c = c+c+c = 4+4+4 = 12 (0C)
        mov AX, [c]
        add AX, [c]
        add AX, [c]
        mov word [c], AX
        
        ; c = c - b = (c+c+c) - b =  12 (0C) - 2 = 10 (0A)
        mov AX, [c]
        sub AX, [b]
        mov word [c], AX
        
        ; d = d-a = 6-5 = 1
        mov AX, [d]
        sub AX, [a]
        mov word [d], AX
        
        ; a = c+d = (c+c+c)-b+(d-a) = 10(0A) + 1 = 11 (0B)
        mov AX, [c]
        add AX, [d]
        mov word [a], AX
 
        ;result is in a ( and also AX )
        
        push    dword 0
        call    [exit]