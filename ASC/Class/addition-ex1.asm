bits 32

global start        

extern exit               
import exit msvcrt.dll

segment data use32 class=data
    a db 10
    b dw 50
    c db -1

segment code use32 class=code
    start:
        mov AL, [a] ; AL = a = 10 = 0A
        mov byte [c], 20 ; c = 20
        mov BL, AL ; BL = AL = 10 ( byte )
        mov CX, b ; CX = b = 50 ( word )
        
        add AL, [c] ; AL = AL + c = 10 + 20
        add byte [a], 5 ; a = a + 5 = 15
        sub CX, 10 ; CX = CX - 10 = 50 - 10 = 40
        sub word [b], CX ; b = b - CX = 50 - 40 = 10
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
