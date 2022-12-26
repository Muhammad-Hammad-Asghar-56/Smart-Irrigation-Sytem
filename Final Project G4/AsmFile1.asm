.macro div
;***************************************************************************
;*
;* "div8u" - 8/8 Bit Unsigned Division
;*
;* This macro divides the two register variables "r16" (dividend) and
;* "r17" (divisor). The result is placed in "r16" and the remainder in
;* "r15".
;*
;***************************************************************************
;* Register Variables:
; r15 ;remainder
; r16 ;result
; r16 ;dividend
; r17 ;divisor
; r18 ;loop counter
push r18

div8u:
	sub r15,r15 ;clear remainder and carry
	ldi r18,9 ;init loop counter
	d8u_1:
	rol r16 ;shift left dividend
	dec r18 ;decrement counter
	brne d8u_2 ;if done
rjmp exit ;return

d8u_2:
	rol r15 ;shift dividend into remainder
	sub r15,r17 ;remainder = remainder - divisor
	brcc d8u_3 ;if result negative
	add r15,r17 ;restore remainder
	clc ;clear carry to be shifted into result
	rjmp d8u_1 ;else
d8u_3:
	sec ;set carry to be shifted into result
rjmp d8u_1
exit:
	pop r18
.endmacro
