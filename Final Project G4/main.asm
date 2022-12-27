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

;---------------------------------------------------------------------------------------------------------------------------
loop:
	LCD_send_a_command 0x01 ; clear the LCD
	LCD_send_a_character 'R'
	LCD_send_a_character 'E'
	LCD_send_a_character 'A'
	LCD_send_a_character 'D'
	LCD_send_a_character 'I'
	LCD_send_a_character 'N'
	LCD_send_a_character 'G'
	LCD_send_a_character ':'

	LDI r16,123
	
	;					ON/OFF	Probe
	CPI r16,100 ;jump if same or higher (AH >= 100)
	Brlo CarryOn
	;LDI r17, (1<<PINB3) ; load 00100000 into register R16
	;OUT DDRB, r17 ; write register R16 value to DDRB register
	;LDI r18, (1<<PINB3) ; load 00100000 into register R16
	;OUT PORTB, r18 ; write register R16 value to PORTB register
	
CarryOn:	; check 100th Place
	LDI r17,100
	div
	
	LDI r20,48
	add r16,r20
	LCD_send_a_reg r16
	
	
	; check 10th Place 
	mov r16,r15
	LDI r17,10
	div
	LDI r20,48
	add r16,r20
	LCD_send_a_reg r16
	

	; check 1th Place 
	LDI r20,48
	add r15,r20
	LCD_send_a_reg r15
	
	delay 1000
rjmp loop

;---------------------------------------------------------------------------------------------------------------------------
