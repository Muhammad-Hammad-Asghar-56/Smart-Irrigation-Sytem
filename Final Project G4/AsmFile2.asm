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
.def A = r16
.def AH = r17
.org 0x00
; I/O Pins Configuration
	SBI DDRB,5 ; Set PB5 pin for Output to LED
	CBI PORTB,5 ; LED OFF
; ADC Configuration
	LDI A,0b11000111 ; [ADEN ADSC ADATE ADIF ADIE ADIE ADPS2 ADPS1 ADPS0]
	STS ADCSRA,A
	LDI A,0b01100000 ; [REFS1 REFS0 ADLAR – MUX3 MUX2 MUX1 MUX0]
	STS ADMUX,A ; Select ADC0 (PC0) pin
	SBI PORTC,PC0 ; Enable Pull-up Resistor
;--------------------------------------------------------------------------------------------------------------------------
; Setting pins to Output for LCD
	
	sbi DDRD,PD3 ; D4
	sbi DDRD,PD4 ; D5
	sbi DDRD,PD5 ; D6
	sbi DDRD,PD6 ; D7
	sbi DDRD,PD7
	sbi DDRB,PB0
	sbi DDRB,PB1
	sbi DDRB,PB2


;Setting LCD Mode selection pins
	sbi DDRB,PB2 ; RS
	sbi DDRB,PB1 ; E pin of LCD
	
; LCD Init
	LCD_send_a_command 0x01 ; sending all clear command
	LCD_send_a_command 0x38 ; set LCD mode to 16*2 line LCD
	LCD_send_a_command 0x0C ; screen ON
	sbi PORTB,PB5 ; Backlight ON

;---------------------------------------------------------------------------------------------------------------------------
loop:
	;----------------------------------------------- LCD SETTING -----------------------------------------------------------
	LDI r16,0b00000001 ; receives the command
	OUT PORTD,r16 ; Set the PD0 to PD7 pins according to command bits
	CBI PORTB, PB4 ; set RS pin to LOW (set LCD mode to "Command Mode")
	SBI PORTB, PB3 ; set E pin to HIGH (set LCD to receive the command)
	delay 50
	CBI PORTB, PB3 ; set E pin to LOW (set LCD to process the command)
	LDI r16,0x00
	OUT PORTD,r16 ; clear the PD0 to PD7 pins after sending the command

	delay 1000
rjmp loop
;---------------------------------------------------------------------------------------------------------------------------