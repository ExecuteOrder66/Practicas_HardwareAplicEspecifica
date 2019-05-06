
_convertir:

;p10b.c,3 :: 		void convertir(){
;p10b.c,4 :: 		PORTC.B0=0;     //CS a 0 para establecer comunicacion
	BCF         PORTC+0, 0 
;p10b.c,5 :: 		SPI1_WRITE(valor>>8);        //Primero el byte alto (Big Endian), se desplaza 8pos a la der. para obtener el byte alto
	MOVF        _valor+1, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVF        R0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;p10b.c,6 :: 		SPI1_WRITE(valor);        //y luego el byte bajo
	MOVF        _valor+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;p10b.c,7 :: 		PORTC.B0=1;     //Fin comunicacion, CS a 1
	BSF         PORTC+0, 0 
;p10b.c,8 :: 		}
L_end_convertir:
	RETURN      0
; end of _convertir

_main:

;p10b.c,10 :: 		void main() {
;p10b.c,11 :: 		TRISC=0;
	CLRF        TRISC+0 
;p10b.c,12 :: 		PORTC.B0=1;      //PORTC.B0 conectado al terminal CS del convertidor D/A, Cs a 1, sin comunicacion
	BSF         PORTC+0, 0 
;p10b.c,13 :: 		SPI1_Init();     //Iniciamos convertidor D/A
	CALL        _SPI1_Init+0, 0
;p10b.c,15 :: 		while(1){
L_main0:
;p10b.c,16 :: 		for(valor=0x3000; valor<0x3FFF; valor++){       //Tendiendo al valor alto
	MOVLW       0
	MOVWF       _valor+0 
	MOVLW       48
	MOVWF       _valor+1 
L_main2:
	MOVLW       63
	SUBWF       _valor+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main12
	MOVLW       255
	SUBWF       _valor+0, 0 
L__main12:
	BTFSC       STATUS+0, 0 
	GOTO        L_main3
;p10b.c,17 :: 		convertir();
	CALL        _convertir+0, 0
;p10b.c,18 :: 		delay_us(10);
	MOVLW       6
	MOVWF       R13, 0
L_main5:
	DECFSZ      R13, 1, 1
	BRA         L_main5
	NOP
;p10b.c,16 :: 		for(valor=0x3000; valor<0x3FFF; valor++){       //Tendiendo al valor alto
	INFSNZ      _valor+0, 1 
	INCF        _valor+1, 1 
;p10b.c,19 :: 		}
	GOTO        L_main2
L_main3:
;p10b.c,20 :: 		for(valor=0x3FFF; valor>0x3000; valor--){       //Tendiendo al valor bajo
	MOVLW       255
	MOVWF       _valor+0 
	MOVLW       63
	MOVWF       _valor+1 
L_main6:
	MOVF        _valor+1, 0 
	SUBLW       48
	BTFSS       STATUS+0, 2 
	GOTO        L__main13
	MOVF        _valor+0, 0 
	SUBLW       0
L__main13:
	BTFSC       STATUS+0, 0 
	GOTO        L_main7
;p10b.c,21 :: 		convertir();
	CALL        _convertir+0, 0
;p10b.c,22 :: 		delay_us(10);
	MOVLW       6
	MOVWF       R13, 0
L_main9:
	DECFSZ      R13, 1, 1
	BRA         L_main9
	NOP
;p10b.c,20 :: 		for(valor=0x3FFF; valor>0x3000; valor--){       //Tendiendo al valor bajo
	MOVLW       1
	SUBWF       _valor+0, 1 
	MOVLW       0
	SUBWFB      _valor+1, 1 
;p10b.c,23 :: 		}
	GOTO        L_main6
L_main7:
;p10b.c,25 :: 		}
	GOTO        L_main0
;p10b.c,26 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
