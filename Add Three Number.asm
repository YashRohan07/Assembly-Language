.model small
.stack 100h

.data
msg1 DB "Enter 1st Number : $"  ; Message to prompt for the first number
msg2 DB "Enter 2nd Number : $"  ; Message to prompt for the second number
msg3 DB "Enter 3rd Number : $"  ; Message to prompt for the third number
msg4 DB "Summation of $"        ; Part of the summation message
msg5 DB " , $"                  ; Part of the summation message
msg6 DB " and $"                ; Part of the summation message
msg7 DB " is $"                 ; Part of the summation message
newline DB 0Dh, 0Ah, '$'        ; Newline and carriage return

a DB ?        ; Variable to store the first number
b DB ?        ; Variable to store the second number
c DB ?        ; Variable to store the third number  
sum DB ?      ; Variable to store the sum

.code
main proc
    mov ax, @data    ; Initialize the data segment
    mov ds, ax

    ; Display message "Enter 1st Number : "
    mov ah, 9
    lea dx, msg1
    int 21h

    ; Read first number from user
    mov ah, 1
    int 21h
    sub al, '0'     ; Convert ASCII input to numerical value
    mov a, al       ; Store the input in variable 'a'

    ; Print newline and carriage return
    mov ah, 9
    lea dx, newline
    int 21h

    ; Display message "Enter 2nd Number : "
    mov ah, 9
    lea dx, msg2
    int 21h

    ; Read second number from user
    mov ah, 1
    int 21h
    sub al, '0'     ; Convert ASCII input to numerical value
    mov b, al       ; Store the input in variable 'b'

    ; Print newline and carriage return
    mov ah, 9
    lea dx, newline
    int 21h

    ; Display message "Enter 3rd Number : "
    mov ah, 9
    lea dx, msg3
    int 21h

    ; Read third number from user
    mov ah, 1
    int 21h
    sub al, '0'     ; Convert ASCII input to numerical value
    mov c, al       ; Store the input in variable 'c'

    ; Print newline and carriage return
    mov ah, 9
    lea dx, newline
    int 21h

    ; Calculate Sum
    mov al, a       ; Move the first number to AL
    add al, b       ; Add the second number to AL
    add al, c       ; Add the third number to AL
    mov sum, al     ; Store the sum in 'sum'

    ; Display "Summation of "
    mov ah, 9
    lea dx, msg4
    int 21h

    ; Display the first number
    mov ah, 2
    mov dl, a
    add dl, '0'     ; Convert numerical value back to ASCII
    int 21h

    ; Display " , "
    mov ah, 9
    lea dx, msg5
    int 21h

    ; Display the second number
    mov ah, 2
    mov dl, b
    add dl, '0'     ; Convert numerical value back to ASCII
    int 21h

    ; Display " and "
    mov ah, 9
    lea dx, msg6
    int 21h

    ; Display the third number
    mov ah, 2
    mov dl, c
    add dl, '0'     ; Convert numerical value back to ASCII
    int 21h

    ; Display " is "
    mov ah, 9
    lea dx, msg7
    int 21h

    ; Display the summation result
    mov ah, 2
    mov dl, sum
    add dl, '0'     ; Convert numerical value of sum back to ASCII
    int 21h

    ; Terminate the program
    mov ah, 4Ch
    int 21h

main endp
end main
