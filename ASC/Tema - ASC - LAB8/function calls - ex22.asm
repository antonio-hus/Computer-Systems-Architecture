; Laboratory 8 - Function Calls - Exercise 22

; Two numbers a and b are given. 
; Compute the expression value: (a+b)*k, where k is a constant value defined in data segment. 
; Display the expression value (in base 10).

bits 32 
global start        

extern exit, printf, scanf               
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data
    a dd 0
    b dd 0
    k dd 5
    
    format dd "%d", 0
    print_format dd "%d%d", 0
    
segment code use32 class=code
    start:
    
        ; Read 'a' and 'b'
        push dword a
        push dword format
        call [scanf]
        add esp, 4*2
        
        push dword b
        push dword format
        call [scanf]
        add esp, 4*2
        
        ; Compute (a+b)*k - Result in EDX:EAX
        
        mov EAX, [a]
        add EAX, [b]
        mul dword[k]
        
        ; Display result- EDX:EAX - push in reverse order
        push EAX
        push EDX
        push dword print_format
        call [printf]
        add esp, 4*2
        
        push    dword 0      
        call    [exit]       
