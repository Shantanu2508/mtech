.include "m328Pdef.inc"

	ldi r17, 0b11000011 ; input pin 2,3,4,5
	out DDRD,r17		; declaring pins as input
Start:

	in r17,PIND

	
	ldi r20, 0b00000010 ; counter set to 2
	rcall loopin
	
	ldi r21,0b00000001	; mask 
	
	; read pin 2 
	mov r18, r17		
	and r18,r21 		; x
	
	; read pin 3
	lsr r17
	mov r19, r17
	and r19, r21 		; y
	
	; read pin 4
	lsr r17
	mov r20, r17
	and r20, r21 		; z
	
	; read pin 5
	lsr r17
	mov r22, r17
	and r22, r21		; w
	
	mov r23, r18
	com r23				; x'
	and r23, r19		; x'y
	
	com r19				;y'
	and r19, r20		;y'z
	
	and r18,r20			;xz
	and r22, r18		;xzw
	
	or r22, r19			;xzw + y'z
	or r22, r23			;xzw + y'z + x'y
	
	ldi r20, 0b00000101
	rcall loopout

	ldi r16, 0b00100000 
	out DDRB,r16		;set pin 13 as output
	out PORTB, r22

	rjmp Start
	
	
loopin: lsr r17
		dec r20
		brne loopin
		ret
loopout: lsl r22
		 dec r20
		 brne loopout
		 ret


	

