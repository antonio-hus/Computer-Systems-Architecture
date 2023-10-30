; category: simple | problem: 22

bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    
segment code use32 class=code
    start:
        
        ; 16 / 4
        mov AX, 16
        mov BL, 4 
        div BL 
        
        ; result in: quotient in AL, remainder in AH
        
        push    dword 0
        call    [exit]