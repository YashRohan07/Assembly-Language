.model small
.stack 100h
.data
msg1 db "Enter a number: $"         ; Enter the first number
msg2 db "Enter another number: $"   ; Enter the second number
msg3 db 0Ah, 0Dh, '$'               ; Newline (0Ah) and carriage return (0Dh) followed by '$' for string termination
num1 db ?                           ; Reserve a byte of memory for the first number
num2 db ?                           ; Reserve a byte of memory for the second number

.code
main proc

    mov ax, @data  ; Load the address of the data segment into AX
    mov ds, ax     ; Move the address from AX to DS (Data Segment register)

    ; Print the first message
    mov ah, 9      ; Function to display a string
    lea dx, msg1   ; Load the address of msg1 into DX
    int 21h        ; Call DOS interrupt 21h to print the string

    ; Read the first character from user input
    mov ah, 1      ; Function to read a character from standard input
    int 21h        ; Call DOS interrupt 21h to read a character
    mov num1, al   ; Move the character from AL to num1

    ; Print a newline and carriage return
    mov ah, 9      ; Function to display a string
    lea dx, msg3   ; Load the address of msg3 into DX
    int 21h        ; Call DOS interrupt 21h to print the string

    ; Print the second message
    lea dx, msg2   ; Load the address of msg2 into DX
    int 21h        ; Call DOS interrupt 21h to print the string

    ; Read the second character from user input
    mov ah, 1      ; Function to read a character from standard input
    int 21h        ; Call DOS interrupt 21h to read a character
    mov num2, al   ; Move the character from AL to num2

    ; Subtract the second input from the first input
    sub num1, al   ; Subtract the value of AL (second input) from num1
    add num1, 30h  ; Add 30h to convert numerical value back to ASCII

    ; Print a newline and carriage return
    mov ah, 9      ; Function to display a string
    lea dx, msg3   ; Load the address of msg3 into DX
    int 21h        ; Call DOS interrupt 21h to print the string

    ; Print the result
    mov ah, 2      ; Function to write a character to standard output
    mov dl, num1   ; Move the result from num1 to DL
    int 21h        ; Call DOS interrupt 21h to print the character in DL

    ; Terminate the program
    mov ah, 4Ch    ; Function to terminate the process
    int 21h        ; Call DOS interrupt 21h to terminate the program

main endp
end main
