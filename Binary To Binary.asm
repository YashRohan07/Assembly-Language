.model small          
.stack 100h           

.data
    msg1 db "Enter binary Input: $"
    msg2 db 0Ah, 0Dh, "Binary Output: $"

.code
main proc
    ; Initialize the data segment
    mov ax, @data      ; Load the address of the data segment into AX
    mov ds, ax         ; Move the address from AX to the DS (Data Segment) register
    
    ; Display the input message "Enter binary Input:"
    mov ah, 9          ; DOS interrupt function 09h: Display string
    lea dx, msg1       ; Load the address of msg1 into DX
    int 21h            ; Call interrupt 21h to display the message

    ; Call the procedure to read binary input
    call ReadBinaryInput

    ; Call the procedure to display the output
    call DisplayBinaryOutput

    ; End the program
    mov ah, 4Ch        
    int 21h            
main endp             

; Procedure to read binary input
ReadBinaryInput proc
    xor bx, bx         ; Clear BX to store the binary number (set BX to 0)
    mov cx, 16         ; Set CX to 16, expecting 16 binary bits from the user
    
input_loop:
    mov ah, 1          ; DOS interrupt function 01h: Read a character from input
    int 21h            ; Call interrupt 21h to get the character input from the user
    cmp al, 0Dh        ; Compare AL with 0Dh (Enter key/carriage return)
    je end_input       ; If Enter is pressed, jump to end_input
    
    sub al, '0'        ; Convert ASCII character ('0' or '1') to a numeric value (0 or 1)
    shl bx, 1          ; Shift BX left by 1 to make space for the next bit
    or bl, al          ; OR the value in AL (0 or 1) into the least significant bit of BX
    loop input_loop    ; Decrement CX, repeat input_loop until 16 bits are entered

end_input:
    ret                 ; Return from ReadBinaryInput procedure
ReadBinaryInput endp

; Procedure to display the binary output
DisplayBinaryOutput proc
    ; Print a newline (CR and LF)
    mov ah, 2          ; DOS interrupt function 02h: Display a single character
    mov dl, 10         ; Load 10 (newline) into DL
    int 21h            ; Call interrupt 21h to print LF (line feed)
    mov dl, 13         ; Load 13 (carriage return) into DL
    int 21h            ; Call interrupt 21h to print CR (carriage return)
    
    ; Display the output message "Binary Output:"
    mov ah, 9          ; DOS interrupt function 09h: Display string
    lea dx, msg2       ; Load the address of msg2 into DX
    int 21h            ; Call interrupt 21h to display the message
    
    ; Output the binary number stored in BX (in its original order)
    mov cx, 16         ; Set CX to 16 (the number of bits to output)

output_loop:
    shl bx, 1          ; Shift BX left by 1 bit to bring the most significant bit (MSB) into the carry flag
    jc print_one       ; If the carry flag is set (MSB is 1), jump to print_one
    
    ; Print '0'
    mov ah, 2          ; DOS interrupt function 02h: Display a single character
    mov dl, '0'        ; Load '0' into DL
    int 21h            ; Call interrupt 21h to print '0'
    loop output_loop   ; Decrement CX, repeat output_loop until all 16 bits are printed
    jmp done           ; Jump to done (end of program)

print_one:
    ; Print '1'
    mov ah, 2          ; DOS interrupt function 02h: Display a single character
    mov dl, '1'        ; Load '1' into DL
    int 21h            ; Call interrupt 21h to print '1'
    
    loop output_loop   ; Decrement CX, repeat output_loop until all 16 bits are printed

done:
    ret                 ; Return from DisplayBinaryOutput procedure
DisplayBinaryOutput endp

end main                  
