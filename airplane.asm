;Darren Butler, Joachim Isaac
		.MODEL 	small
		.STACK 	100h
		.DATA
		.CODE


; airplane code starts here, assuming DX has its position
DPLANE  PROC 	NEAR
;draws the airplane
	push 	AX
	push	BX
	push	CX
	push	DX
;position tail
	MOV 	AH,2	;sets cursor in a specified screen position
	MOV 	BH,0	;define screen page to be used
	PUSH 	DX	; saves position for next line
	INT 	10H	
	mov 	dl,0dch	; prints 
	mov 	ah,2
       	int 	21h
       	mov 	dl,20h	; prints space
       	int 	21h
	mov 	dl,0ddh	; prints 
       	int 	21h
;position body
	POP   	DX
	ADD 	DH,1	;sets cursor in the next line (uses the same column)
	INT 	10H
	PUSH 	DX	; saves position for next line
	mov 	dl,0dbh ; prints 
      	int 	21h
       	mov 	dl,0dbh
	int 	21h
       	mov 	dl,0dbh
       	int 	21h
       	mov 	dl,010h	;prints  
       	int 	21h
;position wing
	POP   	DX
	ADD 	DH,1	;sets cursor in the next line (uses the same column)
	INT 	10H
       	mov 	dl,20h 	; prints space
       	int 	21h
       	mov 	dl,20h
       	int 	21h
       	mov 	dl,0ddh	;prints 
       	int 	21h
;restore registers
	pop	dx
	pop cx
	pop	bx
	pop ax
	ret
DPLANE	ENDP	




;----------------------------------------------------------------------------
EPLANE  PROC 	NEAR
;erases the airplane
	push 	AX
	push	BX
	push	CX
	push	DX
;position tail
	MOV 	AH,2	;sets cursor in a specified screen position
	MOV 	BH,0	;define screen page to be used
	PUSH 	DX	; saves position for next line
	INT 	10H	
	mov 	dl,020h	; prints 
	mov 	ah,2
    int     21h
    mov     dl,20h	; prints space
       	int 21h
	mov 	dl,020h	; prints 
       	int 	21h
;position body
	POP   	DX
	ADD 	DH,1	;sets cursor in the next line (uses the same column)
	INT 	10H
	PUSH 	DX	; saves position for next line
	mov 	dl,020h ; prints 
      	int 	21h
       	mov 	dl,020h
	int 	21h
       	mov 	dl,020h
       	int 	21h
       	mov 	dl,020h	;prints  
       	int 	21h
;position wing
	POP   	DX
	ADD 	DH,1	;sets cursor in the next line (uses the same column)
	INT 	10H
       	mov 	dl,20h 	; prints space
       	int 	21h
       	mov 	dl,20h
       	int 	21h
       	mov 	dl,020h	;prints 
       	int 	21h
;restore registers
	pop	dx
	pop 	cx
	pop	bx
	pop 	ax
	ret
EPLANE	ENDP	; end of airplane code

Main:	mov		ax,@data
		mov		ds,ax		
		
		;erase the screen
		mov		ax,600H
		mov		bh,7
		mov		cx,0
		mov		dx,184FH
		int		10h
		
		;Set intial values for plane
		mov		dh,12
		mov		dl,12 ;DH is row number, Dl is column number
		;Draw plane in initial position		
		call	DPLANE

start:	;Read in value to Al
		MOV		ah,7
		int		21H
		
		;Compare with enter
		cmp		al, 13		
		;jump if equal to enter 
		je		done
		
		;Compare with w
		cmp		al,"w"
		;jump to move up instruction if equal
		je up
		
		;Compare with z
		;jmp to move down instruction if equal
		cmp		al,"z"
		je		down 
		
		;Compare with a
		;jmp to move left instruction if equal
		cmp		al,"a"
		je		left
		
		;Compare with s
		;jmp to move right instruction if equal
		cmp		al,"s"
		je		right
			
up:		;move up
		
		call	eplane
		sub		dh,3
		call 	dplane
		jmp 	start
down:	;move down
		
		call	eplane
		add		dh,3
		call 	dplane
		jmp start
left:	;move left
		
		call	eplane
		sub		dl,3
		call 	dplane
		jmp start
right:	;move right
		
		call	eplane
		add		dl,3
		call 	dplane
		jmp start

		;mov		Ah,7
		;int		21H
		;call	EPLANE
		;mov		dl,20
		;mov		dh,20
		;call	DPLANE
		;NOTE: SET BOUNDARIES 
		
		
		
done:
		;erase the screen
		mov		ax,600H
		mov		bh,7
		mov		cx,0
		mov		dx,184FH
		int		10h
		
		
		
		mov		ah,4ch
		int		21h
		END		Main