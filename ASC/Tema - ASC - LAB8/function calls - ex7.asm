; Laboratory 8 - Function Calls - Exercise 7

; Two natural numbers a and b (a: dword, b: dword, defined in the data segment) are given. 
; Calculate a/b and display the remainder in the following format: "<a> mod <b> = <remainder>". 
; Example: for a = 23, b = 5 it will display: "23 mod 5 = 3".
; The values will be displayed in decimal format (base 10) with sign.

bits 32 
global start        

extern exit, printf               
import exit msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    a dd 23
    b dd 5
    
    message dw "%d mod %d = %d", 0 ; %d - decimal
    ; printf ("%d mod %d = %d", a, b, remainder)
    
segment code use32 class=code
    start:
    
        ; EDX:EAX / EBX => EDX - remainder
        mov EAX, [a]
        cdq
        
        mov EBX, [b]
        
        idiv EBX
        
        ; Push in reverse order a, b, remainder
        push EDX ; remainder
        push dword [b]
        push dword [a]
        push dword message
        call [printf]
        add esp, 4 * 4
        
        push    dword 0      
        call    [exit]       
