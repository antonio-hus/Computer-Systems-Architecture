;Exercise 22
; Given the doubleword A and the word B, compute the word C as follows:
; the bits 0-4 of C are the invert of the bits 20-24 of A
; the bits 5-8 of C have the value 1
; the bits 9-12 of C are the same as the bits 12-15 of B
; the bits 13-15 of C are the same as the bits 7-9 of A

bits 32 
global start        

extern exit               
import exit msvcrt.dll    

segment data use32 class=data
    a dd 01011011001100010111011101010111b
    b dw 1001101110111110b
    c dw 0

segment code use32 class=code
    start:
    
        ; result in BX but we need
        mov EBX, 0
        
        ; the bits 0-4 of C are the invert of the bits 20-24 of A ( 10011 from A -> 01100 inverted -> 00000000000000000000000000001100b )
        mov EAX, [a]
        not EAX
        and EAX, 00000000111110000000000000000000b
        mov CL, 20
        ror EAX, CL
        or EBX, EAX
        
        ; the bits 5-8 of C have the value 1 ( 00000000000000000000000111101100b )
        or EBX, 00000000000000000000000111100000b
        
        ; the bits 9-12 of C are the same as the bits 12-15 of B ( from B: 1001 -> C: 00000000000000000001001111101100b )
        mov AX, [b]
        and AX, 1111000000000000b
        mov CL, 3
        ror AX, CL
        or BX, AX
        
        ; the bits 13-15 of C are the same as the bits 7-9 of A ( from A: 110 -> C: 00000000000000001101001111101100b )
        mov EAX, [a]
        and EAX, 00000000000000000000001110000000b
        mov CL, 6
        rol EAX, CL
        or EBX, EAX
        
        mov word[c], BX
        
        ; results in BX and C => C: 1101 0011 1110 1100b
        
        push    dword 0      
        call    [exit]       
