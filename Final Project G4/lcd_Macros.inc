.macro command_wrt
      PUSH  R16
      LDI   R16, @0
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
	  POP R16
.endmacro

.macro LCD_init
      command_wrt 0x33       ;send to command register
      delay 30
      command_wrt 0x32
      delay 30
      command_wrt 0x28
      delay 30
      command_wrt 0x0C
      command_wrt 0x01
      delay 30
      command_wrt 0x06
.endmacro

.macro data_wrt
      PUSH  R16
      LDI   R16, @0
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
	  POP R16
.endmacro

.macro data_wrt_reg
      PUSH  R16
      MOV   R16, @0
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
	  POP R16
.endmacro

.macro disp_message
      data_wrt 'A'
      delay 30
      data_wrt 's'
      delay 30
      data_wrt 's'
      delay 30
      data_wrt 'e'
      delay 30
      data_wrt 'm'
      delay 30
      data_wrt 'b'
      delay 30
      data_wrt 'l'
      delay 30
      data_wrt 'y'
      delay 30
      ;----------------
      data_wrt ' '
      ;----------------
      data_wrt 'v'
      delay 30
      data_wrt 'i'
      delay 30
      data_wrt 'a'
      delay 30
      ;----------------
      data_wrt ' '
      ;----------------
      data_wrt 'U'
      delay 30
      data_wrt 'N'
      delay 30
      data_wrt 'O'
      delay 30
      ;----------------
      command_wrt 0xC0
      delay 30
      ;----------------
      data_wrt 'P'
      delay 30
      data_wrt 'r'
      delay 30
      data_wrt 'o'
      delay 30
      data_wrt 'g'
      delay 30
      data_wrt 'r'
      delay 30
      data_wrt 'a'
      delay 30
      data_wrt 'm'
      delay 30
      data_wrt 'm'
      delay 30
      data_wrt 'i'
      delay 30
      data_wrt 'n'
      delay 30
      data_wrt 'g'
      delay 30
      ;----------------
      data_wrt ' '
      ;----------------
      data_wrt 'L'
      delay 30
      data_wrt 'C'
      delay 30
      data_wrt 'D'
      delay 30
      data_wrt '!'
      ;----------------
      delay 30
.endmacro