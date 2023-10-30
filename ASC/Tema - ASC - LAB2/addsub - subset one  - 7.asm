; category: additions / subtractions | problem set: a,b,c,d byte | problem: 7

bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data

segment code use32 class=code
    start:
        
        ; c-(d+d+d)+(a-b)
        mov AL, 5 ; AL =a
        mov BL, 2 ; BL = b
        mov CL, 10 ; CL = c
        mov DL, 1 ; DL = d
        
        ;DH = d, DL = d+d+d ( we cant use DL=DL+DL twice because we would get d+d+d+d, so we need an auxiliary )
        mov DH, DL
        add DL, DH
        add DL, DH
        
        ;CL = c-(d+d+d)
        sub CL, DL
        
        ;AL = a-b
        sub AL, BL
        
        ;CL = CL + AL = c-(d+d+d)+(a-b)
        add CL, AL
        
        ;move result in AL
        mov AL, CL
        
        push    dword 0
        call    [exit]