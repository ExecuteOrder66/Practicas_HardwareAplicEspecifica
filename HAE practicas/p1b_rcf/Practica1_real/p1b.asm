
_main:

;p1b.c,1 :: 		void main() {
;p1b.c,3 :: 		char array[]={0x01,0x02,0x04,0x08,0x10,0x20,0x40,0x80};
	MOVLW       1
	MOVWF       main_array_L0+0 
	MOVLW       2
	MOVWF       main_array_L0+1 
	MOVLW       4
	MOVWF       main_array_L0+2 
	MOVLW       8
	MOVWF       main_array_L0+3 
	MOVLW       16
	MOVWF       main_array_L0+4 
	MOVLW       32
	MOVWF       main_array_L0+5 
	MOVLW       64
	MOVWF       main_array_L0+6 
	MOVLW       128
	MOVWF       main_array_L0+7 
;p1b.c,4 :: 		ADCON1 = 0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;p1b.c,5 :: 		TRISC = 0x00;        //Terminales del puerto C como salidas
	CLRF        TRISC+0 
;p1b.c,6 :: 		PORTC = 0;
	CLRF        PORTC+0 
;p1b.c,7 :: 		while(1){
L_main0:
;p1b.c,8 :: 		for(i=0;i<8;i++){        //bucle para recorrer todos los terminales
	CLRF        R1 
L_main2:
	MOVLW       8
	SUBWF       R1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main3
;p1b.c,9 :: 		PORTC=array[i];        //enciende led
	MOVLW       main_array_L0+0
	MOVWF       FSR0 
	MOVLW       hi_addr(main_array_L0+0)
	MOVWF       FSR0H 
	MOVF        R1, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       PORTC+0 
;p1b.c,10 :: 		delay_ms(200);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_main5:
	DECFSZ      R13, 1, 1
	BRA         L_main5
	DECFSZ      R12, 1, 1
	BRA         L_main5
	DECFSZ      R11, 1, 1
	BRA         L_main5
;p1b.c,11 :: 		PORTC=array[i];        //apaga led
	MOVLW       main_array_L0+0
	MOVWF       FSR0 
	MOVLW       hi_addr(main_array_L0+0)
	MOVWF       FSR0H 
	MOVF        R1, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       PORTC+0 
;p1b.c,12 :: 		delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main6:
	DECFSZ      R13, 1, 1
	BRA         L_main6
	DECFSZ      R12, 1, 1
	BRA         L_main6
	DECFSZ      R11, 1, 1
	BRA         L_main6
	NOP
;p1b.c,8 :: 		for(i=0;i<8;i++){        //bucle para recorrer todos los terminales
	INCF        R1, 1 
;p1b.c,13 :: 		}
	GOTO        L_main2
L_main3:
;p1b.c,14 :: 		}
	GOTO        L_main0
;p1b.c,16 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
