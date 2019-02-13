;Darren Butler
		.MODEL 	small
		.STACK 	100h
		.DATA
		
less 	DB	   	"Nothing to pay", 13,10,'$';string
more	DB		"Required to pay one cent", 13,10,'$';string
		.CODE
Main:	mov		ax,@data
		mov		ds,ax
		
		;Read a number
		mov		AH,1  								;Value stored in AL
		int 	21h									;reads in value
		sub 	al,30H								;converts ASCII to decimal
		
		;Copy instruction
		MOV 	BL, AL 								;Move value stored in AL to BL
		
		;Read another number
		mov		AH,1								;Read a new number into register AL
		int 	21h
		sub 	al,30H								;converts ASCII to decimal
		
		;Add values
		add		AL, BL
		
		;Compare 
		CMP		AL,10
		jl		noPay
		
		;For when values add to more than 10 print the more message
		mov		AH, 9
		lea		DX, more 
		int		21H
		jmp		done

		;For when input is less than 10 print less
noPay:	mov		AH,9
		lea		DX, less
		int		21H;
		jmp 	done
	
		
done:		mov		ah,4ch
		int		21h
		END		Main

		
	  
