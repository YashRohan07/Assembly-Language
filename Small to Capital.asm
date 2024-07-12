.model small
.stack 100h

.data
    msg1 db "ENTER A SMALL LETTER: $"   ; Message to prompt for a small letter
    msg2 db "In capital it is: $"       ; Message to display the uppercase letter
    newline db 0Ah, 0Dh, '$'            ; Newline and carriage return
    a db ?                              ; Variable to store the letter

.code
main proc
    ; Initialize the data segment
    mov ax, @data
    mov ds, ax

    ; Display message "ENTER A SMALL LETTER: "
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

    ; Display message "In capital it is: "
    mov ah, 9
    lea dx, msg2
    int 21h

    ; Convert the lowercase letter to a capital letter
    ; In ASCII, the difference between lowercase and capital letters is 20h (32 decimal)
    sub a, 20h

    ; Display the capital letter
    mov dl, a    ; Move the capital letter into DL for printing
    mov ah, 2    ; Function to display a character in DL
    int 21h

main endp
end main
