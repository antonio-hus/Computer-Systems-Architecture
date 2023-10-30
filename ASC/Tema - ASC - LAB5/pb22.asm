; LAB 5 - Exercise 7 
; Two byte strings S1 and S2 of the same length are given. Obtain the string D where each element contains the minimum of the corresponding elements from S1 and S2

bits 32 
global start        

extern exit              
import exit msvcrt.dll    

segment data use32 class=data

    ; given strings
    s1 db '1', '3', '6', '2', '3', '7'
    l equ $-s1 ; s1 and s2 have the same length
    
    s2 db '6', '3', '8', '1', '2', '5'
    
    d times l db 0 ; d has the length of s1 / s2


segment code use32 class=code
    start:
        
        ; ecx - number of loops we will do
        mov ecx, l
        
        ; esi - index of element in the string
        mov esi, 0
        
        ; if length of strings != 0
        jecxz Ending
        Repeating:
        
            mov al, [s1+esi]
            mov bl, [s2+esi]
            
            cmp al, bl
            jb s1lower
            
                ; this part happens only when s2[esi] < s1[esi]
                mov [d+esi], bl
                
                ;jumps to the end
                jmp continue
            
            s1lower:
            
                ; this part happends only when s1[esi] < s2[esi]
                mov [d+esi], al
            
            continue:
            
            ; get to the next index in the loop
            inc esi
            
        loop Repeating
        Ending: 
        
        push    dword 0      
        call    [exit]       
