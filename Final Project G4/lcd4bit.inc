.macro LCD_init
      LDI   R16, 0x33         ;init LCD for 4-bit data
      command_wrt       ;send to command register
      delay 30
      LDI   R16, 0x32         ;init LCD for 4-bit data
      command_wrt
      delay 30
      LDI   R16, 0x28         ;LCD 2 lines, 5x7 matrix
      command_wrt
      delay 30
      LDI   R16, 0x0C         ;disp ON, cursor OFF
      command_wrt
      LDI   R16, 0x01         ;clear LCD
      command_wrt
      delay 30
      LDI   R16, 0x06         ;shift cursor right
      command_wrt
.endmacro

.macro command_wrt
      MOV   R27, R16
      ANDI  R27, 0xF0         ;mask low nibble & keep high nibble
      OUT   PORTD, R27        ;o/p high nibble to port D
      CBI   PORTB, 1          ;RS = 0 for command
      SBI   PORTB, 0          ;EN = 1
      delay 30
      CBI   PORTB, 0          ;EN = 0 for H-to-L pulse
      delay 30
      ;----------------------------------------------------
      MOV   R27, R16
      SWAP  R27               ;swap nibbles
      ANDI  R27, 0xF0         ;mask low nibble & keep high nibble
      OUT   PORTD, R27        ;o/p high nibble to port D
      SBI   PORTB, 0          ;EN = 1
      delay 30
      CBI   PORTB, 0          ;EN = 0 for H-to-L pulse
      delay 30
.endmacro

.macro data_wrt
      MOV   R27, R16
      ANDI  R27, 0xF0         ;mask low nibble & keep high nibble
      OUT   PORTD, R27        ;o/p high nibble to port D
      SBI   PORTB, 1          ;RS = 1 for data
      SBI   PORTB, 0          ;EN = 1
      delay 30
      CBI   PORTB, 0          ;EN = 0 for H-to-L pulse
      delay 30
      ;----------------------------------------------------
      MOV   R27, R16
      SWAP  R27               ;swap nibbles
      ANDI  R27, 0xF0         ;mask low nibble & keep high nibble
      OUT   PORTD, R27        ;o/p high nibble to port D
      SBI   PORTB, 0          ;EN = 1
	  delay 30
      CBI   PORTB, 0          ;EN = 0 for H-to-L pulse
      delay 30
.endmacro