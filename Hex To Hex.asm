.model small
.stack 100h
.data
    promptInput db 'Hexa Input  : $'       
    promptOutput db 10, 13, 'Hexa Output : $'
    errorMessage db 10, 13, 'Invalid input! Please enter hexadecimal digits only (0-9, A-F).', 10, 13, '$'

.code
main proc
    ; Initialize data segment
    mov ax, @data
    mov ds, ax
    
    ; Display prompt message for hexadecimal input
    mov ah, 9
    lea dx, promptInput
    int 21h
    
    ; Initialize registers
    xor bx, bx          ; Clear BX to hold the final hexadecimal value
    mov cx, 4           ; Set CX to count up to 4 hex digits input

input_loop:
    mov ah, 1           ; Function 1 - read a single character input
    int 21h             ; Call interrupt to read input
    
    ; Check if 'Enter' key is pressed (ASCII 13)
    cmp al, 13          ; Compare AL with ASCII for Enter key
    je display_output    ; If Enter is pressed, jump to display_output
    
    ; Check if the input is a digit (0-9) or a letter (A-F)
    cmp al, '0'         ; Check if AL is less than '0'
    jb invalid_input     ; If less than '0', jump to invalid_input
    cmp al, '9'         ; Check if AL is greater than '9'
    jbe convert_digit    ; If it's a digit, convert it
    
    ; Check for uppercase letters (A-F)
    cmp al, 'A'         ; Check if AL is less than 'A'
    jb invalid_input     ; If less than 'A', it's invalid
    cmp al, 'F'         ; Check if AL is greater than 'F'
    ja invalid_input     ; If greater than 'F', it's invalid
    
    ; Convert letter (A-F) to decimal value
    sub al, 37h         ; Convert ASCII letter to its corresponding hex value (A=10, B=11, etc.)
    jmp store_value      ; Jump to store the converted value

convert_digit:
    sub al, '0'         ; Convert ASCII digit to its corresponding value (0-9)

store_value:
    shl bx, 4           ; Shift BX left by 4 bits to make space for the new input
    or bl, al           ; Combine the input digit into BL
    loop input_loop      ; Decrement CX and loop if CX is not zero
    
display_output:
    ; Display the output prompt
    mov ah, 9
    lea dx, promptOutput
    int 21h  

    ; Initialize output loop to display the hexadecimal value
    mov cx, 4           ; Set the number of digits to display
    mov ah, 2           ; Function 2 - display character

output_loop:
    mov dl, bh          ; Get the upper 4 bits of BX
    shr dl, 4           ; Shift right to get the most significant nibble
    rol bx, 4           ; Rotate BX left to prepare the next nibble

    ; Check if the value is 10 or greater
    cmp dl, 10
    jge output_letter    ; If DL >= 10, jump to output_letter to convert to 'A'-'F'
    
    ; Convert number (0-9) to ASCII
    add dl, '0'         ; Convert to ASCII character (0-9)
    int 21h             ; Display the character
    jmp continue_output  ; Jump to continue_output
    
output_letter:
    add dl, 37h         ; Convert to ASCII letter ('A' = 41h, etc.)
    int 21h             ; Display the character
    
continue_output:
    loop output_loop     ; Loop for each nibble (4 digits in total)
    
    ; Exit the program
    mov ah, 4ch
    int 21h

invalid_input:
    ; Display error message for invalid input
    mov ah, 9
    lea dx, errorMessage
    int 21h
    jmp input_loop      ; Go back to input loop to try again

main endp
end
