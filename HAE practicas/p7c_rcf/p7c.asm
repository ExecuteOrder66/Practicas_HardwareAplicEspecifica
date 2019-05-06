
_representar:

;p7c.c,22 :: 		void representar(){
;p7c.c,23 :: 		v= x*0.48828125;        //Este valor numero es la resolucion del convertidor A/D---->   resolucion= (Vref+ - Vref-)/2^n  (en este caso n=10)
	MOVF        _x+0, 0 
	MOVWF       R0 
	MOVF        _x+1, 0 
	MOVWF       R1 
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
;p7c.c,24 :: 		unidad='C';
	MOVLW       67
	MOVWF       _unidad+0 
;p7c.c,25 :: 		if(escala==1){   //Escala Farenheit
	MOVF        _escala+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_representar0
;p7c.c,26 :: 		v= 32.0 + v * 1.8;             //MOSTRAR UNIDADES
	MOVF        _v+0, 0 
	MOVWF       R0 
	MOVF        _v+1, 0 
	MOVWF       R1 
	MOVF        _v+2, 0 
	MOVWF       R2 
	MOVF        _v+3, 0 
	MOVWF       R3 
	MOVLW       102
	MOVWF       R4 
	MOVLW       102
	MOVWF       R5 
	MOVLW       102
	MOVWF       R6 
	MOVLW       127
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       132
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _v+0 
	MOVF        R1, 0 
	MOVWF       _v+1 
	MOVF        R2, 0 
	MOVWF       _v+2 
	MOVF        R3, 0 
	MOVWF       _v+3 
;p7c.c,27 :: 		unidad='F';
	MOVLW       70
	MOVWF       _unidad+0 
;p7c.c,28 :: 		}else if(escala==2){       //Escala Kelvin
	GOTO        L_representar1
L_representar0:
	MOVF        _escala+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_representar2
;p7c.c,29 :: 		v= v + 273.15;                 //MOSTRAR UNIDADES
	MOVF        _v+0, 0 
	MOVWF       R0 
	MOVF        _v+1, 0 
	MOVWF       R1 
	MOVF        _v+2, 0 
	MOVWF       R2 
	MOVF        _v+3, 0 
	MOVWF       R3 
	MOVLW       51
	MOVWF       R4 
	MOVLW       147
	MOVWF       R5 
	MOVLW       8
	MOVWF       R6 
	MOVLW       135
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _v+0 
	MOVF        R1, 0 
	MOVWF       _v+1 
	MOVF        R2, 0 
	MOVWF       _v+2 
	MOVF        R3, 0 
	MOVWF       _v+3 
;p7c.c,30 :: 		unidad='K';
	MOVLW       75
	MOVWF       _unidad+0 
;p7c.c,31 :: 		}
L_representar2:
L_representar1:
;p7c.c,33 :: 		Lcd_Cmd(_LCD_CLEAR);     //Borramos pantalla lcd
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;p7c.c,34 :: 		FloatToStr(v,txt);
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
;p7c.c,35 :: 		Lcd_out(1,1,txt);        //Mostramos resultado por pantalla
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;p7c.c,36 :: 		Lcd_Chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;p7c.c,37 :: 		Lcd_Chr_cp(223);
	MOVLW       223
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;p7c.c,38 :: 		Lcd_Chr_cp(unidad);
	MOVF        _unidad+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;p7c.c,40 :: 		}
L_end_representar:
	RETURN      0
; end of _representar

_interrupt:

;p7c.c,42 :: 		void interrupt(){
;p7c.c,44 :: 		if(PIR1.ADIF){
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt3
;p7c.c,46 :: 		x=0;
	CLRF        _x+0 
	CLRF        _x+1 
;p7c.c,47 :: 		x=((ADRESH<<8) + ADRESL);      //Cargamos el valor muestreado de la tensión de entrada
	MOVF        ADRESH+0, 0 
	MOVWF       _x+1 
	CLRF        _x+0 
	MOVF        ADRESL+0, 0 
	ADDWF       _x+0, 1 
	MOVLW       0
	ADDWFC      _x+1, 1 
;p7c.c,52 :: 		representar();
	CALL        _representar+0, 0
;p7c.c,53 :: 		}
L_interrupt3:
;p7c.c,56 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt4
;p7c.c,57 :: 		PORTC.B0= !PORTC.B0;
	BTG         PORTC+0, 0 
;p7c.c,58 :: 		TMR0H= (18661>>8);      //Reseteamos el valor de alfa para hacer otra temporizacion de 1.5s
	MOVLW       72
	MOVWF       TMR0H+0 
;p7c.c,59 :: 		TMR0L= 18661;
	MOVLW       229
	MOVWF       TMR0L+0 
;p7c.c,60 :: 		ADCON0.GO=1;  //Comienza el muestreo de la señal analogica otra vez
	BSF         ADCON0+0, 2 
;p7c.c,62 :: 		}
L_interrupt4:
;p7c.c,64 :: 		if(INTCON.INT0IF){                  //VER PROBLEMAS DE LATENCIA, CAMBIO DE UNIDADES INSTANTANEO
	BTFSS       INTCON+0, 1 
	GOTO        L_interrupt5
;p7c.c,65 :: 		escala++;
	INCF        _escala+0, 1 
;p7c.c,66 :: 		escala= escala%3; //Modulo 3
	MOVLW       3
	MOVWF       R4 
	MOVF        _escala+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _escala+0 
;p7c.c,67 :: 		representar();
	CALL        _representar+0, 0
;p7c.c,68 :: 		}
L_interrupt5:
;p7c.c,70 :: 		PIR1.ADIF=0;     //Deshabilitamos interrupcion
	BCF         PIR1+0, 6 
;p7c.c,71 :: 		INTCON.TMR0IF=0;
	BCF         INTCON+0, 2 
;p7c.c,72 :: 		INTCON.INT0IF=0;
	BCF         INTCON+0, 1 
;p7c.c,73 :: 		}
L_end_interrupt:
L__interrupt10:
	RETFIE      1
; end of _interrupt

_main:

;p7c.c,76 :: 		void main() {
;p7c.c,77 :: 		TRISC.B0=0;
	BCF         TRISC+0, 0 
;p7c.c,78 :: 		PORTC.B0=0;
	BCF         PORTC+0, 0 
;p7c.c,79 :: 		TRISE.B1=1;  //Declarar RE1/AN6 como entrada
	BSF         TRISE+0, 1 
;p7c.c,80 :: 		TRISB.B0=1;           //REVISAR, portb.b1 como entrada
	BSF         TRISB+0, 0 
;p7c.c,82 :: 		ADCON0=0x71;      //Escogemos una combinacion en la que AN6 sea analogica y las tensiones de referencia vengan del micro (vdd y vss)
	MOVLW       113
	MOVWF       ADCON0+0 
;p7c.c,84 :: 		ADCON1=0xC0;     //prescaler 16 (el mas pequeño) Y AN6 analogica
	MOVLW       192
	MOVWF       ADCON1+0 
;p7c.c,86 :: 		Lcd_Init (); //Iniciamos el circuito de la pantalla LCD
	CALL        _Lcd_Init+0, 0
;p7c.c,88 :: 		INTCON2=0;            //Int0 por flancos de bajada, portb pull-ups activadas
	CLRF        INTCON2+0 
;p7c.c,90 :: 		INTCON.INT0IF=0;
	BCF         INTCON+0, 1 
;p7c.c,91 :: 		INTCON.INT0IE=1;
	BSF         INTCON+0, 4 
;p7c.c,93 :: 		INTCON.TMR0IF=0;
	BCF         INTCON+0, 2 
;p7c.c,94 :: 		INTCON.TMR0IE=1;
	BSF         INTCON+0, 5 
;p7c.c,97 :: 		PIR1.ADIF=0;
	BCF         PIR1+0, 6 
;p7c.c,98 :: 		PIE1.ADIE=1;
	BSF         PIE1+0, 6 
;p7c.c,99 :: 		INTCON.PEIE=1;
	BSF         INTCON+0, 6 
;p7c.c,100 :: 		INTCON.GIE=1;
	BSF         INTCON+0, 7 
;p7c.c,102 :: 		T0CON=0x85;
	MOVLW       133
	MOVWF       T0CON+0 
;p7c.c,103 :: 		TMR0H= (18661>>8);
	MOVLW       72
	MOVWF       TMR0H+0 
;p7c.c,104 :: 		TMR0L= 18661;
	MOVLW       229
	MOVWF       TMR0L+0 
;p7c.c,105 :: 		ADCON0.GO=1; //Comienza el muestreo de la señal analogica
	BSF         ADCON0+0, 2 
;p7c.c,107 :: 		while(1);
L_main6:
	GOTO        L_main6
;p7c.c,108 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
