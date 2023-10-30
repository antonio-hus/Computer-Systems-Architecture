; category: additions / subtractions | problem set: a,b,c,d-byte, e,f,g,h-word | problem: 7
bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a db 1
    b db 2
    c db 3
    d db 4

segment code use32 class=code
    start:
        
        ;(a+b)*(c+d)
        
        ; BL = a+b = 1+2 = 3
        mov BL, [a]
        add BL, [b]
        
        ; CL = c+d = 3+4 = 7
        mov CL, [c]
        add CL, [d]
        
        ; AX = BL * CL = 3*7 = 21
        mov AX, 0 
        mov AL, BL
        mul CL
        
        ; result in AX
        
        push    dword 0
        call    [exit]