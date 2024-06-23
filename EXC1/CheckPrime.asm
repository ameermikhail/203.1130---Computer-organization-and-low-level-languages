.ORIG X412C
CheckPrime:	

	; Your code here. Remember to save the registers that you will use to subroutine-specific labels, and then load them just before the RET command.	
	; Registers backup
	ST R1 R1_SAVE_CHECKPRIME
	ST R3 R3_SAVE_CHECKPRIME
	ST R6 R6_SAVE_CHECKPRIME
	ST R4 R4_SAVE_CHECKPRIME
	ST R5 R5_SAVE_CHECKPRIME
	ST R7 R7_SAVE_CHECKPRIME

	LD R6  DIV_PTR ; R6 = address of div

	; If the input is 0 or 1 or 2
	ADD R0  R0  #0
	BRz IS_NOT_PRIME
	ADD R4  R0  #-1
	BRz IS_NOT_PRIME
	ADD R4  R0  #-2
	BRz IS_PRIME

	; R1 is the smallest number we will divide by which is 2
	AND R1 R1 #0
	ADD R1 R1 #2 
	AND R4 R4 #0 ; R4 will hold the negative value of the current num we're diving by
	ADD R4 R4 #-2

	; Divide R0 by R1, R1 goes from 2 to R0
	PRIME_LOOP:
		JSRR R6

	ADD R3  R3  #0 ; if the remaining is zero then the number is not prime
	BRz IS_NOT_PRIME
	ADD R1 R1 #1
	ADD R4 R4 #-1
	ADD R5 R0 R4 ; if R0 == R1 the loop should end and the num is prime
	BRz IS_PRIME
	BR PRIME_LOOP


	IS_NOT_PRIME: ; If the num isn't prime then R2 = 0
		AND R2  R2  #0
		BR EXIT
		IS_PRIME: ; else R2 =1
		AND R2  R2  #0
		ADD R2  R2  #1


	EXIT:

	; Registers backup
	LD R1 R1_SAVE_CHECKPRIME
	LD R3 R3_SAVE_CHECKPRIME
	LD R4 R4_SAVE_CHECKPRIME
	LD R5 R5_SAVE_CHECKPRIME
	LD R6 R6_SAVE_CHECKPRIME
	LD R7 R7_SAVE_CHECKPRIME

RET
; Put your various labels here, between RET and .END.
DIV_PTR .fill x4064

R1_SAVE_CHECKPRIME .fill #0
R3_SAVE_CHECKPRIME .fill #0
R4_SAVE_CHECKPRIME .fill #0
R5_SAVE_CHECKPRIME .fill #0
R6_SAVE_CHECKPRIME .fill #0
R7_SAVE_CHECKPRIME .fill #0

.END