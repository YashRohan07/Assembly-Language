.model small
.stack 100h

.data
    msg1 db "Enter first number: $"
    msg2 db "Enter second number: $"
    msg3 db "Sum is: $"
    newline db 0Ah, 0Dh, '$'
    num1 db ?
    num2 db ?
    result db ?

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Prompt for first number
    mov ah, 9
    lea dx, msg1
    int 21h

    ; Read first number
    mov ah, 1
    int 21h
    sub al, '0'     ; Convert ASCII to numerical value
    mov num1, al   
    
    ; Print newline and carriage return
    mov ah, 9
    lea dx, newline
    int 21h

    ; Prompt for second number
    mov ah, 9
    lea dx, msg2
    int 21h

    ; Read second number
    mov ah, 1
    int 21h
    sub al, '0'     ; Convert ASCII to numerical value
    mov num2, al

    ; Add the two numbers
    mov al, num1
    add al, num2
    mov result, al

    ; Print newline and carriage return
    mov ah, 9
    lea dx, newline
    int 21h

    ; Display result message
    mov ah, 9
    lea dx, msg3
    int 21h

    ; Display result
    mov dl, result
    add dl, '0'     ; Convert numerical value to ASCII
    mov ah, 2
    int 21h

    ; Exit program
    mov ah, 4Ch
    int 21h

main endp
end main
