; category: simple | problem: 7

bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    
segment code use32 class=code
    start:
        
        ; 256 / 1
        mov AX, 256 ; AL only stores up to 255
        mov BX, 1  
        div BX ; AX = AX / BX = 256 
        
        ; result in AX
        
        push    dword 0
        call    [exit]