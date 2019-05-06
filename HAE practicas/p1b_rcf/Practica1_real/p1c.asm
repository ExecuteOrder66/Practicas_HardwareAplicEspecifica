
_main:

;p1c.c,1 :: 		void main() {
;p1c.c,3 :: 		char array[]={0x81,0x42,0x24,0x18,0x18,0x24,0x42,0x81};
	MOVLW       129
	MOVWF       main_array_L0+0 
	MOVLW       66
	MOVWF       main_array_L0+1 
	MOVLW       36
	MOVWF       main_array_L0+2 
	MOVLW       24
	MOVWF       main_array_L0+3 
	MOVLW       24
	MOVWF       main_array_L0+4 
	MOVLW       36
	MOVWF       main_array_L0+5 
	MOVLW       66
	MOVWF       main_array_L0+6 
	MOVLW       129
	MOVWF       main_array_L0+7 
;p1c.c,4 :: 		ADCON1 = 0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;p1c.c,5 :: 		TRISC = 0x00;
	CLRF        TRISC+0 
;p1c.c,7 :: 		while(1){
L_main0:
;p1c.c,8 :: 		for(i=0;i<8;i++){
	CLRF        R1 
L_main2:
	MOVLW       8
	SUBWF       R1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main3
;p1c.c,9 :: 		PORTC=array[i];        //enciende led
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
;p1c.c,10 :: 		delay_ms(200);
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
;p1c.c,11 :: 		PORTC=array[i];        //apaga led
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
;p1c.c,12 :: 		delay_ms(100);
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
;p1c.c,8 :: 		for(i=0;i<8;i++){
	INCF        R1, 1 
;p1c.c,13 :: 		}
	GOTO        L_main2
L_main3:
;p1c.c,14 :: 		}
	GOTO        L_main0
;p1c.c,15 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
