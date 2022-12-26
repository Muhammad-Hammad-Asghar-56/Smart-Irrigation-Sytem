/*
 * LightON_Code.asm
 *
 *  Created: 26/12/2022 9:22:17 pm
 *   Author: M.H Asghar
 */ 
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