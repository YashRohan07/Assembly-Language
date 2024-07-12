.MODEL SMALL
.STACK 100H

.DATA
    MSG1 DB 'Enter two characters (e.g., AC): $'   ; Prompt message
    NEWLINE DB 0AH, 0DH, '$'                      ; New line characters
    OUTPUT_MSG DB 0AH, 0DH, 'Output: $'            ; Output message

.CODE
MAIN PROC
    MOV AX, @DATA   ; Initialize data segment
    MOV DS, AX      ; Set DS to point to data segment

    ; Display prompt message
    MOV AH, 9       ; DOS function 9 - Print string
    LEA DX, MSG1    ; Load address of MSG1 into DX
    INT 21H         ; Call interrupt 21H to print prompt message

    ; Read first character
    MOV AH, 01H     ; DOS function 01H - Read character
    INT 21H         ; Call interrupt 21H to read a character
    MOV BL, AL      ; Store first character in BL

    ; Read second character
    MOV AH, 01H     ; DOS function 01H - Read character
    INT 21H         ; Call interrupt 21H to read a character
    MOV CL, AL      ; Store second character in CL

    ; Print input characters
    MOV AH, 9       ; DOS function 9 - Print string
    LEA DX, NEWLINE ; Load address of NEWLINE into DX
    INT 21H         ; Call interrupt 21H to print newline

    ; Print first input character
    MOV AH, 2       ; DOS function 2 - Print character
    MOV DL, BL      ; Move first character to DL
    INT 21H         ; Call interrupt 21H to print first character

    ; Print second input character
    MOV AH, 2       ; DOS function 2 - Print character
    MOV DL, CL      ; Move second character to DL
    INT 21H         ; Call interrupt 21H to print second character

    ; Print newline to separate input and output
    MOV AH, 9       ; DOS function 9 - Print string
    LEA DX, NEWLINE ; Load address of NEWLINE into DX
    INT 21H         ; Call interrupt 21H to print newline

    ; Print output characters in reverse order
    MOV AH, 2       ; DOS function 2 - Print character
    MOV DL, CL      ; Move second character to DL
    INT 21H         ; Call interrupt 21H to print second character

    ; Print first output character
    MOV AH, 2       ; DOS function 2 - Print character
    MOV DL, BL      ; Move first character to DL
    INT 21H         ; Call interrupt 21H to print first character

    ; Terminate the program
    MOV AH, 4CH     ; DOS function 4CH - Terminate with return code
    INT 21H         ; Call interrupt 21H to terminate the program

MAIN ENDP
END MAIN
