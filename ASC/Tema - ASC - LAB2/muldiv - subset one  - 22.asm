; category: additions / subtractions | problem set: a,b,c - bytes, d - word | problem: 22
bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a db 2
    b db 1
    c db 3
    d dw 4

segment code use32 class=code
    start:
        
        ;[(10+d)-(a*a-2*b)]/c
        
        ; d = 10+d = 10+4 = 14 (E)
        mov AX, 10
        add AX, [d]
        mov word[d], AX
        
        ; a = (a*a-2*b) = 2*2 - 2*1 = 4-2 = 2
        mov AL, [a]
        mul AL
        mov byte[a], AL
        
        mov AL, 2
        mov BL, [b]
        mul BL
        
        sub byte[a], AL
        
        ; AX = d-a = [(10+d)-(a*a-2*b)] = 14 - 2 = 12 (C)
        mov AX, [d]
        mov BX, [a]
        mov BH, 0
        sub AX, BX
        
        ; AX = AX / [c] = 12 / 3 = 4 remainder 0 ( quotient found in AL, remainder found in AH )
        mov CL, [c]
        div CL
        
        push    dword 0
        call    [exit]