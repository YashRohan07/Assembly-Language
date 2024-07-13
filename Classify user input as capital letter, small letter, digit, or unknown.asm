.MODEL SMALL
.STACK 100H

.DATA
    INPUT_MSG DB 'Enter a character: $'       ; Prompt message for user input
    CAPITAL_MSG DB 0Ah, 0Dh, 'Capital Letter$', 0Ah, 0Dh, '$'  ; Message for capital letter with newline and carriage return
    SMALL_MSG DB 0Ah, 0Dh, 'Small Letter$', 0Ah, 0Dh, '$'      ; Message for small letter with newline and carriage return
    NUMBER_MSG DB 0Ah, 0Dh, 'It is a number$', 0Ah, 0Dh, '$'   ; Message for numeric character with newline and carriage return
    UNKNOWN_MSG DB 0Ah, 0Dh, 'Unknown$', 0Ah, 0Dh, '$'         ; Message for unknown character with newline and carriage return
    X DB ?      ; Variable to store user input

.CODE
MAIN PROC
    MOV AX, @DATA      ; Initialize data segment
    MOV DS, AX         ; Set DS to point to data segment

INPUT_LOOP:
    ; Print prompt message "Enter a character: "
    MOV AH, 09H         ; DOS function 09H - Print string
    LEA DX, INPUT_MSG   ; Load address of INPUT_MSG into DX
    INT 21H             ; Call interrupt 21H to print prompt message

    ; Read a character from standard input
    MOV AH, 01H         ; DOS function 01H - Read character from standard input
    INT 21H             ; Call interrupt 21H to read a character
    MOV X, AL           ; Move input character to X

    ; Print the entered character
    MOV AH, 02H         ; DOS function 02H - Print character
    MOV DL, X           ; Load X into DL for printing
    INT 21H             ; Call interrupt 21H to print the input character

    ; Print newline (0Dh, 0Ah)
    MOV AH, 02H         ; DOS function 02H - Print character
    MOV DL, 0DH         ; ASCII code for carriage return (CR)
    INT 21H             ; Call interrupt 21H to print carriage return
    MOV DL, 0AH         ; ASCII code for newline (LF)
    INT 21H             ; Call interrupt 21H to print newline

    ; Compare the input character to determine its type
    MOV AL, X           ; Move X back to AL for comparison
    CMP AL, 'A'         ; Compare AL with 'A'
    JL CHECK_SMALL      ; Jump if less than 'A' to check for small letter
    CMP AL, 'Z'         ; Compare AL with 'Z'
    JG CHECK_SMALL      ; Jump if greater than 'Z' to check for small letter
    JMP PRINT_CAPITAL   ; Otherwise, print as capital letter

CHECK_SMALL:
    CMP AL, 'a'         ; Compare AL with 'a'
    JL CHECK_NUMBER     ; Jump if less than 'a' to check for numeric character
    CMP AL, 'z'         ; Compare AL with 'z'
    JG CHECK_NUMBER     ; Jump if greater than 'z' to check for numeric character
    JMP PRINT_SMALL     ; Otherwise, print as small letter

CHECK_NUMBER:
    CMP AL, '0'         ; Compare AL with '0'
    JL PRINT_UNKNOWN    ; Jump if less than '0' to print as unknown character
    CMP AL, '9'         ; Compare AL with '9'
    JG PRINT_UNKNOWN    ; Jump if greater than '9' to print as unknown character
    JMP PRINT_NUMBER    ; Otherwise, print as numeric character

PRINT_CAPITAL:
    ; Print message "Capital Letter"
    MOV AH, 09H         ; DOS function 09H - Print string
    LEA DX, CAPITAL_MSG ; Load address of CAPITAL_MSG into DX
    INT 21H             ; Call interrupt 21H to print capital letter message
    JMP END_PROGRAM     ; Jump to end of program

PRINT_SMALL:
    ; Print message "Small Letter"
    MOV AH, 09H         ; DOS function 09H - Print string
    LEA DX, SMALL_MSG   ; Load address of SMALL_MSG into DX
    INT 21H             ; Call interrupt 21H to print small letter message
    JMP END_PROGRAM     ; Jump to end of program

PRINT_NUMBER:
    ; Print message "It is a number"
    MOV AH, 09H         ; DOS function 09H - Print string
    LEA DX, NUMBER_MSG  ; Load address of NUMBER_MSG into DX
    INT 21H             ; Call interrupt 21H to print numeric character message
    JMP END_PROGRAM     ; Jump to end of program

PRINT_UNKNOWN:
    ; Print message "Unknown"
    MOV AH, 09H         ; DOS function 09H - Print string
    LEA DX, UNKNOWN_MSG ; Load address of UNKNOWN_MSG into DX
    INT 21H             ; Call interrupt 21H to print unknown character message

END_PROGRAM:
    ; Exit the program
    MOV AH, 4CH         ; DOS function 4CH - Terminate with return code
    INT 21H             ; Call interrupt 21H to terminate the program

MAIN ENDP
END MAIN
