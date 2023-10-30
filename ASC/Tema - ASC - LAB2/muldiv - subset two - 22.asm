; category: additions / subtractions | problem set: a,b,c,d-byte, e,f,g,h-word | problem: 7
bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a db 3
    b db 2
    c db 1

segment code use32 class=code
    start:
        
        ;(a+(b-c))*3
        
        ; BL = b-c = 2-1 = 1
        mov BL, [b]
        sub BL, [c]
        
        ; BL = a+BL = a+(b-c) = 3+1 = 4
        add BL, [a]
        
        ; AX = BL * 3 = 4*3 = 12 (C)
        mov AX, 0 
        mov AL, 3
        mul BL
        
        ; result in AX
        
        push    dword 0
        call    [exit]