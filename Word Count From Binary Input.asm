.model small
.stack 100h

.data
    msg1 db "Enter binary Input: $"
    msg2 db "Count of '1's: $"
    msg3 db "Count of '0's: $"
    count_ones db 0          ; Variable to store the count of '1's
    count_zeros db 0         ; Variable to store the count of '0's

.code
main proc
    ; Initialize the data segment
    mov ax, @data      ; Load the address of the data segment into AX
    mov ds, ax         ; Move the address from AX to the DS (Data Segment) register
    
    ; Display the input message "Enter binary Input:"
    mov ah, 9          ; DOS interrupt function 09h: Display string
    lea dx, msg1       ; Load the address of msg1 into DX
    int 21h            ; Call interrupt 21h to display the message
    
    ; Input binary number
    xor bx, bx         ; Clear BX to store the binary number (set BX to 0)
    mov cx, 0          ; Clear CX to count the number of bits input
    
input_loop:
    mov ah, 1          ; DOS interrupt function 01h: Read a character from input
    int 21h            ; Call interrupt 21h to get the character input from the user
    cmp al, 0Dh        ; Compare AL with 0Dh (Enter key/carriage return)
    je output_display   ; If Enter is pressed, jump to output_display (end input)
    
    ; Convert ASCII character ('0' or '1') to numeric value (0 or 1)
    sub al, '0'        
    
    ; Increment count if the input character is '1'
    cmp al, 1          ; Check if the value is '1'
    je count_one       ; If it's '1', jump to count_one
    cmp al, 0          ; Check if the value is '0'
    je count_zero      ; If it's '0', jump to count_zero
    jmp input_loop     ; If input is neither '0' nor '1', skip counting

count_one:
    inc count_ones     ; Increment the count of '1's
    jmp store_bit      ; Jump to store the bit

count_zero:
    inc count_zeros    ; Increment the count of '0's

store_bit:
    shl bx, 1          ; Shift BX left by 1 to make space for the next bit
    or bl, al          ; OR the value in AL (0 or 1) into the least significant bit of BX
    inc cx             ; Increment the count of bits entered
    jmp input_loop     ; Repeat input_loop for more input

output_display:
    ; Print a newline (CR and LF)
    mov ah, 2          ; DOS interrupt function 02h: Display a single character
    mov dl, 10         ; Load 10 (newline) into DL
    int 21h            ; Call interrupt 21h to print LF (line feed)
    mov dl, 13         ; Load 13 (carriage return) into DL
    int 21h            ; Call interrupt 21h to print CR (carriage return)

    ; Display the output message "Count of '1's:"
    mov ah, 9          ; DOS interrupt function 09h: Display string
    lea dx, msg2       ; Load the address of msg2 into DX
    int 21h            ; Call interrupt 21h to display the message

    ; Print the count of '1's
    mov al, count_ones ; Load the count of '1's into AL
    call PrintNumber    ; Call PrintNumber to print the count

    ; Print a newline for separation
    mov ah, 2
    mov dl, 10
    int 21h
    mov dl, 13
    int 21h

    ; Display the output message "Count of '0's:"
    mov ah, 9          ; DOS interrupt function 09h: Display string
    lea dx, msg3       ; Load the address of msg3 into DX
    int 21h            ; Call interrupt 21h to display the message

    ; Print the count of '0's
    mov al, count_zeros ; Load the count of '0's into AL
    call PrintNumber     ; Call PrintNumber to print the count

done:
    ; End the program
    mov ax, 4C00h      ; Terminate program
    int 21h            ; Call DOS interrupt

; Procedure to print a number in AL
PrintNumber proc
    ; Check if count is 0
    cmp al, 0
    je PrintZero        ; If zero, print '0'

    ; Convert AL (0-9) to its ASCII representation
    add al, '0'        ; Convert to ASCII character
    mov ah, 2          ; DOS interrupt function 02h: Display a single character
    mov dl, al         ; Load the character into DL
    int 21h            ; Call interrupt 21h to print the character
    ret

PrintZero:
    mov ah, 2          ; DOS interrupt function 02h: Display a single character
    mov dl, '0'        ; Load '0' into DL
    int 21h            ; Call interrupt 21h to print the character
    ret
PrintNumber endp

end main
