.model small
.stack 100h

.data
msg1 db "Enter a Number:$"    ; Prompt message for user to enter a number
newline db 0Ah, 0Dh, '$'      ; Newline (0Ah) and carriage return (0Dh) followed by '$' for string termination

.code
main proc
    ; Initialize data segment
    mov ax, @data       ; Load the address of the data segment into AX
    mov ds, ax          ; Move the address from AX to DS (Data Segment register)

    ; Print the prompt message "Enter a Number:"
    mov ah, 9           ; DOS function 9 - Print string
    lea dx, msg1        ; Load the address of msg1 into DX
    int 21h             ; Call DOS interrupt 21h to print the prompt message

    ; Read a single character from user input
    mov ah, 1           ; DOS function 1 - Read character from input
    int 21h             ; Call DOS interrupt 21h to read a character
    mov bh, al          ; Store the input character in BH

    ; Print newline and carriage return
    mov ah, 9           ; DOS function 9 - Print string
    lea dx, newline     ; Load the address of newline into DX
    int 21h             ; Call DOS interrupt 21h to print newline and carriage return

    ; Compare the input character (in BH) with '1' and '3' for odd numbers
    cmp bh, '1'         ; Compare BH with ASCII '1'
    je o_matched        ; Jump if equal to o_matched to handle odd numbers
    cmp bh, '3'         ; Compare BH with ASCII '3'
    je o_matched        ; Jump if equal to o_matched to handle odd numbers

    ; Compare the input character (in BH) with '2' and '4' for even numbers
    cmp bh, '2'         ; Compare BH with ASCII '2'
    je e_matched        ; Jump if equal to e_matched to handle even numbers
    cmp bh, '4'         ; Compare BH with ASCII '4'
    je e_matched        ; Jump if equal to e_matched to handle even numbers

    ; Print 'n' if the character does not match '1', '2', '3', or '4'
    jmp not_matched     ; Jump to not_matched if no match found

    o_matched:
    ; Print 'o' for odd number match
    mov ah, 2           ; DOS function 2 - Write character to output
    mov dl, 'o'         ; Load 'o' into DL
    int 21h             ; Call DOS interrupt 21h to print 'o'
    jmp end             ; Jump to end of program

    e_matched:
    ; Print 'e' for even number match
    mov ah, 2           ; DOS function 2 - Write character to output
    mov dl, 'e'         ; Load 'e' into DL
    int 21h             ; Call DOS interrupt 21h to print 'e'
    jmp end             ; Jump to end of program

    not_matched:
    ; Print 'n' for no match (not 1, 2, 3, or 4)
    mov ah, 2           ; DOS function 2 - Write character to output
    mov dl, 'n'         ; Load 'n' into DL
    int 21h             ; Call DOS interrupt 21h to print 'n'

    end:
    ; Terminate the program
    mov ah, 4Ch         ; DOS function 4Ch - Terminate process
    int 21h             ; Call DOS interrupt 21h to terminate the program

main endp
end main
