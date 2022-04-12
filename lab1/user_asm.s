
	IMPORT SVC_Handler_Main
	EXPORT SYS_PRINT_STR
	EXPORT SVC_Handler
	EXPORT ASM_Switch_To_Unprivileged	
	
	AREA |.text|, CODE, READONLY, ALIGN=2
    THUMB
	REQUIRE8
    PRESERVE8

; @brief  This function handles SVCall exception.
; @param  None
; @retval None
 
SYS_PRINT_STR
    MOV R1,R0
	swi 0x01
	
SVC_Handler
    MOV   R7,R1 
	TST   LR, #4
	MRSEQ R1, MSP
	MRSNE R1, PSP
	;r1 <- sp
	LDR   R0, [R1,#24]
	;r0 <- pc
	SUB   R0, 2
	;r0 <- instruction pointer
	LDR   R1, [R0]
	; r1 <- instruction
	AND   R0, R1, 0xFF
	MOV   R1,R7
	B     SVC_Handler_Main	
	
ASM_Switch_To_Unprivileged	
	MRS     R0, control
	ORR     R0, #1 
	MSR     control, R0
	BX      LR



	END