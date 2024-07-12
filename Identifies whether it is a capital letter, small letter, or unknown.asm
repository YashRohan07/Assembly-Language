.model small
.stack 100h

.data
msg1 db "Enter a letter: $"        ; Prompt message for user input
msg2 db "Capital Letter $"         ; Message for capital letter output
msg3 db "Small Letter $"           ; Message for small letter output
msg4 db "Unknown Letter $"         ; Message for unknown character output
msg5 db 0Ah, 0Dh, '$'              ; Newline (0Ah), carriage return (0Dh), and string terminator

.code
main proc
    ; Initialize data segment
    mov ax, @data       ; Load the address of the data segment into AX
    mov ds, ax          ; Move the address from AX to DS (Data Segment register)

    ; Display the prompt message "Enter a letter: "
    mov ah, 9           ; DOS function 9 - Print string
    lea dx, msg1        ; Load address of msg1 (prompt) into DX
    int 21h             ; Call DOS interrupt 21h to print the prompt

    ; Read a single character from user input
    mov ah, 1           ; DOS function 1 - Read character from input
    int 21h             ; Call DOS interrupt 21h to read a character
    mov bh, al          ; Store the input character in BH

    ; Print a newline and carriage return
    mov ah, 9           ; DOS function 9 - Print string
    lea dx, msg5        ; Load address of msg5 (newline and carriage return) into DX
    int 21h             ; Call DOS interrupt 21h to print newline and carriage return

    ; Check if the entered character is a capital letter
    cmp bh, 'A'         ; Compare BH with ASCII 'A'
    jge check_Capital   ; Jump to check_Capital if BH is greater than or equal to 'A'
    jl small_check      ; Jump to small_check if BH is less than 'A'

    check_Capital:
    cmp bh, 'Z'         ; Compare BH with ASCII 'Z'
    jle print_cap       ; Jump to print_cap if BH is less than or equal to 'Z'
    jg small_check      ; Jump to small_check if BH is greater than 'Z'

    print_cap:
    ; Display the message "Capital Letter"
    mov ah, 9           ; DOS function 9 - Print string
    lea dx, msg2        ; Load address of msg2 (capital letter message) into DX
    int 21h             ; Call DOS interrupt 21h to print the capital letter message
    jmp exit            ; Jump to exit

    small_check:
    cmp bh, 'a'         ; Compare BH with ASCII 'a'
    jge small_check2    ; Jump to small_check2 if BH is greater than or equal to 'a'
    jmp unknown_print   ; Jump to unknown_print if BH is less than 'a'

    small_check2:
    cmp bh, 'z'         ; Compare BH with ASCII 'z'
    jle print_small     ; Jump to print_small if BH is less than or equal to 'z'
    jmp unknown_print   ; Jump to unknown_print if BH is greater than 'z'

    print_small:
    ; Display the message "Small Letter"
    mov ah, 9           ; DOS function 9 - Print string
    lea dx, msg3        ; Load address of msg3 (small letter message) into DX
    int 21h             ; Call DOS interrupt 21h to print the small letter message
    jmp exit            ; Jump to exit

    unknown_print:
    ; Display the message "Unknown Letter"
    mov ah, 9           ; DOS function 9 - Print string
    lea dx, msg4        ; Load address of msg4 (unknown letter message) into DX
    int 21h             ; Call DOS interrupt 21h to print the unknown letter message

    exit:
    ; Terminate the program
    mov ah, 4Ch         ; DOS function 4Ch - Terminate process
    int 21h             ; Call DOS interrupt 21h to terminate the program

main endp
end main
