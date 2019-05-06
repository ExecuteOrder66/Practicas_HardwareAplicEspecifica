
_main:

;p2.c,1 :: 		void main() {
;p2.c,2 :: 		char d,u,i=0;
	CLRF        main_i_L0+0 
	MOVLW       63
	MOVWF       main_numeros_L0+0 
	MOVLW       6
	MOVWF       main_numeros_L0+1 
	MOVLW       91
	MOVWF       main_numeros_L0+2 
	MOVLW       79
	MOVWF       main_numeros_L0+3 
	MOVLW       102
	MOVWF       main_numeros_L0+4 
	MOVLW       109
	MOVWF       main_numeros_L0+5 
	MOVLW       125
	MOVWF       main_numeros_L0+6 
	MOVLW       7
	MOVWF       main_numeros_L0+7 
	MOVLW       127
	MOVWF       main_numeros_L0+8 
	MOVLW       103
	MOVWF       main_numeros_L0+9 
;p2.c,4 :: 		ADCON1=0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;p2.c,6 :: 		TRISA.B0=0;
	BCF         TRISA+0, 0 
;p2.c,7 :: 		TRISA.B1=0;
	BCF         TRISA+0, 1 
;p2.c,8 :: 		TRISD=0;
	CLRF        TRISD+0 
;p2.c,10 :: 		while(1){
L_main0:
;p2.c,11 :: 		for(d=0;d<6;d++){
	CLRF        R1 
L_main2:
	MOVLW       6
	SUBWF       R1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main3
;p2.c,12 :: 		for(u=0;u<10;u++){
	CLRF        R2 
L_main5:
	MOVLW       10
	SUBWF       R2, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main6
;p2.c,13 :: 		for(i=0;i<25;i++){
	CLRF        main_i_L0+0 
L_main8:
	MOVLW       25
	SUBWF       main_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main9
;p2.c,14 :: 		PORTD=numeros[u];     //numero de unidades deseado al puerto D
	MOVLW       main_numeros_L0+0
	MOVWF       FSR0 
	MOVLW       hi_addr(main_numeros_L0+0)
	MOVWF       FSR0H 
	MOVF        R2, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       PORTD+0 
;p2.c,15 :: 		PORTA.B0=1;           //Encendemos display de unidades
	BSF         PORTA+0, 0 
;p2.c,16 :: 		delay_ms(20);         //50T=> 20ms mostrando el valor de unidades
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main11:
	DECFSZ      R13, 1, 1
	BRA         L_main11
	DECFSZ      R12, 1, 1
	BRA         L_main11
	NOP
	NOP
;p2.c,17 :: 		PORTA.B0=0;           //Apagamos display de unidades
	BCF         PORTA+0, 0 
;p2.c,19 :: 		PORTD=numeros[d];     //numero de decenas deseado al puerto D
	MOVLW       main_numeros_L0+0
	MOVWF       FSR0 
	MOVLW       hi_addr(main_numeros_L0+0)
	MOVWF       FSR0H 
	MOVF        R1, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       PORTD+0 
;p2.c,20 :: 		PORTA.B1=1;           //Encendemos display de decenas
	BSF         PORTA+0, 1 
;p2.c,21 :: 		delay_ms(20);         //50T=> 20ms mostrando el valor de unidades
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main12:
	DECFSZ      R13, 1, 1
	BRA         L_main12
	DECFSZ      R12, 1, 1
	BRA         L_main12
	NOP
	NOP
;p2.c,22 :: 		PORTA.B1=0;           //Apagamos display de decenas
	BCF         PORTA+0, 1 
;p2.c,13 :: 		for(i=0;i<25;i++){
	INCF        main_i_L0+0, 1 
;p2.c,23 :: 		}
	GOTO        L_main8
L_main9:
;p2.c,12 :: 		for(u=0;u<10;u++){
	INCF        R2, 1 
;p2.c,25 :: 		}
	GOTO        L_main5
L_main6:
;p2.c,11 :: 		for(d=0;d<6;d++){
	INCF        R1, 1 
;p2.c,27 :: 		}
	GOTO        L_main2
L_main3:
;p2.c,29 :: 		}
	GOTO        L_main0
;p2.c,30 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
