;Darren Butler, Joachim Isaac
		.MODEL 	small
		.STACK 	100h
		.DATA
		.CODE
DOWN	PROC 	NEAR
		PUSH	AX ;The values we come in with would be the same
		PUSH 	BX
		PUSH	CX
		PUSH	DX
		
		MOV 	BP, SP
		MOV		AX, [BP + 10] ;mOVE THE CONTENTS AT THIS MEMEORY ADDRESS TO  BX
		
		MOV		Cl, 10	;So we can divide by 10
		MOV		AH, 0	;Make zero
		DIV		Cl		;Divide by AX by Cl, Remainder does in AH amd quotient in AL
		MOV		DL,AL
		MOV		BL, AH
		
		ADD		DL,30H	;Convert to ASCII
		MOV		AH,2	;Print out first digit
		INT		21H
		
		MOV		DL,BL ;MOve second digit to DL
		ADD		DL,30H	;Convert to ASCII
		MOV		AH,2	;Print out first digit
		INT		21H

		MOV		[BP+10], AX
		
		POP		DX
		POP		CX
		POP		BX
		POP		AX
		RET
DOWN	ENDP
Main:	mov		ax,@data
		mov		ds,ax
		
		;Set register Cl for the total to zero
		mov		Cl,0
		
		;Set Dl to 0 as loop control variable
		mov		Dl, 0

LUP:	CMP		Dl,3 ;Loop will run three times
		je		divide ;Go to label done if Dl is qual to 3
		;Reads the first number number
		mov		AH,1  								;Value stored in AL
		int 	21h									;reads in value
		sub 	al,30H								;converts ASCII to decimal
		
		;Copies first number into BL
		MOV 	BL, AL 								;Move value stored in AL to BL
		
		;Reads in another number
		mov		AH,1								;Read a new number into register AL
		int 	21h
		sub 	al,30H								;converts ASCII to decimal
		
		;Muliply values and stores it in AX (A and Ah)
		mul		BL
		
		;Add the product to Cl (the total)
		add 	Cl, Al		
		
		;Add 1 to the loop control varible Dl
		add		Dl,1		
		
		jmp		Lup ; Jump to go back to the beginning of the loop

divide:	;Move the total(Cl) to Ax then divide Ax by 3 
		mov		Al,Cl 
		mov		Ah, 0 ;Make sure Ah is 0 before division
		div		Dl ;Dl should be equal to 3
		
		;Result of division goes in Al
		PUSH	AX
		CALL	DOWN
		POP		AX
		
	

done:	mov		ah,4ch
		int		21h
		END		Main