;Exercise 7 
; Given the words A and B, compute the doubleword C:
; the bits 0-4 of C have the value 1
; the bits 5-11 of C are the same as the bits 0-6 of A
; the bits 16-31 of C have the value 0000000001100101b
; the bits 12-15 of C are the same as the bits 8-11 of B

bits 32 
global start        

extern exit               
import exit msvcrt.dll    

segment data use32 class=data
    a dw 0111011101010111b
    b dw 1001101110111110b
    c dd 0

segment code use32 class=code
    start:
    
        ; result in EBX
        mov EBX, 0
        
        ; the bits 0-2 of C are the same as the bits 10-12 of B ( 110 from B goes to C => C: 0000000000000110b )
        mov AX, [b]
        and AX, 0001110000000000b
        mov CL, 10
        ror AX, CL
        or BX, AX
    
        ; the bits 5-11 of C are the same as the bits 0-6 of A ( 1010111 from A goes to C => C: 0000101011100110b )
        mov AX, [a]
        and AX, 0000000001111111b
        mov CL, 5
        rol AX, CL
        or BX, AX
        
        ; the bits 12-15 of C are the same as the bits 8-11 of B ( 1011 from B goes to C => C: 1011101011100110b )
        mov AX, [b]
        and AX, 0000111100000000b
        mov CL, 4
        rol AX, CL
        or BX, AX
        
        ; the bits 16-31 of C have the value 0000000001100101b ( C: 00000000011001011011101011100110b )
        mov EAX, 0000000001100101b
        mov CL, 16
        rol EAX, CL
        or EBX, EAX
        
        
        ; results in EBX and in C
        mov dword[c], EBX
        
        push    dword 0      
        call    [exit]       
