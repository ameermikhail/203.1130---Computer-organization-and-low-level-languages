.orig x4320
PrintNum:

	; Registers backup
	ST R1,R1_SAVE_PRINTNUM
	ST R3,R3_SAVE_PRINTNUM
	ST R4,R4_SAVE_PRINTNUM
	ST R5,R5_SAVE_PRINTNUM
	ST R6,R6_SAVE_PRINTNUM
	ST R7,R7_SAVE_PRINTNUM

	; Printing the max negative case
	LD R5, PRINTNUM_MAX_NUMBER
	ADD R5,R0,R5
	ADD R5,R5,#1
	Brnp PRINTNUM_ZERO_TEST
	LD R5 PRINTNUM_ZERO
	ADD R0,R5,#-3
	OUT
	ADD R0,R5,#3
	OUT
	ADD R0,R5,#2
	OUT
	ADD R0,R5,#7
	OUT
	ADD R0,R5,#6
	OUT
	ADD R0,R5,#8
	OUT
	BR PRINTNUM_END

	; Printing the zero case
	PRINTNUM_ZERO_TEST:
		ADD R0,R0,#0
		Brnp PRINTNUM_MINUS_TEST
		ADD R3,R0,#0
		LD R0, PRINTNUM_ZERO
		OUT
		ADD R0,R3,#0
		Br PRINTNUM_END

	; Printing minus symbol if the number is negative
	PRINTNUM_MINUS_TEST:
		ADD R0,R0,#0
		Brzp PRINTNUM_TEST_POSITIVE
		ADD R2,R0,#0
		LD R0, PRINTNUM_MINES_VALUE
		OUT
		ADD R0,R2,#0
		NOT R0,R0
		ADD R0,R0,#1
	
	PRINTNUM_TEST_POSITIVE:
		ADD R4,R0, #0
		LD R1, PRINTNUM_MAX_TEN_POWER_NUMBER

	; Cheching if ten to the power x is bigger than the number
	PRINTNUM_PRINT_LOOP:
		NOT R5,R1
		ADD R5,R5, #1
		ADD R2,R1, #0
		Brz PRINTNUM_END:
		ADD R6,R0, #0
		ADD R0,R6, #0
		ADD R5,R5, R4
		Brn PRINTNUM_DIVIDING_R1

	; Checking if there is zero to quit the loop
	ADD R6,R0, #0
	ADD R0,R6, #0

	; Printing R0 biggest digit
	LD R5, PRINTNUM_DIV_PTR
	JSRR R5
	LD R5, PRINTNUM_ZERO
	ADD R0,R2, R5
	OUT
	ADD R6,R3, #0

	; Dividing R1 by 10
	PRINTNUM_DIVIDING_R1:
		ADD R0,R1, #0
		AND R1,R1,#0
		ADD R1,R1,#10
		LD R5, PRINTNUM_DIV_PTR
		JSRR R5
		ADD R1,R2, #0
		ADD R0,R6, #0
		Br PRINTNUM_PRINT_LOOP

	; Putting previous values
	PRINTNUM_END:
		LD R0,R0_SAVE_PRINTNUM
		LD R1,R1_SAVE_PRINTNUM
		LD R2,R2_SAVE_PRINTNUM
		LD R3,R3_SAVE_PRINTNUM
		LD R4,R4_SAVE_PRINTNUM
		LD R5,R5_SAVE_PRINTNUM
		LD R6,R6_SAVE_PRINTNUM
		LD R7,R7_SAVE_PRINTNUM

RET
; Put your various labels here, between RET and .END.
R0_SAVE_PRINTNUM .fill #0
R1_SAVE_PRINTNUM .fill #0
R3_SAVE_PRINTNUM .fill #0
R2_SAVE_PRINTNUM .fill #0
R4_SAVE_PRINTNUM .fill #0
R5_SAVE_PRINTNUM .fill #0
R6_SAVE_PRINTNUM .fill #0
R7_SAVE_PRINTNUM .fill #0
PRINTNUM_DIV_PTR .fill x4064
PRINTNUM_MINES_VALUE .fill #45
PRINTNUM_ZERO .fill #48
PRINTNUM_MAX_TEN_POWER_NUMBER .fill #10000
PRINTNUM_MAX_NUMBER .fill #32767

.end