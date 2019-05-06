
_convertir:

;p10c.c,3 :: 		void convertir(){
;p10c.c,4 :: 		PORTC.B0=0;     //CS a 0 para establecer comunicacion
	BCF         PORTC+0, 0 
;p10c.c,5 :: 		SPI1_WRITE(valor>>8);        //Primero el byte alto (Big Endian), se desplaza 8pos a la der. para obtener el byte alto
	MOVF        _valor+1, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVF        R0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;p10c.c,6 :: 		SPI1_WRITE(valor);        //y luego el byte bajo
	MOVF        _valor+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;p10c.c,7 :: 		delay_us(10);
	MOVLW       6
	MOVWF       R13, 0
L_convertir0:
	DECFSZ      R13, 1, 1
	BRA         L_convertir0
	NOP
;p10c.c,8 :: 		PORTC.B0=1;     //Fin comunicacion, CS a 1
	BSF         PORTC+0, 0 
;p10c.c,9 :: 		}
L_end_convertir:
	RETURN      0
; end of _convertir

_interrupt:

;p10c.c,11 :: 		void interrupt(){
;p10c.c,12 :: 		if(INTCON.INT0IF){
	BTFSS       INTCON+0, 1 
	GOTO        L_interrupt1
;p10c.c,13 :: 		valor+=0x10;      //Reducimos frecuencia-> aumentamos periodo
	MOVLW       16
	ADDWF       _valor+0, 1 
	MOVLW       0
	ADDWFC      _valor+1, 1 
;p10c.c,14 :: 		}
L_interrupt1:
;p10c.c,15 :: 		if(INTCON3.INT1IF){
	BTFSS       INTCON3+0, 0 
	GOTO        L_interrupt2
;p10c.c,16 :: 		valor -=0x10;     //Aumentamos frecuencia-> reducimos periodo
	MOVLW       16
	SUBWF       _valor+0, 1 
	MOVLW       0
	SUBWFB      _valor+1, 1 
;p10c.c,17 :: 		}
L_interrupt2:
;p10c.c,19 :: 		INTCON.INT0IF=0;
	BCF         INTCON+0, 1 
;p10c.c,20 :: 		INTCON3.INT1IF=0;
	BCF         INTCON3+0, 0 
;p10c.c,21 :: 		}
L_end_interrupt:
L__interrupt7:
	RETFIE      1
; end of _interrupt

_main:

;p10c.c,23 :: 		void main() {
;p10c.c,24 :: 		ADCON1=0x87;
	MOVLW       135
	MOVWF       ADCON1+0 
;p10c.c,25 :: 		TRISC=0;
	CLRF        TRISC+0 
;p10c.c,26 :: 		TRISB.B0=1;
	BSF         TRISB+0, 0 
;p10c.c,27 :: 		TRISB.B1=1;
	BSF         TRISB+0, 1 
;p10c.c,28 :: 		PORTC.B0=1;      //PORTC.B0 conectado al terminal CS del convertidor D/A, Cs a 1, sin comunicacion
	BSF         PORTC+0, 0 
;p10c.c,29 :: 		valor=0x3FFF;
	MOVLW       255
	MOVWF       _valor+0 
	MOVLW       63
	MOVWF       _valor+1 
;p10c.c,30 :: 		INTCON2=0;
	CLRF        INTCON2+0 
;p10c.c,32 :: 		INTCON.INT0IF=0;   //Interruptor 2
	BCF         INTCON+0, 1 
;p10c.c,33 :: 		INTCON.INT0IE=1;
	BSF         INTCON+0, 4 
;p10c.c,35 :: 		INTCON3.INT1IF=0;  //Interruptor 1
	BCF         INTCON3+0, 0 
;p10c.c,36 :: 		INTCON3.INT1IE=1;
	BSF         INTCON3+0, 3 
;p10c.c,38 :: 		INTCON.GIE=1;
	BSF         INTCON+0, 7 
;p10c.c,39 :: 		SPI1_Init();     //Iniciamos convertidor D/A
	CALL        _SPI1_Init+0, 0
;p10c.c,40 :: 		while(1){
L_main3:
;p10c.c,41 :: 		convertir();
	CALL        _convertir+0, 0
;p10c.c,42 :: 		}
	GOTO        L_main3
;p10c.c,43 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
