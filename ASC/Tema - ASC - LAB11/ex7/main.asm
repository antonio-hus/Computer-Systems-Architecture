bits 32
global start        

extern exit, printf
import exit msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data

    ; initializing our strings
    string1 db "apple", 0
    len1 equ $-string1
    
    string2 db "append", 0
    len2 equ $-string2
    
    string3 db "appetizer", 0
    len3 equ $-string3
    
    ; the length of the result <= the greatest length of the strings 
    ; max length of the strings is 100
    ; hence we use 100 bytes for our result to be safe
    longest_prefix times 100 db 0
    lp_len db 0
    
    ; format for printf
    print_format db "The longest prefix is: %s", 0
    
segment code use32 class=code

    ; longest prefix function (common subproblem)
    get_longest_prefix:
    
        ; parse from the start (left to right) until encountering a different character, or '0'
        cld
        mov esi, [esp+8] ; string1
        mov edi, [esp+4] ; string2
    
        string_parse:
            mov al, [esi]
            mov bl, [edi]
            
            ; stop conditions
            cmp al, 0
            jz final
            cmp bl, 0
            jz final
            cmp al,bl
            jnz final
            
            ; characters are equal => add in longest_prefix
            mov ecx, 0
            mov cl, [lp_len]
            mov [longest_prefix + ecx], al 
            inc byte[lp_len]
            
            ; incrementing
            inc esi
            inc edi
            
        jmp string_parse
        
        final:
        ret

    
    ; main function
    start:
        
        ; get_longest_prefix(s1,s2,s3) = get_longest_prefix(get_longest_prefix(s1,s2),s3)
        
        ; push the addresses of the strings
        push dword string1
        push dword string2
        call get_longest_prefix
        add esp, 4*2
        
        ; print the longest_prefix
        push dword longest_prefix
        push dword print_format
        call [printf]
        add esp, 4*2
        
        push    dword 0      
        call    [exit]       
