
%ifndef _GET_HUNDREDS_DIGIT_ASM_ ; continue if _GET_HUNDREDS_DIGIT_ASM_ is undefined
%define _GET_HUNDREDS_DIGIT_ASM_ ; make sure that it is defined, otherwise, %include allows only one inclusion

; define our function
; get_hundreds_digit(dword EAX)
get_hundreds_digit:

    ; eax has the number we want.
    ; we want the hundreds digit in decimal => a/100%10
    
    ; EDX:EAX / 100, quotient in EAX
    mov edx, 0
    mov ebx, 100
    div ebx
    
    ; EDX:EAX / 10, remainder in EDX
    mov edx, 0
    mov ebx, 10
    div ebx
    
    ; remainder of %10 is in EDX => remainder of %10 is in DL
    ; return to call adress
    ret
    
%endif