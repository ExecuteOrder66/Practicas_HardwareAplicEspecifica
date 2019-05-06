
_interrupt:

;P7b.c,19 :: 		void interrupt(){
;P7b.c,21 :: 		if(PIR1.ADIF){
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt0
;P7b.c,23 :: 		x=0;
	CLRF        _x+0 
	CLRF        _x+1 
;P7b.c,24 :: 		x=((ADRESH<<8) + ADRESL);      //Cargamos el valor muestreado de la tensión de entrada
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
;P7b.c,25 :: 		v= x*0.48828125;             //Este valor numero es la resolucion del convertidor A/D---->   resolucion= (Vref+ - Vref-)/2^n  (en este caso n=10)
	CALL        _word2double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       122
	MOVWF       R6 
	MOVLW       125
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
;P7b.c,29 :: 		Lcd_Cmd(_LCD_CLEAR);     //Borramos pantalla lcd
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;P7b.c,30 :: 		FloatToStr(v,txt);
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
;P7b.c,31 :: 		Lcd_out(1,1,txt);        //Mostramos resultado por pantalla
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;P7b.c,32 :: 		PORTC.B1=!PORTC.B1;
	BTG         PORTC+0, 1 
;P7b.c,33 :: 		}
L_interrupt0:
;P7b.c,36 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt1
;P7b.c,37 :: 		PORTC.B0=!PORTC.B0;
	BTG         PORTC+0, 0 
;P7b.c,38 :: 		TMR0H= (18661>>8);      //Reseteamos el valor de alfa para hacer otra temporizacion de 1.5s
	MOVLW       72
	MOVWF       TMR0H+0 
;P7b.c,39 :: 		TMR0L= 18661;
	MOVLW       229
	MOVWF       TMR0L+0 
;P7b.c,40 :: 		ADCON0.GO=1;  //Comienza el muestreo de la señal analogica otra vez
	BSF         ADCON0+0, 2 
;P7b.c,42 :: 		}
L_interrupt1:
;P7b.c,45 :: 		PIR1.ADIF=0;     //Deshabilitamos interrupcion
	BCF         PIR1+0, 6 
;P7b.c,46 :: 		INTCON.TMR0IF=0;
	BCF         INTCON+0, 2 
;P7b.c,47 :: 		}
L_end_interrupt:
L__interrupt5:
	RETFIE      1
; end of _interrupt

_main:

;P7b.c,50 :: 		void main() {
;P7b.c,51 :: 		TRISE.B1=1;  //Declarar RE1/AN6 como entrada
	BSF         TRISE+0, 1 
;P7b.c,52 :: 		TRISC=0;
	CLRF        TRISC+0 
;P7b.c,53 :: 		PORTC=0;
	CLRF        PORTC+0 
;P7b.c,54 :: 		ADCON0=0x71;      //Escogemos una combinacion en la que AN5 sea analogica y las tensiones de referencia vengan del micro (vdd y vss)
	MOVLW       113
	MOVWF       ADCON0+0 
;P7b.c,55 :: 		ADCON1=0xC0;     //prescaler 16 (el mas pequeño) Y AN5 analogica
	MOVLW       192
	MOVWF       ADCON1+0 
;P7b.c,57 :: 		Lcd_Init (); //Iniciamos el circuito de la pantalla LCD
	CALL        _Lcd_Init+0, 0
;P7b.c,60 :: 		INTCON.TMR0IF=0;
	BCF         INTCON+0, 2 
;P7b.c,61 :: 		INTCON.TMR0IE=1;
	BSF         INTCON+0, 5 
;P7b.c,64 :: 		PIR1.ADIF=0;
	BCF         PIR1+0, 6 
;P7b.c,65 :: 		PIE1.ADIE=1;
	BSF         PIE1+0, 6 
;P7b.c,66 :: 		INTCON.PEIE=1;
	BSF         INTCON+0, 6 
;P7b.c,67 :: 		INTCON.GIE=1;
	BSF         INTCON+0, 7 
;P7b.c,69 :: 		T0CON=0x85;
	MOVLW       133
	MOVWF       T0CON+0 
;P7b.c,70 :: 		TMR0H= (18661>>8);
	MOVLW       72
	MOVWF       TMR0H+0 
;P7b.c,71 :: 		TMR0L= 18661;
	MOVLW       229
	MOVWF       TMR0L+0 
;P7b.c,72 :: 		ADCON0.GO=1; //Comienza el muestreo de la señal analogica
	BSF         ADCON0+0, 2 
;P7b.c,74 :: 		while(1);
L_main2:
	GOTO        L_main2
;P7b.c,75 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
