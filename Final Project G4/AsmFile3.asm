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
	sbi DDRD,PD7 ; D4
	sbi DDRD,PD6 ; D5
	sbi DDRD,PD5 ; D6
	sbi DDRD,PD4 ; D7


;Setting LCD Mode selection pins
	sbi DDRB,PB0 ; RS
	sbi DDRB,PB1 ; E pin of LCD

	LCD_init
	
	LDI R16, 0x41
	data_wrt
	delay 30

loop:
rjmp loop
;---------------------------------------------------------------------------------------------------------------------------