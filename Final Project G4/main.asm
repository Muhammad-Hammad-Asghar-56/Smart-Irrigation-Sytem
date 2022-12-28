.include "m328pdef.inc"
.include "div.inc"
.include "delayMacro.inc"
.include "lcd_Macros.inc"

;================================================================
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

    sbi DDRD,PD7 ; D4
	sbi DDRD,PD6 ; D5
	sbi DDRD,PD5 ; D6
	sbi DDRD,PD4 ; D7
	

;Setting LCD Mode selection pins
	sbi DDRB,PB0 ; RS
	sbi DDRB,PB1 ; E pin of LCD
    CBI   PORTB, 0    ;EN = 0
   
	LCD_init ;subroutine to initialize LCD
	
again:
	command_wrt 0x001
    ;-----------------------------------------------------
	LDS A,ADCSRA ; Start Analog to Digital Conversion
	ORI A,(1<<ADSC)
	STS ADCSRA,A
	wait:
	LDS A,ADCSRA ; wait for conversion to complete
	sbrc A,ADSC
	rjmp wait
	LDS A,ADCL ; Must Read ADCL before ADCH
	LDS AH,ADCH

	cpi AH,200 ; compare LDR reading with our desired threshold
	brsh LED_ON ; jump if same or higher (AH >= 200)
	CBI PORTB,5 ; LED OFF
	
	rjmp CarryOn
	LED_ON:
	SBI PORTB,5 ; LED ON

	
	mov r16,AH
		
CarryOn:	; check 100th Place
	data_wrt 'R'
	data_wrt 'E'
	data_wrt 'A'
	data_wrt 'D'
	data_wrt 'I'
	data_wrt 'N'
	data_wrt 'G'
	data_wrt ':'
	
	LDI r17,100
	div
	
	LDI r20,48
	add r16,r20
	data_wrt_reg r16
	
	
	; check 10th Place 
	mov r16,r15
	LDI r17,10
	div
	LDI r20,48
	add r16,r20
	data_wrt_reg r16
	

	; check 1th Place 
	LDI r20,48
	add r15,r20
	data_wrt_reg r15
	
	delay 1000
	  
	  
	RJMP  again             ;jump to again for another run
;================================================================