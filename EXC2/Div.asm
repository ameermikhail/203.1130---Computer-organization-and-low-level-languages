.ORIG X4064
Div:

	; Your code here. Remember to save the registers that you will use to subroutine-specific labels, and then load them just before the RET command.			
	; Registers backup
	ST R0 R0_SAVE_DIV
	ST R1 R1_SAVE_DIV
	ST R4 R4_SAVE_DIV
	ST R5 R5_SAVE_DIV
	ST R6 R6_SAVE_DIV
	ST R7 R7_SAVE_DIV

; Registers initialization
	AND R2,R2,#0 ; This register saves the value of the result 
	AND R3,R3,#0 ; This register saves the remainder of R0/R1
	AND R5,R5,#0 ; R5=0 we use this REGISTER as a counter
	
	ADD R1,R1,#0 ; Division by zero causes error and return R2 = R3 = -1 
	BRz DONE2
		
	ADD R0,R0,#0 ; If R0 is zero we can end the program
	BRz DONE1
		
	AND R4 R4 #0 ; Check if R0 and R1 is negative
	ADD R0 R0 #0
	BRn NEGATIVE_R0
	BR CHECK_IF_R1_IS_NEGATIVE
		
	NEGATIVE_R0: ; If R0 is negative then R4 =1
		ADD R4 R4 #1
		NOT R0 R0
		ADD R0 R0 #1
		ADD R5 R1 #0
		NOT R5 R5
		ADD R5 R5 #1
		
	CHECK_IF_R1_IS_NEGATIVE: ; If R1 is negative update R4
		ADD R1 R1 #0
		BRn NEGATIVE_R1
		ADD R5 R1 #0
		NOT R5 R5
		ADD R5 R5 #1
		
	BR DIVIDE_FUNCTION
	
	NEGATIVE_R1:
		ADD R4 R4 #1
		NOT R1 R1
		ADD R1 R1 #1
		ADD R5 R1 #0 ; R5=-R1
		NOT R5 R5
		ADD R5 R5 #1
	
	
	DIVIDE_FUNCTION:
		ADD R0 R0 R5 ; R1-=R0
		BRn NEGATIVE_RES ; If the result is negative we will go fix it
		ADD R2 R2 #1
		ADD R0 R0 #0
		BRz DONE1 ; If the result is zero we can end the program without further actions
		BR DIVIDE_FUNCTION
	
	
	NEGATIVE_RES: ; Get the right positive remaining
		ADD R3 R1 R0
		BR DONE1
	
	
	DONE2: ; If the input is invalid
		ADD R2 R2 #-1
		ADD R3 R3 #-1
	
	DONE1: ; Check if we have had negative input originally
		ADD R4 R4 #0
		BRz DONE3
		ADD R4 R4 #-2
		BRz DONE3
		
		NOT R2 R2 ; If we're here then R2 is negative
		ADD R2 R2 #1
		
	DONE3:
		LD R0 R0_SAVE_DIV
		LD R1 R1_SAVE_DIV
		LD R4 R4_SAVE_DIV
		LD R5 R5_SAVE_DIV
		LD R6 R6_SAVE_DIV
		LD R7 R7_SAVE_DIV

RET
; Put your various labels here, between RET and .END.
R0_SAVE_DIV .fill #0
R1_SAVE_DIV .fill #0
R4_SAVE_DIV .FILL #0
R5_SAVE_DIV .FILL #0
R6_SAVE_DIV .FILL #0
R7_SAVE_DIV .FILL #0 

.END