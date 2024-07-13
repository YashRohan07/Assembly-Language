.model small
.stack 100h
.data
msg1 db "Enter a number: $"         ; Message to prompt user to enter the first number
msg2 db "Enter another number: $"   ; Message to prompt user to enter the second number
msg3 db 0Ah, 0Dh, '$'               ; Newline (0Ah) and carriage return (0Dh) followed by '$' for string termination
num1 db ?                           ; Reserve a byte of memory for the first number
num2 db ?                           ; Reserve a byte of memory for the second number

.code
main proc

    ; Initialize the data segment
    mov ax, @data  ; Load the address of the data segment into AX
    mov ds, ax     ; Move the address from AX to DS (Data Segment register)

    ; Print the first prompt message
    mov ah, 9      ; DOS function 9 - Display string
    lea dx, msg1   ; Load the address of msg1 into DX
    int 21h        ; Call DOS interrupt 21h to print the string

    ; Read the first character from user input
    mov ah, 1      ; DOS function 1 - Read a character from standard input
    int 21h        ; Call DOS interrupt 21h to read a character
    mov num1, al   ; Store the character read in num1

    ; Print a newline and carriage return
    mov ah, 9      ; DOS function 9 - Display string
    lea dx, msg3   ; Load the address of msg3 into DX
    int 21h        ; Call DOS interrupt 21h to print the newline and carriage return

    ; Print the second prompt message
    lea dx, msg2   ; Load the address of msg2 into DX
    int 21h        ; Call DOS interrupt 21h to print the string

    ; Read the second character from user input
    mov ah, 1      ; DOS function 1 - Read a character from standard input
    int 21h        ; Call DOS interrupt 21h to read a character
    mov num2, al   ; Store the character read in num2

    ; Add the two inputs
    add num1, al   ; Add the value of AL (second input) to num1
    sub num1, 30h  ; Subtract 30h to convert ASCII to numerical value

    ; Print a newline and carriage return
    mov ah, 9      ; DOS function 9 - Display string
    lea dx, msg3   ; Load the address of msg3 into DX
    int 21h        ; Call DOS interrupt 21h to print the newline and carriage return

    ; Print the result
    mov ah, 2      ; DOS function 2 - Write a character to standard output
    mov dl, num1   ; Move the result from num1 to DL
    int 21h        ; Call DOS interrupt 21h to print the character in DL

    ; Terminate the program
    mov ah, 4ch    ; DOS function 4Ch - Terminate the process
    int 21h        ; Call DOS interrupt 21h to terminate the program

main endp
end main
