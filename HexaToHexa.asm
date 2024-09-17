.model small
.stack 100h
.data
    a db 'Hexa Input  : $'       
    b db 10,13, 'Hexa Output : $'

.code
    main proc
    ; Initialize data segment
    mov ax, @Data
    mov ds, ax
    
    ; Display the prompt message for hexadecimal input
    mov ah, 9
    lea dx, a
    int 21h
    
    ; Initialize registers
    mov bx, 0    ; BX will hold the final hexadecimal value
    mov cx, 4    ; CX counter for a maximum of 4 digits input

    ; Loop to get hexadecimal input
    INPUT:
    mov ah, 1    ; Function 1 - read a single character input
    int 21h
    
    ; Check if 'Enter' key is pressed (ASCII 13)
    cmp al, 13   ; If 'Enter' key is pressed, jump to OUTPUT_
    je OUTPUT_
    
    ; Check if the input is a letter 'A' (ASCII 41h) or greater
    cmp al, 41h
    jge letter   ; If AL >= 'A', jump to the letter label
    
    ; Convert numeric ASCII (0-9) to decimal value
    and al, 0Fh  ; Mask out the upper nibble to get the decimal value (0-9)
    jmp shift    ; Jump to shift to store this value

    ; Convert letter (A-F) to decimal value
    letter:
    sub al, 37h  ; Convert ASCII letter to its corresponding hexadecimal value ('A' = 10, 'B' = 11, etc.)
     
    ; Store the value in BX
    shift:  
    shl bx, 4    ; Shift BX left by 4 bits to make space for the new input
    or bl, al    ; Combine the input digit into BX
    loop INPUT   ; Decrement CX and loop if CX is not zero
    
    ; Display the hexadecimal output prompt
    OUTPUT_:
    mov ah, 9
    lea dx, b
    int 21h  
    
    ; Initialize output loop to display the hexadecimal value
    mov cx, 4    ; Set the number of digits to display
    mov ah, 2    ; Function 2 - display character

    ; Loop to output each hexadecimal digit
    OUTPUT_1:
    mov dl, bh   ; Get the upper 4 bits of BX
    shr dl, 4    ; Shift right to get the most significant nibble
    rol bx, 4    ; Rotate BX left to prepare the next nibble
    
    ; Check if the value is 10 or greater
    cmp dl, 10
    jge output_letter ; If DL >= 10, jump to output_letter to convert to 'A'-'F'
    
    ; Convert number (0-9) to ASCII
    add dl, 30h  ; Add '0' (30h) to convert to ASCII
    int 21h      ; Display the character
    jmp EXIT_1   ; Jump to the end of loop
    
    ; Convert value (10-15) to corresponding letter (A-F)
    output_letter:
    add dl, 37h  ; Add 37h to convert to ASCII letter ('A' = 41h, 'B' = 42h, etc.)
    int 21h      ; Display the character
    
    ; End of output loop
    EXIT_1:
    loop OUTPUT_1 ; Loop for each nibble (4 digits in total)
    
    ; Exit the program
    mov ah, 4ch
    int 21h
    main endp
end
