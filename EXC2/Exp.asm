.ORIG X40C8
Exp:

	; Your code here. Remember to save the registers that you will use to subroutine-specific labels, and then load them just before the RET command.
	; Registers backup
	ST R0 R0_SAVE_EXP
	ST R1 R1_SAVE_EXP
	ST R3 R3_SAVE_EXP
	ST R4 R4_SAVE_EXP
	ST R5 R5_SAVE_EXP
	ST R6 R6_SAVE_EXP
	ST R7 R7_SAVE_EXP

	; R3 = address of Mul
	AND R3 R3 #0
	LD R3 MUL_PTR

	; Check if R0 is zero
	ADD R0 R0 #0 ; Update the CC with R0 sign(P,Z,N)
	BRz R0_ZERO ; If R0=0 go to lable R0_ZERO

	R0_ZERO: ; If R1 is zero too, this is illegal
	ADD R1 R1 #0 ; Update the CC with R1 sign(P,Z,N)
	BRnz ILLEGAL_INPUT ; If R0=0&&R1=0 go to R0_AND_R1_ZERO
	BR CHECK_ILLEGAL2 

	ILLEGAL_INPUT: 
		LD R2 ILLEGAL ; Fill -1 into R2
		BR END_FUNCTION

	CHECK_ILLEGAL2: ; if R0 is negative and R1 is negative the input is also illegal
		ADD R0 R0 #0
		BRn ILLEGAL_INPUT
		ADD R1 R1 #0
		BRn ILLEGAL_INPUT

	; Init R2 
	AND R2 R2 #0
	ADD R2 R2 #1
	ADD R1 R1 #0 ; If the power is 0 then we can end the program
	BRz END_FUNCTION

	; Init R4 which will be the counter
	CONTINUE:
		AND R4 R4 #0
		ADD R4 R4 R1 ; R4 = R1
		ADD R1 R0 #0 ; R1 = R0
		LD R3 MUL_PTR
		ADD R2 R0 #0 ; R2 = R0

	; While R4 >0, multiply the current reuslt (R2) by R0
	MAIN_LOOP_EXP:
		ADD R4 R4 #-1
		BRz END_FUNCTION
		JSRR R3 ; R2 = R2*R0
		ADD R0 R2 #0
		BR MAIN_LOOP_EXP


	END_FUNCTION:

	; Registers backup
	LD R0 R0_SAVE_EXP
	LD R1 R1_SAVE_EXP
	LD R3 R3_SAVE_EXP
	LD R4 R4_SAVE_EXP
	LD R5 R5_SAVE_EXP
	LD R6 R6_SAVE_EXP
	LD R7 R7_SAVE_EXP

RET
; Put your various labels here, between RET and .END.
ILLEGAL .FILL -1
MUL_PTR .FILL x4000

R0_SAVE_EXP .FILL #0
R1_SAVE_EXP .Fill #0
R3_SAVE_EXP .Fill #0
R4_SAVE_EXP .Fill #0
R5_SAVE_EXP .Fill #0
R6_SAVE_EXP .Fill #0
R7_SAVE_EXP .Fill #0

.END