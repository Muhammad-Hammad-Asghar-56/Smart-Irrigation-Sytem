.macro LCD_send_a_command
	PUSH r16
	LDI r16,@0 ; receives the command
	OUT PORTD,r16 ; Set the PD0 to PD7 pins according to command bits
	CBI PORTB, PB0 ; set RS pin to LOW (set LCD mode to "Command Mode")
	SBI PORTB, PB1 ; set E pin to HIGH (set LCD to receive the command)
	delay 50
	CBI PORTB, PB1 ; set E pin to LOW (set LCD to process the command)
	LDI r16,0x00
	OUT PORTD,r16 ; clear the PD0 to PD7 pins after sending the command
	POP r16
.endmacro


.macro LCD_send_a_character
	PUSH r16
	LDI r16,@0 ; receives the character
	OUT PORTD,r16 ; Set the PD0 to PD7 pins according to command bits
	SBI PORTB, PB0 ; set RS pin to HIGH (set LCD mode to "Data Mode")
	SBI PORTB, PB1 ; set E pin to HIGH (set LCD to receive the command)
	delay 30
	CBI PORTB, PB1 ; set E pin to LOW (set LCD to process the command)
	LDI r16,0x00
	OUT PORTD,r16 ; clear the PD0 to PD7 pins after sending the command
	POP r16
.endmacro


.macro LCD_send_a_REG
	PUSH r16
	MOV r16,@0					; receives the character
	OUT PORTD, r16				; Set the PD0 to PD7 pins according to command bits
	SBI PORTB, PB0				; Set RS pin to HIGH (set LCD mode to "Data Mode")
	SBI PORTB, PB1				; Set E pin to HIGH (set LCD to receive the command)
	delay 30
	CBI PORTB, PB1				; Set E pin to LOW (set LCD to process the command)
	LDI r16,0x00
	OUT PORTD, r16				; Clear the PD0 to PD7 pins after sending the command)

	POP r16
.endmacro