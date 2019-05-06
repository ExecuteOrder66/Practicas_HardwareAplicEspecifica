
_main:

;p3a.c,1 :: 		void main() {
;p3a.c,2 :: 		char val,val_ant=1;
;p3a.c,4 :: 		ADCON1=0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;p3a.c,5 :: 		RBPU_bit=0;
	BCF         RBPU_bit+0, BitPos(RBPU_bit+0) 
;p3a.c,6 :: 		TRISB.B1=0;
	BCF         TRISB+0, 1 
;p3a.c,9 :: 		while(1){
L_main0:
;p3a.c,12 :: 		if(PORTB.B0==0 & val==1)     //Si el valor anterior era 1 y el valor presente es 0, significa que se ha pulsado el boton
	BTFSC       PORTB+0, 0 
	GOTO        L__main5
	BSF         R2, 0 
	GOTO        L__main6
L__main5:
	BCF         R2, 0 
L__main6:
	MOVF        R3, 0 
	XORLW       1
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	CLRF        R0 
	BTFSC       R2, 0 
	INCF        R0, 1 
	MOVF        R1, 0 
	ANDWF       R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main2
;p3a.c,13 :: 		PORTB.B1=!PORTB.B1;              //Encendemos el led si estaba encendido
	BTG         PORTB+0, 1 
L_main2:
;p3a.c,17 :: 		val=PORTB.B0;    //Almacenamos el valor de RB0
	MOVLW       0
	BTFSC       PORTB+0, 0 
	MOVLW       1
	MOVWF       R3 
;p3a.c,18 :: 		delay_ms(100);    //Esperamos 100ms para muestrear otra vez
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
;p3a.c,19 :: 		}
	GOTO        L_main0
;p3a.c,20 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
