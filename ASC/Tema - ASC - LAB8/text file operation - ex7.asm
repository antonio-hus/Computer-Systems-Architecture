; Laboratory 8 - Text File Operation - Exercise 7

; A text file is given. Read the content of the file, determine: 
; - the lowercase letter with the highest frequency 
; and display the letter along with its frequency on the screen. 
; The name of text file is defined in the data segment.

bits 32 
global start        

extern exit, printf, fopen, fread, fclose

import exit msvcrt.dll
import printf msvcrt.dll

import fopen msvcrt.dll
import fread msvcrt.dll
import fclose msvcrt.dll

segment data use32 class=data

    file_name db "file7.txt", 0
    file_descriptor dd -1
    
    access_mode db "r", 0
    character resb 1
    print_format db "The charachter with the max frequency in the file is %c, appearing %d times",0
    
    max_frequency db 0
    max_frequency_character db 0
    character_freq times 26 db 0
    
    
segment code use32 class=code
    start:
    
        ; Opening the text file: "file7.txt"
        ; EAX = fopen(file_name, access_mode) - 0 in cases of error
        push dword access_mode
        push dword file_name
        call [fopen]
        add esp, 4*2
        
        ; If file was not opened correctly, terminate the program
        cmp EAX, 0
        je final
        
            ; Save file descriptor from EAX to a location memory
            mov dword[file_descriptor], EAX
            
            ; Pseudocode Equivalent of the next code section
            ; repeat
            ;   has_read = fread(character, 1, 1, file_descriptor)
            ;   if has_read > 0
            ;       computations with this character
            ; while has_read != 0
            
            reading_file:
            
                ; Reading character by character
                push dword[file_descriptor]
                push dword 1
                push dword 1
                push dword character
                call [fread]
                add esp, 4*4
                
                ; EAX = number of characters read ( 1 or 0 in our case )
                ; If it has not read => Cleanup and terminate
                cmp EAX, 0
                je cleanup
                
                ; Processing our string from the file character by character
                ; Increasing the frequency of the character found
                mov EAX, 0
                mov AL, byte[character]
                sub AL, 'a'
                mov esi, EAX
                inc byte[character_freq + esi]
            
                ; Jumping back to read until the end of the file
            jmp reading_file
        
        ; Closing the file as we do not need it anymore
        cleanup:
        
            ; fclose(file_descriptor)
            push dword[file_descriptor]
            call [fclose]
            add esp, 4
            
        ; Pseudocode Equivalent of the code section below
        ; for i = 26, 0, -1
        ;   if(freq[i] > max_freq)
        ;       max_freq = freq[i]
        ;       max_freq_char = char(i)
        
        ; Finding the character with the maximum frequency
        mov ECX, 26 ; CL = 26, rest of the register is 0
        find_max:
        
            mov AL, [character_freq + ecx]
            cmp AL, [max_frequency]
            jng continue
                mov byte[max_frequency], AL
                mov byte[max_frequency_character], CL
            continue:
        loop find_max
        
        ; Printing the max frequency character together with it's apperances
        ; printf(format, max_freq_char, max_freq)
        
        mov EAX, 0
        mov EDX, 0
        mov AL, byte[max_frequency]
        mov DL, byte[max_frequency_character]
        add DL, 97 ; ascii code for 'a' => from number in 0..26 to corresponding lowercase letter
        
        push dword EAX
        push dword EDX
        push dword print_format
        call [printf]
        add esp, 4*3
        
        final:
        push    dword 0      
        call    [exit]       
