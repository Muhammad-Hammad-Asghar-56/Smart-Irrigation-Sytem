;
; Final Project G4.asm
;
; Created: 24/12/2022 4:29:57 pm
; Author : M.H Asghar
;

.include "m328pdef.inc"
.include "delayMacro.inc"
.include "div.inc"
.include "lcd_Macros.inc"
.org 0x00
;

; Setting pins to Output for LCD
	sbi DDRD,PD0 ; D0 pin of LCD
	sbi DDRD,PD1 ; D1
	sbi DDRD,PD2 ; D2
	sbi DDRD,PD3 ; D3
	sbi DDRD,PD4 ; D4
	sbi DDRD,PD5 ; D5
	sbi DDRD,PD6 ; D6
	sbi DDRD,PD7 ; D7


;Setting LCD Mode selection pins
	sbi DDRB,PB0 ; RS
	sbi DDRB,PB1 ; E pin of LCD
	;Setting LCD Backlight pin
	sbi DDRB,PB5 ; BLA pin of LCD
; LCD Init
	LCD_send_a_command 0x01 ; sending all clear command
	LCD_send_a_command 0x38 ; set LCD mode to 16*2 line LCD
	LCD_send_a_command 0x0C ; screen ON
	sbi PORTB,PB5 ; Backlight ON


loop:
	LCD_send_a_command 0x01 ; clear the LCD
	; take reading from the Sensor
	LDI r16,123
	
	; ON/OFF			Probe /Light
	LDI r17,0b01111111 ; configure value from the sensor
	CPI r17,0b01100100 ;jump if same or higher (AH >= 100)
	Brsh LED_ON
	;P
	;	r
	;		i
	;			n				ON LED
	;				t
	; r15 remainder
	; r16 result
	; r16 dividend
	; r17 divisor
compare:	CPI r16,1
			brlo loop
			LDI r17,10
			div	
			call Print_On_LED
	
	
rjmp loop


Print_On_LED:
	; Sending Hello World to LCD
	LDI r20,48
	add r15,r20
	LCD_send_a_reg r15; 'H'
	;LCD_send_a_command 0xC0 ; move curser to next line
	LCD_send_a_command 0x13 ; move curser one step forward (another way to add space)
	;delay 1000
	call compare

LED_ON: 
	LDI r16, (1<<PINB3) ; load 00100000 into register R16
	OUT DDRB, r16 ; write register R16 value to DDRB register
	LDI r17, (1<<PINB3) ; load 00100000 into register R16
	OUT PORTB, r17 ; write register R16 value to PORTB register
	call compare