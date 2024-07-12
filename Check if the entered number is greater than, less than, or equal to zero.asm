.model small
.stack 100h

.data
msg1 db "Enter a number: $"         ; Message to prompt user to enter the first number
msg2 db "Positive$"                 ; Message to display if the number is positive
msg3 db "Negative$"                 ; Message to display if the number is negative
msg4 db "Equal to zero$"            ; Message to display if the number is zero
newline db 0Ah, 0Dh, '$'            ; Newline (0Ah) and carriage return (0Dh) followed by '$' for string termination

.code
main proc
    ; Initialize the data segment
    mov ax, @data       ; Load the address of the data segment into AX
    mov ds, ax          ; Move the address from AX to DS (Data Segment register)

    ; Print "Enter a number:"
    mov ah, 9           ; DOS function 9 - Print string
    lea dx, msg1        ; Load the address of msg1 into DX
    int 21h             ; Call DOS interrupt 21h to print the prompt

    ; Read a single character from user input
    mov ah, 1           ; DOS function 1 - Read character from input
    int 21h             ; Call DOS interrupt 21h to read a character
    mov bl, al          ; Store the input character in BL

    ; Compare the input with '0'
    cmp bl, '0'         ; Compare BL with ASCII '0'
    jg pos_print        ; If greater, jump to pos_print
    jl neg_print        ; If less, jump to neg_print
    jmp equal_print     ; If equal, jump to equal_print

    pos_print:
    ; Print newline and carriage return
    mov ah, 9           ; DOS function 9 - Print string
    lea dx, newline     ; Load the address of newline into DX
    int 21h             ; Call DOS interrupt 21h to print newline and carriage return

    ; Print "Positive"
    mov ah, 9           ; DOS function 9 - Print string
    lea dx, msg2        ; Load the address of msg2 into DX
    int 21h             ; Call DOS interrupt 21h to print "Positive"
    jmp exit            ; Jump to exit

    neg_print:
    ; Print newline and carriage return
    mov ah, 9           ; DOS function 9 - Print string
    lea dx, newline     ; Load the address of newline into DX
    int 21h             ; Call DOS interrupt 21h to print newline and carriage return

    ; Print "Negative"
    mov ah, 9           ; DOS function 9 - Print string
    lea dx, msg3        ; Load the address of msg3 into DX
    int 21h             ; Call DOS interrupt 21h to print "Negative"
    jmp exit            ; Jump to exit

    equal_print:
    ; Print newline and carriage return
    mov ah, 9           ; DOS function 9 - Print string
    lea dx, newline     ; Load the address of newline into DX
    int 21h             ; Call DOS interrupt 21h to print newline and carriage return

    ; Print "Equal to zero"
    mov ah, 9           ; DOS function 9 - Print string
    lea dx, msg4        ; Load the address of msg4 into DX
    int 21h             ; Call DOS interrupt 21h to print "Equal to zero"

    exit:
    ; Terminate the program
    mov ah, 4Ch         ; DOS function 4Ch - Terminate process
    int 21h             ; Call DOS interrupt 21h to terminate the program

main endp
end main
