.ORIG X4000
Mul:

	; Your code here. Remember to save the registers that you will use to subroutine-specific labels, and then load them just before the RET command.			
	; Registers backup
	ST R0 R0_SAVE_MUL
	ST R1 R1_SAVE_MUL
	ST R3 R3_SAVE_MUL
	ST R4 R4_SAVE_MUL
	ST R5 R5_SAVE_MUL
	ST R7 R7_SAVE_MUL

	; Registers initialization
	INIT:
		AND R3 R3 #0
		AND R4 R4 #0
		AND R5 R5 #0

	; Check if R0 or R1 is zero
	ADD R0 R0 #0 ; If R0 = 0 
	BRz RETURN_ZERO ; Jump to lable RETURN_ZERO because 0*X=0
	ADD R1 R1 #0 ; If R1 = 0 
	BRz RETURN_ZERO ; Jump to lable RETURN_ZERO because 0*X=0

	; Intialize R2
	AND R2 R2  #0 ; R2=0

	; Check if any of the registers is negative and store that info
	CHECK_FOR_NEGATIVES:
		ADD R0 R0 #0; CC register will save the sign of bit that indicates if the value is N/P/Z
		BRn R0_IS_NEGATIVE; If R0 is negative jump to lable R0_IS_NEGATIVE
	CHECK_FOR_NEGATIVES_R1:
		ADD R1 R1 #0; CC register will save the sign of bit that indicates if the value is N/P/Z
		BRn R1_IS_NEGATIVE; If R1 is N Jump to lable R1_IS_NEGATIVE
		BR MUL_MAIN_LOOP; Else, jump to MUL_MAIN_LOOP

	; If R0 is negative
	R0_IS_NEGATIVE:
		ADD R3 R3 #1; R3 = 1 indicates that R0 is negative
		NOT R0 R0
		ADD R0 R0 #1
		BR CHECK_FOR_NEGATIVES_R1

	R1_IS_NEGATIVE:
		ADD R3 R3 #1 ; R3++ which indicates that R1 is negative
		NOT R1 R1 
		ADD R1 R1 #1

	; Main loop of mul, we add R1, R0 times
	MUL_MAIN_LOOP:
		ADD R2 R2 R1 ; R2+=R1
		ADD R0 R0 #-1
		BRz RETURN
		BR MUL_MAIN_LOOP

	; Check if the final result should be negative or positive depending on the content of R3
	RETURN:
		ADD R3 R3 #0 ; If R0 and R1 are positive
		BRz BACKUPS
		ADD R3 R3 #-2 ; If R0 and R1 are negative
		BRz BACKUPS

	; If the result should be negative, negate it
	NEGATIVE_RESULT:
		NOT R2 R2
		ADD R2 R2 #1
		BR BACKUPS

	; If the result is zero 
	RETURN_ZERO:
		AND R2 R2 #0 ; R2 = 0

	; Registers backup
	BACKUPS:
		LD R0 R0_SAVE_MUL
		LD R1 R1_SAVE_MUL
		LD R3 R3_SAVE_MUL
		LD R4 R4_SAVE_MUL
		LD R5 R5_SAVE_MUL
		LD R7 R7_SAVE_MUL

RET	
; Put your various labels here, between RET and .END.
R0_SAVE_MUL .FILL #0
R1_SAVE_MUL .FILL #0
R3_SAVE_MUL .FILL #0
R4_SAVE_MUL .FILL #0
R5_SAVE_MUL .FILL #0
R7_SAVE_MUL .FILL #0

.END