; category: additions / subtractions | problem set: a,b,c,d byte | problem: 22

bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data

segment code use32 class=code
    start:
        
        ;(a+b+b)-(c+d)
        mov AL, 5 ; AL =a
        mov BL, 2 ; BL = b
        mov CL, 4 ; CL = c
        mov DL, 1 ; DL = d
        
        ; AL = a+b+b
        add AL,BL
        add AL,BL
        
        ; CL = c+d
        add CL,DL
        
        ; AL = AL-CL = (a+b+b)-(c+d)
        sub AL, CL
        
        ;result is in AL
        
        push    dword 0
        call    [exit]