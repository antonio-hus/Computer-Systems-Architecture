; Laboratory 6 - Exercise 22
; A string of bytes 'input' is given together with two additional strings of N bytes each, 'src' and 'dst'. 
; Obtain a new string of bytes called 'output' from the 'input' string, 
; by replacing all the bytes with the value src[i] with the new value dst[i], for i=1..N.

bits 32 
global start        

extern exit             
import exit msvcrt.dll

segment data use32 class=data

    ; input strings
    input DB 0x12, 0x3A, 0x45, 0x29, 0xF7, 0x22, 0x70, 0x40
    len equ $-input
    
    src db 0x3A, 0x14, 0x22
    dst db 0x01, 0x02, 0x03
    len_N equ $-dst
    
    ; output string
    output times len db 0

segment code use32 class=code
    start:
    
        ; prepare parsing direction flag
        cld
        
        ; copy in output from input
        mov ecx, len
        mov esi, 0
        jecxz FinishCopy
        Again:
        
            mov BL, [input+esi]
            mov [output+esi], BL
            inc esi
        
        loop Again
        FinishCopy:
        
        ; prepare index for computations
        mov esi, 0
        
        ; prepare loop for parsing our input / output strings - dont run if len of strings is 0
        mov ecx , len
        jecxz Ending
        Parcurgere:
        
            ; save the value of ECX for maintaining the main loop in EDX
            mov EDX, ECX
        
            ; find the set of bytes in 'src'
            mov AL, [input+esi]
            mov edi, 0
            
            mov ECX, len_N
            jecxz FinishSearch
            FindinSrc:
                
                ; Compare the bytes from my string with the src[i] where i takes 1,2...N
                ; If found replace and jump to the end, else continue
                cmp AL, [src+edi]
                jne Continue
                
                    mov BL, [dst+edi]
                    mov [output+esi], BL
                    jmp FinishSearch
                
                Continue:
                
                ; next value from src[i]
                inc edi
                
            loop FindinSrc
            FinishSearch:
            
            ; return the value of ECX from EDX
            mov ECX, EDX
            
            ; next set of bytes from input / output string
            inc esi
        
        loop Parcurgere
        Ending:
        
        push    dword 0      
        call    [exit]       
