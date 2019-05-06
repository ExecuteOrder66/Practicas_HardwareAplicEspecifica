
_interrupt:

;P7a.c,19 :: 		void interrupt(){
;P7a.c,20 :: 		PIR1.ADIF=0;     //Deshabilitamos interrupcion
	BCF         PIR1+0, 6 
;P7a.c,22 :: 		x=0;
	CLRF        _x+0 
	CLRF        _x+1 
;P7a.c,23 :: 		x=(ADRESH<<8) + (ADRESL);      //Cargamos el valor muestreado de la tensión de entrada
	MOVF        ADRESH+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        ADRESL+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       _x+0 
	MOVF        R1, 0 
	MOVWF       _x+1 
;P7a.c,24 :: 		v= x*0.0048828125;             //Este valor numero es la resolucion del convertidor A/D---->   resolucion= (Vref+ - Vref-)/2^n  (en este caso n=10)
	CALL        _word2double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       119
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _v+0 
	MOVF        R1, 0 
	MOVWF       _v+1 
	MOVF        R2, 0 
	MOVWF       _v+2 
	MOVF        R3, 0 
	MOVWF       _v+3 
;P7a.c,27 :: 		Lcd_Cmd(_LCD_CLEAR);     //Borramos pantalla lcd
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;P7a.c,28 :: 		FloatToStr(v,txt);
	MOVF        _v+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        _v+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        _v+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        _v+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _txt+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;P7a.c,29 :: 		Lcd_out(1,1,txt);        //Mostramos resultado por pantalla
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;P7a.c,30 :: 		delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_interrupt0:
	DECFSZ      R13, 1, 1
	BRA         L_interrupt0
	DECFSZ      R12, 1, 1
	BRA         L_interrupt0
	DECFSZ      R11, 1, 1
	BRA         L_interrupt0
	NOP
	NOP
;P7a.c,31 :: 		ADCON0.GO=1;  //Comienza el muestreo de la señal analogica otra vez
	BSF         ADCON0+0, 2 
;P7a.c,34 :: 		}
L_end_interrupt:
L__interrupt4:
	RETFIE      1
; end of _interrupt

_main:

;P7a.c,36 :: 		void main() {
;P7a.c,37 :: 		TRISA.B0=1;  //Declarar An0 como entrada
	BSF         TRISA+0, 0 
;P7a.c,38 :: 		ADCON0=0x41;      //Escogemos una combinacion en la que AN0 sea analogica y las tensiones de referencia vengan del micro (vdd y vss)
	MOVLW       65
	MOVWF       ADCON0+0 
;P7a.c,39 :: 		ADCON1=0xCE;     //prescaler 16 (el mas pequeño)
	MOVLW       206
	MOVWF       ADCON1+0 
;P7a.c,41 :: 		Lcd_Init (); //Iniciamos el circuito de la pantalla LCD
	CALL        _Lcd_Init+0, 0
;P7a.c,43 :: 		PIR1.ADIF=0;
	BCF         PIR1+0, 6 
;P7a.c,44 :: 		PIE1.ADIE=1;
	BSF         PIE1+0, 6 
;P7a.c,45 :: 		INTCON.PEIE=1;
	BSF         INTCON+0, 6 
;P7a.c,46 :: 		INTCON.GIE=1;
	BSF         INTCON+0, 7 
;P7a.c,48 :: 		ADCON0.GO=1; //Comienza el muestreo de la señal analogica
	BSF         ADCON0+0, 2 
;P7a.c,49 :: 		while(1);
L_main1:
	GOTO        L_main1
;P7a.c,50 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
