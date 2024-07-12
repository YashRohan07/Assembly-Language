.model small
.stack 100h

.data
msg1 db "Hello World",0Ah,0Dh,'$'  ; Define a message "Hello World" followed by newline (0Ah) and carriage return (0Dh), and terminate with '$'
msg2 db "Bye World!$"              ; Define a message "Bye World!" terminated with '$'

.code
main proc

    ; Set up the data segment
    mov ax, @data   ; Load the address of the data segment into AX
    mov ds, ax      ; Move the address from AX to DS (Data Segment register)

    ; Initialize loop counter
    mov cx, 10      ; Initialize the CX register with the value 10 (loop counter)

 print_hello:        ; Label for the loop start
    ; Print the "Hello World" message
    mov ah, 9       ; DOS function to display a string
    lea dx, msg1    ; Load the address of msg1 into DX
    int 21h         ; Call DOS interrupt 21h to display the string

    ; Decrement the loop counter and check if zero
    dec cx          ; Decrement the CX register by 1
    cmp cx, 0       ; Compare CX with 0
    jg print_hello  ; If CX is greater than 0, jump to print_hello (repeat the loop)

    ; Print the "Bye World!" message
    mov ah, 9       ; DOS function to display a string
    lea dx, msg2    ; Load the address of msg2 into DX
    int 21h         ; Call DOS interrupt 21h to display the string

main endp           ; End of main procedure
end                 ; End of the program
