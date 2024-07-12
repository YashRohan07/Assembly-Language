.model small
.stack 100h

.data
msg1 db "Thank you$", 0Ah, 0Dh, '$' ; Message to display after printing characters with newline and carriage return
msg2 db "Enter a character: $"      ; Message to prompt user to enter a character
newline db 0Ah, 0Dh, '$'            ; Newline (0Ah) and carriage return (0Dh) followed by '$' for string termination

.code
main proc
    ; Set up the data segment
    mov ax, @data       ; Load the address of the data segment into AX
    mov ds, ax          ; Move the address from AX to DS (Data Segment register)

    ; Print "Enter a character:"
    mov ah, 9           ; DOS function to display a string
    lea dx, msg2        ; Load the address of msg2 into DX
    int 21h             ; Call DOS interrupt 21h to display the string

    ; Read a character from user input
    mov ah, 1           ; DOS function to read a character from standard input
    int 21h             ; Call DOS interrupt 21h to read a character
    mov bl, al          ; Move the character from AL to BL

    ; Print newline and carriage return
    mov ah, 9           ; DOS function to display a string
    lea dx, newline     ; Load the address of newline into DX
    int 21h             ; Call DOS interrupt 21h to display the newline and carriage return

    ; Initialize the loop counter
    mov cx, 10          ; Set the loop counter CX to 10

print_char:             ; Label for the loop to print the character
    ; Print the character stored in BL
    mov ah, 2           ; DOS function to write a character to standard output
    mov dl, bl          ; Move the character from BL to DL
    int 21h             ; Call DOS interrupt 21h to print the character

    ; Print newline and carriage return after each character
    mov ah, 9           ; DOS function to display a string
    lea dx, newline     ; Load the address of newline into DX
    int 21h             ; Call DOS interrupt 21h to display the newline and carriage return

    ; Decrement the loop counter and check if zero
    dec cx              ; Decrement CX by 1
    cmp cx, 0           ; Compare CX with 0
    jnz print_char      ; If CX is not zero, jump to print_char to repeat

    ; Print "Thank you"
    mov ah, 9           ; DOS function to display a string
    lea dx, msg1        ; Load the address of msg1 into DX
    int 21h             ; Call DOS interrupt 21h to display the string

    ; Terminate the program
    mov ah, 4Ch         ; DOS function to terminate the process
    int 21h             ; Call DOS interrupt 21h to terminate the program

main endp
end main
