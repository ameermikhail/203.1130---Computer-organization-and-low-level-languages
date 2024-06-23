.ORIG x4384
Calculator:

	; Registers backup
	ST R0 R0_SAVE_CALC
	ST R1 R1_SAVE_CALC
	ST R2,R2_SAVE_CALC
	ST R3,R3_SAVE_CALC
	ST R4,R4_SAVE_CALC
	ST R5,R5_SAVE_CALC
	ST R6,R6_SAVE_CALC
	ST R7,R7_SAVE_CALC
	

	LEA R0 PRINT_LABEL
	PUTS ; Prints output to the user
	GETC ; Getting the user's input
	OUT	; Prints user's input
		
	ST R0 OPERATION_ASCII ; Store the operation in the operation_ascii
		
	LEA R0 NEW_LINE ; Prints a new line
	PUTS
		
	LD R0 OPERATION_ASCII ; R0 = operation value
		
	LD R4 PLUS_OP
	ADD R4 R4 R0
	BRz PLUS_LABEL
		
	LD R4 MINUS_OP
	ADD R4 R4 R0
	BRz MINUS_LABEL
		
	LD R4 MULT_OP
	ADD R4 R4 R0
	BRz MUL_LABEL
		
	LD R4 DIV_OP
	ADD R4 R4 R0
	BRz DIV_LABEL
		
	LD R4 EXP_OP
	ADD R4 R4 R0
	BRz EXP_LABEL
		
		
	PLUS_LABEL:
		LD R0 R0_SAVE_CALC
		ADD R3 R0 R1
		BR PRINT_NUMBER
		
	MINUS_LABEL:
		LD R0 R0_SAVE_CALC
		NOT R1 R1
		ADD R1 R1 #1
		ADD R3 R0 R1
		BR PRINT_NUMBER
		
	MUL_LABEL:
		LD R0 R0_SAVE_CALC
		LD R5 MUL_FUNCTION
		JSRR R5
		ADD R3 R2 #0
		BR PRINT_NUMBER
		
	DIV_LABEL:
		LD R0 R0_SAVE_CALC
		LD R5 DIV_FUNCTION
		JSRR R5
		ADD R3 R2 #0
		BR PRINT_NUMBER
		
	EXP_LABEL:
		LD R0 R0_SAVE_CALC
		LD R5 EXP_FUNCTION
		JSRR R5
		ADD R3 R2 #0
		BR PRINT_NUMBER
		
	PRINT_NUMBER:
		LEA R0 NEW_LINE
		PUTS
		LD R0 R0_SAVE_CALC
		LD R5 PRINT_FUNCTION
		JSRR R5
		LD R0 OPERATION_ASCII
		OUT 
		LD R0 R1_SAVE_CALC
		JSRR R5
		LD R0 OPERATION_ASCII
		LD R0 EQUAL_OP
		OUT
		ADD R0 R3 #0
		JSRR R5
		
	; Putting previous values
	LD R0 R0_SAVE_CALC
	LD R1 R1_SAVE_CALC
	LD R2,R2_SAVE_CALC
	LD R3,R3_SAVE_CALC
	LD R4,R4_SAVE_CALC
	LD R5,R5_SAVE_CALC
	LD R6,R6_SAVE_CALC
	LD R7,R7_SAVE_CALC

RET   
; Put your various labels here, between RET and .END.
PRINT_LABEL .STRINGZ "Enter an arithmetic operation: "

PLUS_OP .FILL #-43 ;The value 43 represent + in ASCII table
MINUS_OP .FILL #-45 ;The value 45 represent - in ASCII table
MULT_OP .FILL #-42 ;The value 42 represent * in ASCII table
DIV_OP .FILL #-47 ;The value 47 represent / in ASCII table
EXP_OP .FILL #-94 ;The value 94 represent ^ in ASCII table
EQUAL_OP .FILL #61 ;The value 61 represent = in ASCII table


R0_SAVE_CALC .FILL #0
R1_SAVE_CALC .FILL #0
R2_SAVE_CALC .FILL #0
R3_SAVE_CALC .FILL #0
R4_SAVE_CALC .FILL #0
R5_SAVE_CALC .FILL #0
R6_SAVE_CALC .FILL #0
R7_SAVE_CALC .FILL #0

OPERATION_ASCII .FILL #0
NEW_LINE .STRINGZ "\n"

MUL_FUNCTION .FILL X4000 ;Load the lable MUL_FUNCTION with mul function's addres
DIV_FUNCTION .FILL X4064 ;Load the lable DIV_FUNCTION with div function's addres
EXP_FUNCTION .FILL X40C8 ;Load the lable EXP_FUNCTION with exp function's addres
PRINT_FUNCTION .FILL x4320 ;Load the lable PRINT_FUNCTION with print function's addres

.end

