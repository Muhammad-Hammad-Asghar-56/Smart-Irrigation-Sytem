;
; Final Project G4.asm
;
; Created: 24/12/2022 4:29:57 pm
; Author : M.H Asghar
;


; Replace with your application code


.include "m328pdef.inc"
.cseg
.org 0x00
	

loop:

	LDI r17,0b01111111 ; configure value from the sensor
	CPI r17,0b01100100 ;jump if same or higher (AH >= 100)
	Brsh LED_ON
rjmp loop ; stay in infinite loop


LED_ON: 
	LDI r16, (1<<PINB3) ; load 00100000 into register R16
	OUT DDRB, r16 ; write register R16 value to DDRB register
	LDI r17, (1<<PINB3) ; load 00100000 into register R16
	OUT PORTB, r17 ; write register R16 value to PORTB register
	call loop