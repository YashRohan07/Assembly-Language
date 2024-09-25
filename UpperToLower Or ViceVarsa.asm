.MODEL SMALL
.STACK 100H

.DATA
    MSG_PROMPT DB 'Enter a letter: $'           
    MSG_CAP_TO_SMALL DB 'In lowercase it is: $' 
    MSG_SMALL_TO_CAP DB 'In uppercase it is: $' 
    MSG_INVALID_INPUT DB 'Invalid input! Please enter a letter.$' 
    USER_INPUT DB ?                             
    MSG_NEWLINE DB 13, 10, '$'                  

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Get user input
    CALL GetUserInput

    ; Convert case based on input
    CALL ConvertCase

    ; Exit program
    MOV AH, 4CH
    INT 21H
MAIN ENDP

; Procedure to get user input
GetUserInput PROC
    ; Display prompt message
    LEA DX, MSG_PROMPT
    MOV AH, 09H
    INT 21H

    ; Read user input
    MOV AH, 01H
    INT 21H
    MOV USER_INPUT, AL

    ; Newline for better readability
    LEA DX, MSG_NEWLINE
    MOV AH, 09H
    INT 21H
    RET
GetUserInput ENDP

; Procedure to convert case of the input
ConvertCase PROC
    MOV AL, USER_INPUT

    ; Check if the input is an uppercase letter
    CMP AL, 'A'
    JB CHECK_IF_LOWERCASE  
    CMP AL, 'Z'
    JA CHECK_IF_LOWERCASE  

    ; Convert uppercase letter to lowercase
    OR AL, 00100000B       ; Set the 6th bit to convert to lowercase
    MOV USER_INPUT, AL

    ; Display result for uppercase to lowercase conversion
    LEA DX, MSG_CAP_TO_SMALL
    MOV AH, 09H
    INT 21H

    ; Display converted letter
    MOV DL, USER_INPUT
    MOV AH, 02H
    INT 21H

    ; Newline after displaying the result
    LEA DX, MSG_NEWLINE
    MOV AH, 09H
    INT 21H
    JMP END_CONVERT 

CHECK_IF_LOWERCASE:
    ; Check if the input is a lowercase letter
    CMP AL, 'a'
    JB DISPLAY_INVALID_INPUT  
    CMP AL, 'z'
    JA DISPLAY_INVALID_INPUT 

    ; Convert lowercase letter to uppercase
    AND AL, 11011111B      ; Clear the 6th bit to convert to uppercase
    MOV USER_INPUT, AL

    ; Display result for lowercase to uppercase conversion
    LEA DX, MSG_SMALL_TO_CAP
    MOV AH, 09H
    INT 21H

    ; Display converted letter
    MOV DL, USER_INPUT
    MOV AH, 02H
    INT 21H

    ; Newline after displaying the result
    LEA DX, MSG_NEWLINE
    MOV AH, 09H
    INT 21H
    JMP END_CONVERT 

DISPLAY_INVALID_INPUT:
    ; Display invalid input message
    LEA DX, MSG_INVALID_INPUT
    MOV AH, 09H
    INT 21H

    ; Newline after displaying the invalid input message
    LEA DX, MSG_NEWLINE
    MOV AH, 09H
    INT 21H

END_CONVERT:
    RET
ConvertCase ENDP

END MAIN
