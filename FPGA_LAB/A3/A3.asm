
		
.include "m328Pdef.inc"

Start:
	ldi r17, 0b11000011 ; identifying input pins 2,3,4,5 - indicated by 0s
	out DDRD,r17		; declaring pins as input
	ldi r17, 0b11111111 ;
	out PORTD,r17		; activating internal pullup for pins 10,11,12,13  
	in r17,PIND

	ldi r16, 0b00100000 ;identifying output pins 13 - indicated by 1s
	out DDRB,r16		;declaring pins as output

	;Reading pin2
	lsr r17
	lsr r17				; Twice shift right to read pin 2
	mov r16, r17		; Backing up the portD content in r16
	ldi r20,0b00000001	; Mask for reading pin 2
	and r17,r20 		; Getting input from pin2 (input X)

	;Reading pin3
	mov r18,r16			; Retrieving the backup stored in r16
	lsr r18				; shift right to read pin 3
	and r18, r20 		; Getting the input from pin3 (input Y)

	;Reading pin4
	mov r19,r16			; Retrieving the backup stored in r16	
	lsr r19				; shift right to read pin 4
	and r19, r20 		; Getting the input from pin4 (input Z)
	
	;Reading pin4
	mov r21,r16			; Retrieving the backup stored in r16	
	lsr r21				; shift right to read pin 5
        and r21, r20 		; Getting the input from pin4 (input W)

	;Implementing the kmap expression
	mov r22,r17			; X
	mov r23,r18			; Y
	mov r24,r19         ; Z
	mov r25,r21         ; W   
	
	com r22 ;x'
	and r22,r23 ;x'y
	com r23 ;y'
	and r23,r24 ;y'z
	and r24,r17 ;xz
	and r24,r25 ;xzw
	or  r22,r23 ;x'y+y'z
	or  r22,r25 ; x'y+y'z+xzw
	
	sub r22,r20
	breq loop
	rjmp Start

loop:
	ldi r16, 0b00100000
	out PORTB,r16



