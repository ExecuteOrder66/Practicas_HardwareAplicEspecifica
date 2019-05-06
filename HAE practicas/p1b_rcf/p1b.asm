
_main:

;p1b.c,1 :: 		void main() {
;p1b.c,3 :: 		ADCON1 = 0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;p1b.c,4 :: 		TRISC.B0=0x00;	//Terminales del puerto C como salidas
	BCF         TRISC+0, 0 
;p1b.c,5 :: 		PORTC.B0=0;
	BCF         PORTC+0, 0 
;p1b.c,6 :: 		while(1){
L_main0:
;p1b.c,8 :: 		PORTC.B0=1;	//enciende led
	BSF         PORTC+0, 0 
;p1b.c,9 :: 		delay_ms(200);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	DECFSZ      R11, 1, 1
	BRA         L_main2
;p1b.c,10 :: 		PORTC.B0=0;	//apaga led
	BCF         PORTC+0, 0 
;p1b.c,11 :: 		delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	DECFSZ      R11, 1, 1
	BRA         L_main3
	NOP
;p1b.c,13 :: 		}
	GOTO        L_main0
;p1b.c,15 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
