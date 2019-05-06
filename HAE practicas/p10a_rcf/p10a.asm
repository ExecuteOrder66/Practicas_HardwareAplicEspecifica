
_main:

;p10a.c,1 :: 		void main() {
;p10a.c,3 :: 		TRISC=0;
	CLRF        TRISC+0 
;p10a.c,4 :: 		PORTC.B0=1;      //PORTC.B0 conectado al terminal CS del convertidor D/A
	BSF         PORTC+0, 0 
;p10a.c,5 :: 		alto= 0x3F;
	MOVLW       63
	MOVWF       main_alto_L0+0 
;p10a.c,6 :: 		bajo= 0xFF;
	MOVLW       255
	MOVWF       main_bajo_L0+0 
;p10a.c,8 :: 		SPI1_Init();     //Iniciamos convertidor D/A
	CALL        _SPI1_Init+0, 0
;p10a.c,9 :: 		PORTC.B0=0;     //CS a 0 para establecer comunicacion
	BCF         PORTC+0, 0 
;p10a.c,10 :: 		SPI1_WRITE(alto);        //Primero el byte alto (Big Endian)
	MOVF        main_alto_L0+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;p10a.c,11 :: 		SPI1_WRITE(bajo);        //y luego el byte bajo
	MOVF        main_bajo_L0+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;p10a.c,12 :: 		PORTC.B0=1;     //Fin comunicacion, CS a 1
	BSF         PORTC+0, 0 
;p10a.c,13 :: 		while(1);
L_main0:
	GOTO        L_main0
;p10a.c,14 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
