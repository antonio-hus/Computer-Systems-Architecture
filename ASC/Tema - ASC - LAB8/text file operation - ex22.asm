; Laboratory 8 - Text File Operation - Exercise 7

; A file name and a decimal number (on 16 bits) are given (the decimal number is in the unsigned interpretation). 
; Create a file with the given name and write each digit composing the number on a different line to file.

bits 32 
global start        

extern exit, fprintf, fopen, fclose
import exit msvcrt.dll
import fprintf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll

segment data use32 class=data

    file_name db "createdfile.txt", 0
    file_descriptor dd -1   
    access_mode db "w", 0
    
    ten equ 10
    given_number dw 0x3C5B ; Decimal for 15.451 - fits on 16 bits
    
    format dw `%d \n`, 0 ; using backticks ` to allow the assembler to view \n as eof - NASM Documentation
    
segment code use32 class=code
    start:
    
        ; Creating a file using fopen()
        ; EAX = fopen(file_name, access_mode) - EAX = file descriptor
        push dword access_mode
        push dword file_name
        call [fopen]
        add esp, 4*2
        
        ; Check if the file was created successfully - EAX != 0
        cmp EAX, 0
        je final
        
            ; Saving the file descriptor to free EAX for later computations
            mov dword[file_descriptor], EAX
        
            ; Writing in the file
            
            ; Pseudocode for the code section below
            ; if given_number > 0
            ; do 
            ;   digit = given_number % 10
            ;   given_number = given_number / 10
            ;   write(digit)
            ; until given_number == 0
            
            ; skip if given_number is 0
            mov AX, word[given_number]
            cmp AX, 0
            je cleanup
        
            get_digits_loop:
                
                ; quotient in AX, remainder in DX
                ; free DX for the operation
                mov DX, 0
                mov BX, ten
                div BX
                
                PUSHAD
                
                ; Printing the remainder DX ( exteneded to EDX )
                ; printf(file descriptor, format, number)
                push dword EDX
                push dword format
                push dword [file_descriptor]
                call [fprintf] 
                add esp, 4*3
                
                POPAD
                
                ; Exiting the loop when the quotient becomes 0
                cmp AX, 0
                je cleanup
                
            jmp get_digits_loop
                
            ; Closing the file
            ; fclose(file_descriptor)
            cleanup:
            
            push dword[file_descriptor]
            call [fclose]
            add esp, 4
        
        final:
        push    dword 0      
        call    [exit]       
