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
     
    ; For Promt Mesg 
    LEA DX, MSG_PROMPT
    MOV AH, 09H
    INT 21H
     
    ; For User Input 
    MOV AH, 01H
    INT 21H
    MOV USER_INPUT, AL

    ; For Newline
    LEA DX, MSG_NEWLINE
    MOV AH, 09H
    INT 21H

    ; Determine if the input is an uppercase letter
    MOV AL, USER_INPUT
    CMP AL, 'A'
    JB CHECK_IF_LOWERCASE  
    CMP AL, 'Z'
    JA CHECK_IF_LOWERCASE  

    ; Convert uppercase letter to lowercase
    OR AL, 00100000B       ; Set the 6th bit to convert to lowercase
    MOV USER_INPUT, AL

    ; Display the result for uppercase to lowercase conversion
    LEA DX, MSG_CAP_TO_SMALL
    MOV AH, 09H
    INT 21H

    ; Display the converted letter
    MOV DL, USER_INPUT
    MOV AH, 02H
    INT 21H

    ; Display newline
    LEA DX, MSG_NEWLINE
    MOV AH, 09H
    INT 21H

    JMP END_PROGRAM 

CHECK_IF_LOWERCASE:
    ; Check if the input is a lowercase letter
    CMP AL, 'a'
    JB DISPLAY_INVALID_INPUT  
    CMP AL, 'z'
    JA DISPLAY_INVALID_INPUT 

    ; Convert lowercase letter to uppercase
    AND AL, 11011111B      ; Clear the 6th bit to convert to uppercase
    MOV USER_INPUT, AL

    ; Display the result for lowercase to uppercase conversion
    LEA DX, MSG_SMALL_TO_CAP
    MOV AH, 09H
    INT 21H

    ; Display the converted letter
    MOV DL, USER_INPUT
    MOV AH, 02H
    INT 21H

    ; Display newline
    LEA DX, MSG_NEWLINE
    MOV AH, 09H
    INT 21H

    JMP END_PROGRAM 

DISPLAY_INVALID_INPUT:
    ; Display invalid input message
    LEA DX, MSG_INVALID_INPUT
    MOV AH, 09H
    INT 21H

    ; Display newline
    LEA DX, MSG_NEWLINE
    MOV AH, 09H
    INT 21H

END_PROGRAM:
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
