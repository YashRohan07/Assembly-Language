.model small
.stack 100h

.data
msg1 db "Enter Any number: $"       ; Prompt message for input
msg2 db "Error!$", 0Ah, 0Dh, '$'    ; Error message followed by newline and carriage return
msg3 db "Summation of 1st, 2nd and 3rd is: $" ; Message to display the sum
newline db 0Ah, 0Dh, '$'            ; Newline and carriage return characters
num db ?                            ; Temporary variable
num1 db ?                           ; First input number
num2 db ?                           ; Second input number
num3 db ?                           ; Third input number
sum db ?                            ; Sum of the input numbers

.code
main proc
    ; Set up the data segment
    mov ax, @data
    mov ds, ax

start_input:
    ; Input the first number
    mov ah, 9          ; DOS function to display a string
    lea dx, msg1       ; Load the address of msg1 into DX
    int 21h            ; Call DOS interrupt 21h to display the string

    mov ah, 1          ; DOS function to read a character from standard input
    int 21h            ; Call DOS interrupt 21h to read the character
    mov num1, al       ; Store the input character in num1

    ; Validate the first input
    cmp al, '0'        ; Compare the input with '0'
    jl invalid_input   ; If less than '0', jump to invalid_input
    cmp al, '9'        ; Compare the input with '9'
    jg invalid_input   ; If greater than '9', jump to invalid_input 

    ; Print newline and carriage return
    mov ah, 9          ; DOS function to display a string
    lea dx, newline    ; Load the address of newline into DX
    int 21h            ; Call DOS interrupt 21h to display the newline and carriage return

    ; Input the second number
    mov ah, 9          ; DOS function to display a string
    lea dx, msg1       ; Load the address of msg1 into DX
    int 21h            ; Call DOS interrupt 21h to display the string

    mov ah, 1          ; DOS function to read a character from standard input
    int 21h            ; Call DOS interrupt 21h to read the character
    mov num2, al       ; Store the input character in num2

    ; Validate the second input
    cmp al, '0'        ; Compare the input with '0'
    jl invalid_input   ; If less than '0', jump to invalid_input
    cmp al, '9'        ; Compare the input with '9'
    jg invalid_input   ; If greater than '9', jump to invalid_input 

    ; Print newline and carriage return
    mov ah, 9          ; DOS function to display a string
    lea dx, newline    ; Load the address of newline into DX
    int 21h            ; Call DOS interrupt 21h to display the newline and carriage return

    ; Input the third number
    mov ah, 9          ; DOS function to display a string
    lea dx, msg1       ; Load the address of msg1 into DX
    int 21h            ; Call DOS interrupt 21h to display the string

    mov ah, 1          ; DOS function to read a character from standard input
    int 21h            ; Call DOS interrupt 21h to read the character
    mov num3, al       ; Store the input character in num3

    ; Validate the third input
    cmp al, '0'        ; Compare the input with '0'
    jl invalid_input   ; If less than '0', jump to invalid_input
    cmp al, '9'        ; Compare the input with '9'
    jg invalid_input   ; If greater than '9', jump to invalid_input 

    ; Print newline and carriage return
    mov ah, 9          ; DOS function to display a string
    lea dx, newline    ; Load the address of newline into DX
    int 21h            ; Call DOS interrupt 21h to display the newline and carriage return

    ; Calculate Sum
    sub num1, '0'      ; Convert ASCII to numerical value
    sub num2, '0'      ; Convert ASCII to numerical value
    sub num3, '0'      ; Convert ASCII to numerical value

    mov al, num1       ; Move the first number to AL
    add al, num2       ; Add the second number to AL
    add al, num3       ; Add the third number to AL
    mov sum, al        ; Store the sum in sum

    ; Print newline and carriage return
    mov ah, 9          ; DOS function to display a string
    lea dx, newline    ; Load the address of newline into DX
    int 21h            ; Call DOS interrupt 21h to display the newline and carriage return

    ; Print the summation message
    mov ah, 9          ; DOS function to display a string
    lea dx, msg3       ; Load the address of msg3 into DX
    int 21h            ; Call DOS interrupt 21h to display the string

    ; Print the sum
    mov ah, 2          ; DOS function to display a character
    mov dl, sum        ; Move the sum to DL
    add dl, '0'        ; Convert numerical value back to ASCII
    int 21h            ; Call DOS interrupt 21h to display the character

    ; Exit the program
    mov ah, 4Ch        ; DOS function to terminate the process
    int 21h            ; Call DOS interrupt 21h to terminate the program

invalid_input:
    ; Print newline and carriage return
    mov ah, 9          ; DOS function to display a string
    lea dx, newline    ; Load the address of newline into DX
    int 21h            ; Call DOS interrupt 21h to display the newline and carriage return

    ; Print the error message
    mov ah, 9          ; DOS function to display a string
    lea dx, msg2       ; Load the address of msg2 into DX
    int 21h            ; Call DOS interrupt 21h to display the string
    
    ; Print newline and carriage return
    mov ah, 9          ; DOS function to display a string
    lea dx, newline    ; Load the address of newline into DX
    int 21h            ; Call DOS interrupt 21h to display the newline and carriage return

    jmp start_input    ; Jump to start_input to repeat the input process

main endp             ; End of main procedure
end main              ; End of the program
