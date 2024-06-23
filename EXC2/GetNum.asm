.orig x41F4
GetNum:

	; Registers backup
	ST R0,R0_SAVE_GETNUM 
	ST R1,R1_SAVE_GETNUM
	ST R3,R3_SAVE_GETNUM  
	ST R4,R4_SAVE_GETNUM
	ST R5,R5_SAVE_GETNUM 
	ST R6,R6_SAVE_GETNUM  
	ST R7,R7_SAVE_GETNUM 

	; update R4 to become

	; Arguments: None.
	; Output: R2 = A number, as input by the user. Actual numerical value, NOT ASCII value!
	LEA R0,ENTERNUM
	PUTS

	NEWNUM:
		AND R1,R1,#0
		AND R2,R2,#0
		AND R3,R3,#0
		AND R4,R4,#0
		AND R5,R5,#0
		AND R6 R6 #0
		
	SCAN_FIRST_CHAR: ; scan the first char of the input in R0 because it is special case
		GETC 
		OUT
		LD R3 MINUS_CHAR
		ADD R3,R3 R0 ; ; check if the first character is the sign minus
		BRz NEGATIVE_NUMBER
		BR TEST_INPUT ; IF IT NOT '-' THEN TeST IF IT LEGAL INPUT
		
		
	GET_NEXTCHAR:
		GETC
		OUT

	TEST_INPUT:
		; check if we scanned a new line
		ADD R3,R0,#-10
		BRZ INPUT_DONE ; if yes, jump to INPUT_DONE
		
		ADD R5,R5,#0 
		BRN GET_NEXTCHAR 
		
		LD R3,ZERO_VALUE
		ADD R3 R3 R0 ; R3 = R0-ZERO_VALUE
		BRn ILLEGAL_FLAG
		LD R3 NINE_VALUE
		ADD R3 R3 R0
		BRp ILLEGAL_FLAG
		
		LD R3 ZERO_VALUE
		ADD R0 R0 R3 ; if the input is legal, then convert R0 to its real number value
		
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
	OUR_NUM:
		ADD R4,R4,#0 ; IF R4=0 THEN WE DIDNOT DO THE SWITCH
		BRZ SWITCH
		ADD R1,R1,#0 ; if the number is positive, check if it overflowed into a negative number, if yes there's overflow
		BRzp OVERFLOW_NEG
		BRn OVERFLOW_POS ; if the number is negative, check if it overflowed into a positive number. if yes, there's overflow
		BR GET_NEXTCHAR
		;if the number is still zero, just go back

	SWITCH:		; THIS STEP JUST IN THE FIRST NUMBER ; WE DO R1=R0  AND WHEN R1=0
		ADD R1,R1,R0 ; R1 = R0
		ADD R4,R4,#1 ; R4 = 1
		ADD R2,R2,#0 
		BRZ GET_NEXTCHAR ; if R2 iz zero, get next char
		NOT R1,R1 ; else Negate R1 and get next char
		ADD R1,R1,#1
		BR GET_NEXTCHAR 
		
	NEGATIVE_NUMBER:
		ADD R2,R2,#1 ; A FLAG R2=1 WHEN WE HAVE A NEGATIVE NUMBER
		BR GET_NEXTCHAR


	OVERFLOW_NEG: ; R1 is currently positive
	ST R0 R0_TEMP
	AND R0 R0 #0
	ADD R0 R0 #10
	LD R6 MUL_PTR
	ST R2 R2_TEMP
	JSRR R6 ; R2 = R1 * 10
	ADD R1 R2 #0
	LD R2 R2_TEMP
	LD R0 R0_TEMP
	BRn OVERFLOW_FLAG
	ADD R1 R1 R0
	BRn OVERFLOW_FLAG
	BR GET_NEXTCHAR 

	OVERFLOW_POS: ; the num is negative
	ST R0 R0_TEMP
	AND R0 R0 #0
	ADD R0 R0 #10
	ST R2 R2_TEMP
	LD R6 MUL_PTR
	JSRR R6
	ADD R1 R2 #0
	LD R2 R2_TEMP
	LD R0 R0_TEMP
	ADD R1 R1 #0
	BRp OVERFLOW_FLAG
	NOT R3 R0
	ADD R3 R3 #1
	ADD R1 R1 R3
	BRp OVERFLOW_FLAG
	BR GET_NEXTCHAR



	ILLEGAL_FLAG:		;A FLAG =-1 WHEN WE HAVE ILLEGAL INPUT 
		AND R5,R5,#0
		ADD R5,R5,#-1
		BR GET_NEXTCHAR

	OVERFLOW_FLAG:		; A FLAG R5=1 WHEN WE HAVE OVERFLOW
		ADD R5,R5,#0
		ADD R5,R5,#1
		BR GET_NEXTCHAR


	ILLEGAL_INPUT:
		LEA R0,NOT_NUM_MES
		PUTS
		BR NEWNUM

	OVERFLOW_MES:
		LEA R0,OVERFLOW
		PUTS
		BR NEWNUM 

	INPUT_DONE:
		ADD R4,R4,#0
		BRZ ILLEGAL_INPUT 
		ADD R5,R5,#0
		BRN ILLEGAL_INPUT ; IF R5=-1 WE HAVE ILLEGAL INPUT 
		BRP OVERFLOW_MES ; IF R5=1 WE HAVE OVERFLOW  

	;IF R5=0 THE WE HAVE A NUMBER
	ADD R2 R2 #0
	BRp MAYBE_NEGATE
	AND R2,R2,#0   ;R2=0
	ADD R2,R2,R1   ;R2=R1
	BR END_FUNC

	MAYBE_NEGATE:
	ADD R1 R1 #0
	BRp DO_NEGATE
	ADD R2 R1 #0
	BR END_FUNC

	DO_NEGATE
	NOT R1 R1
	ADD R1 R1 #1
	ADD R2 R1 #0

	; Putting previous values
	END_FUNC:
	LD R0,R0_SAVE_GETNUM
	LD R1,R1_SAVE_GETNUM
	LD R3,R3_SAVE_GETNUM
	LD R4,R4_SAVE_GETNUM
	LD R5,R5_SAVE_GETNUM
	LD R6,R6_SAVE_GETNUM
	LD R7,R7_SAVE_GETNUM

RET
; Put your various labels here, between RET and .END.
ZERO_VALUE .fill #-48
NINE_VALUE .fill #-57
MINUS_CHAR .fill #-45

OVERFLOW .stringz "Error! Number overflowed! Please enter again: "
ENTERNUM .stringz "Enter an integer number: "
NOT_NUM_MES .stringz "Error! You did not enter a number. Please enter again: "
R0_SAVE_GETNUM .Fill #0
R1_SAVE_GETNUM .Fill #0
R2_SAVE_GETNUM .Fill #0
R3_SAVE_GETNUM .Fill #0
R4_SAVE_GETNUM .Fill #0
R5_SAVE_GETNUM .Fill #0
R6_SAVE_GETNUM .Fill #0
R7_SAVE_GETNUM .Fill #0
MUL_PTR .FILL X4000
R2_TEMP .FILL #0
R0_TEMP .FILL #0

.end
  