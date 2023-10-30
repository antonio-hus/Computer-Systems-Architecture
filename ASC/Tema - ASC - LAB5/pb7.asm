; LAB 5 - Exercise 7 
; Two byte string S1 and S2 are given, having the same length. Obtain the string D by intercalating the elements of the two strings.

bits 32 
global start        

extern exit              
import exit msvcrt.dll    

segment data use32 class=data

    ; given strings
    s1 db '1', '3', '5', '7'
    l equ $-s1 ; s1 and s2 have the same length
    
    s2 db '2', '6', '9', '4'
    
    d times 2*l db 0 ; d has the length 2*l


segment code use32 class=code
    start:
        
        ; ecx - number of loops we will do
        mov ecx, l
        
        ; esi - index of element in s1 and s2, edi - index of element in d
        mov esi, 0
        mov edi, 0
        
        ; if length of strings != 0
        jecxz Ending
        Repeating:
        
            ; add term from s1 in d at position edi
            mov al, [s1+esi]
            mov [d+edi], al
            inc edi
            
            ; add term from s2 in d at position edi+1
            mov al, [s2+esi]
            mov [d+edi], al
            inc edi
            
            ; get to the next index in s1 / s2
            inc esi
            
        loop Repeating
        Ending: 
        
        push    dword 0      
        call    [exit]       
