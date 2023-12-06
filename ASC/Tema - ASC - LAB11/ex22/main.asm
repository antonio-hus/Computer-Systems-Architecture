; Exercise 22 | Lab 11 | Hus Lucian-Antonio, Group 914 IE

; Read a string of integers s1 (represented on doublewords) in base 10. 
; Determine and display the string s2 composed by the digits in the hundreds place of each integer in the string s1.
; Example:    The string s1: 5892, 456, 33, 7, 245
; The string s2: 8,    4,   0,  0, 2

bits 32
global start        

extern exit, scanf, printf
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll

; we need a get_hundreds_digit procedure => defined in file with the same name
%include "get_hundreds_digit.asm"

segment data use32 class=data

    reading_format dd "%d"
    printing_format db "%d, "
    
    number_read resd 1
    
    array times 100 db 0
    
segment code use32 class=code
    
    ; main function
    start:
        
        mov esi, 0
        
        parse_input:
        
            ; read doubleword in EAX
            push dword number_read
            push dword reading_format
            call [scanf]
            add esp, 4*2
            
            mov EAX, [number_read]
            
            ; if we read integer 0 => end of string => finish parsing
            cmp EAX, 0
            je finish_parsing     
            
            ; get_hundreds_digit in DL - function uses EAX as input implicitly
            mov DL, 0
            call get_hundreds_digit
            
            ; place it in the array
            mov byte[array+esi], DL
            inc ESI
        
        jmp parse_input
        finish_parsing:
        
        ; display array
        mov ECX, ESI
        mov ESI, 0 
        jecxz final
        display:
        
            ; saving ECX
            mov EDI, ECX
        
            mov EAX, 0
            mov AL, byte[array+esi]
            push dword EAX
            push dword printing_format
            call [printf]
            add esp, 4*2
            inc esi
            
            ; setting back ECX
            mov ECX, EDI
            
        loop display
        final:
        push    dword 0      
        call    [exit]       
