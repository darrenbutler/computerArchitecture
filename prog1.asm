;Darren Butler
	  .MODEL 	small
	  .STACK 	100h
	  .DATA 
Var	  DB	   "This is John PC adding two number: 25 + 53 =", 13,10,'$';string
	  .CODE
Main: mov 		ax,@data	;these two instructions will always be
	  mov 		ds,ax		;in the beginning of the program
	  
	  mov		ah,9		;these 3 instructions print
	  lea		dx, Var		;the string Var to the screen
	  int		21h			;screen
	  
	  mov		al,25		;these two instructions show
	  mov		bl,53		;how to initialize to the screen
	  add		al,bl		;and this one, how to add
	  
	  mov 		dl,al
	  mov		ah,2		;these two instructions
	  int 		21h			;print whatever is in dl
	  
	  mov		ah,4ch		;these two instructions
	  int		21h			;end the program execution
	  END		Main
	  
	