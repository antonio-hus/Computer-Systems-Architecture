; category: additions / subtractions | problem set: a,b,c - bytes, d - word | problem: 7
bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    d dw 1

segment code use32 class=code
    start:
        
        ;[100*(d+3)-10]/d
        
        ; DX = d+3 = 1+3 = 4
        mov DX, [d]
        add DX, 3
        
        ; AX = 100*DX-10 = (100*4)(190h) -10 = 390 (186h)
        mov AX, 100
        mul DX
        sub AX, 10
        
        ; AX = AX / d
        mov DX, [d] ; we use DX because we cannot div by a variable
        div DX
        
        mov word [d], DX
        
        ;result is in d ( and also AX )
        
        push    dword 0
        call    [exit]