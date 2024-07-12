.model small
.stack 100h

.data
    msg1 db "ENTER A CAPITAL LETTER: $"  ; Message to prompt for a capital letter
    msg2 db "In small it is: $"          ; Message to display the lowercase letter
    newline db 0Ah, 0Dh, '$'             ; Newline and carriage return
    a db ?                               ; Variable to store the letter

.code
main proc
    ; Initialize the data segment
    mov ax, @data
    mov ds, ax

    ; Display message "ENTER A CAPITAL LETTER: "
    mov ah, 9
    lea dx, msg1
    int 21h

    ; Read a single character from the user
    mov ah, 1
    int 21h
    mov a, al    ; Store the input character in variable 'a'

    ; Print newline and carriage return
    mov ah, 9
    lea dx, newline
    int 21h

    ; Display message "In small it is: "
    mov ah, 9
    lea dx, msg2
    int 21h

    ; Convert the capital letter to a lowercase letter
    ; In ASCII, the difference between capital and lowercase letters is 20h (32 decimal)
    add a, 20h

    ; Display the lowercase letter
    mov dl, a    ; Move the lowercase letter into DL for printing
    mov ah, 2    ; Function to display a character in DL
    int 21h

main endp
end main
