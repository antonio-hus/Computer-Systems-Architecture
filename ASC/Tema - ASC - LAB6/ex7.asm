; Laboratory 6 - Exercise 7
; A string of doublewords is given
; Obtain the list made out of the high bytes of the high words of each doubleword from the given list 
; with the property that these bytes are multiple of 3

bits 32 
global start        

extern exit             
import exit msvcrt.dll

segment data use32 class=data

    ; input string 
    s DD 0x12345678, 0x1A2B3C4D, 0xFE98DC76
    len equ ($-s)/4
    
    ; data used for computations
    trei db 3
    
    ; output string
    d times len db 0

segment code use32 class=code
    start:
    
        ; initializing operands for working with strings - 
        ; esi - offset of source string, edi - constant for offset computations of destination string
        ; ecx - times to repeat, DF = 0 - parsing direction
        mov esi, s
        mov edi, 0
        mov ecx , len
        cld
        
        ; parsing our source string
        jecxz Ending
        Parcurgere:
        
            ; high doubleword in AX => high bytes in AH
            lodsw
            lodsw
            
            ; the part we are interested in is in AL now - and a copy in BL - used if we want to append it later
            mov AL, AH
            mov BL, AH
            mov AH, 0
            
            ; if multiple of three => add in destination string, else continue
            div byte[trei]
            cmp AH, 0
            
            jnz Notmultiple
            
                mov [d+edi], BL
                inc edi
            
            Notmultiple:
            
        loop Parcurgere
        Ending:
        
        push    dword 0      
        call    [exit]       
