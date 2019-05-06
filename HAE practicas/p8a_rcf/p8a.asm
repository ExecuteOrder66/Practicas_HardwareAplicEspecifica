
_representar:

;p8a.c,21 :: 		void representar(){
;p8a.c,23 :: 		v= x*0.0048828125*22.2;        //Este valor numero es la resolucion del convertidor A/D---->   resolucion= (Vref+ - Vref-)/2^n  (en este caso n=10)
	MOVF        _x+0, 0 
	MOVWF       R0 
	MOVF        _x+1, 0 
	MOVWF       R1 
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
	MOVLW       154
	MOVWF       R4 
	MOVLW       153
	MOVWF       R5 
	MOVLW       49
	MOVWF       R6 
	MOVLW       131
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
;p8a.c,24 :: 		v= v+10.5;                     //AQUI ya tenemos la presion en kPa
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       40
	MOVWF       R6 
	MOVLW       130
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
;p8a.c,25 :: 		for(i=0;i<7;i++) unidad[i]=0;     //Reseteamos cadena unidad
	CLRF        representar_i_L0+0 
L_representar0:
	MOVLW       7
	SUBWF       representar_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_representar1
	MOVLW       _unidad+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_unidad+0)
	MOVWF       FSR1H 
	MOVF        representar_i_L0+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
	INCF        representar_i_L0+0, 1 
	GOTO        L_representar0
L_representar1:
;p8a.c,26 :: 		switch(escala){
	GOTO        L_representar3
;p8a.c,27 :: 		case 1:  v= v /  6.8927;       //Caso Psi     1 Psi = 6’8927 kPa
L_representar5:
	MOVLW       0
	MOVWF       R4 
	MOVLW       145
	MOVWF       R5 
	MOVLW       92
	MOVWF       R6 
	MOVLW       129
	MOVWF       R7 
	MOVF        _v+0, 0 
	MOVWF       R0 
	MOVF        _v+1, 0 
	MOVWF       R1 
	MOVF        _v+2, 0 
	MOVWF       R2 
	MOVF        _v+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _v+0 
	MOVF        R1, 0 
	MOVWF       _v+1 
	MOVF        R2, 0 
	MOVWF       _v+2 
	MOVF        R3, 0 
	MOVWF       _v+3 
;p8a.c,28 :: 		unidad[0]='P'; unidad[1]='s'; unidad[2]='i';
	MOVLW       80
	MOVWF       _unidad+0 
	MOVLW       115
	MOVWF       _unidad+1 
	MOVLW       105
	MOVWF       _unidad+2 
;p8a.c,29 :: 		break;
	GOTO        L_representar4
;p8a.c,30 :: 		case 2:  v= v /  101.325;      //Caso Atm     1 Atm = 101’325 kPa
L_representar6:
	MOVLW       102
	MOVWF       R4 
	MOVLW       166
	MOVWF       R5 
	MOVLW       74
	MOVWF       R6 
	MOVLW       133
	MOVWF       R7 
	MOVF        _v+0, 0 
	MOVWF       R0 
	MOVF        _v+1, 0 
	MOVWF       R1 
	MOVF        _v+2, 0 
	MOVWF       R2 
	MOVF        _v+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _v+0 
	MOVF        R1, 0 
	MOVWF       _v+1 
	MOVF        R2, 0 
	MOVWF       _v+2 
	MOVF        R3, 0 
	MOVWF       _v+3 
;p8a.c,31 :: 		unidad[0]='A'; unidad[1]='t'; unidad[2]='m';
	MOVLW       65
	MOVWF       _unidad+0 
	MOVLW       116
	MOVWF       _unidad+1 
	MOVLW       109
	MOVWF       _unidad+2 
;p8a.c,32 :: 		break;
	GOTO        L_representar4
;p8a.c,33 :: 		case 3:  v=v / 0.1;            //Caso mBar    1 mBar = 0’1 kPa
L_representar7:
	MOVLW       205
	MOVWF       R4 
	MOVLW       204
	MOVWF       R5 
	MOVLW       76
	MOVWF       R6 
	MOVLW       123
	MOVWF       R7 
	MOVF        _v+0, 0 
	MOVWF       R0 
	MOVF        _v+1, 0 
	MOVWF       R1 
	MOVF        _v+2, 0 
	MOVWF       R2 
	MOVF        _v+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _v+0 
	MOVF        R1, 0 
	MOVWF       _v+1 
	MOVF        R2, 0 
	MOVWF       _v+2 
	MOVF        R3, 0 
	MOVWF       _v+3 
;p8a.c,34 :: 		unidad[0]='m'; unidad[1]='B'; unidad[2]='a'; unidad[3]='r';
	MOVLW       109
	MOVWF       _unidad+0 
	MOVLW       66
	MOVWF       _unidad+1 
	MOVLW       97
	MOVWF       _unidad+2 
	MOVLW       114
	MOVWF       _unidad+3 
;p8a.c,35 :: 		break;
	GOTO        L_representar4
;p8a.c,36 :: 		case 4:  v=v /  0.13328;               //Caso mmHg    1 mmHg = 0’13328 kPa
L_representar8:
	MOVLW       141
	MOVWF       R4 
	MOVLW       122
	MOVWF       R5 
	MOVLW       8
	MOVWF       R6 
	MOVLW       124
	MOVWF       R7 
	MOVF        _v+0, 0 
	MOVWF       R0 
	MOVF        _v+1, 0 
	MOVWF       R1 
	MOVF        _v+2, 0 
	MOVWF       R2 
	MOVF        _v+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _v+0 
	MOVF        R1, 0 
	MOVWF       _v+1 
	MOVF        R2, 0 
	MOVWF       _v+2 
	MOVF        R3, 0 
	MOVWF       _v+3 
;p8a.c,37 :: 		unidad[0]='m'; unidad[1]='m'; unidad[2]='H'; unidad[3]='g';
	MOVLW       109
	MOVWF       _unidad+0 
	MOVLW       109
	MOVWF       _unidad+1 
	MOVLW       72
	MOVWF       _unidad+2 
	MOVLW       103
	MOVWF       _unidad+3 
;p8a.c,38 :: 		break;
	GOTO        L_representar4
;p8a.c,39 :: 		case 5:  v=v / 0.001;   //Caso N/m2     1 N/m2 = 1 Pa = 0’001 kPa
L_representar9:
	MOVLW       111
	MOVWF       R4 
	MOVLW       18
	MOVWF       R5 
	MOVLW       3
	MOVWF       R6 
	MOVLW       117
	MOVWF       R7 
	MOVF        _v+0, 0 
	MOVWF       R0 
	MOVF        _v+1, 0 
	MOVWF       R1 
	MOVF        _v+2, 0 
	MOVWF       R2 
	MOVF        _v+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _v+0 
	MOVF        R1, 0 
	MOVWF       _v+1 
	MOVF        R2, 0 
	MOVWF       _v+2 
	MOVF        R3, 0 
	MOVWF       _v+3 
;p8a.c,40 :: 		unidad[0]='N'; unidad[1]='/'; unidad[2]='m'; unidad[3]='2';
	MOVLW       78
	MOVWF       _unidad+0 
	MOVLW       47
	MOVWF       _unidad+1 
	MOVLW       109
	MOVWF       _unidad+2 
	MOVLW       50
	MOVWF       _unidad+3 
;p8a.c,41 :: 		break;
	GOTO        L_representar4
;p8a.c,42 :: 		case 6:  v=v / 98.039;   //Caso Kg/cm2    1 Kg/cm2 = 98’039 kpa
L_representar10:
	MOVLW       248
	MOVWF       R4 
	MOVLW       19
	MOVWF       R5 
	MOVLW       68
	MOVWF       R6 
	MOVLW       133
	MOVWF       R7 
	MOVF        _v+0, 0 
	MOVWF       R0 
	MOVF        _v+1, 0 
	MOVWF       R1 
	MOVF        _v+2, 0 
	MOVWF       R2 
	MOVF        _v+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _v+0 
	MOVF        R1, 0 
	MOVWF       _v+1 
	MOVF        R2, 0 
	MOVWF       _v+2 
	MOVF        R3, 0 
	MOVWF       _v+3 
;p8a.c,43 :: 		unidad[0]='K'; unidad[1]='g'; unidad[2]='/'; unidad[3]='c';
	MOVLW       75
	MOVWF       _unidad+0 
	MOVLW       103
	MOVWF       _unidad+1 
	MOVLW       47
	MOVWF       _unidad+2 
	MOVLW       99
	MOVWF       _unidad+3 
;p8a.c,44 :: 		unidad[4]='m'; unidad[5]='2';
	MOVLW       109
	MOVWF       _unidad+4 
	MOVLW       50
	MOVWF       _unidad+5 
;p8a.c,45 :: 		break;
	GOTO        L_representar4
;p8a.c,46 :: 		case 7:   v= v / 9.81;   //Caso kp/cm2
L_representar11:
	MOVLW       195
	MOVWF       R4 
	MOVLW       245
	MOVWF       R5 
	MOVLW       28
	MOVWF       R6 
	MOVLW       130
	MOVWF       R7 
	MOVF        _v+0, 0 
	MOVWF       R0 
	MOVF        _v+1, 0 
	MOVWF       R1 
	MOVF        _v+2, 0 
	MOVWF       R2 
	MOVF        _v+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _v+0 
	MOVF        R1, 0 
	MOVWF       _v+1 
	MOVF        R2, 0 
	MOVWF       _v+2 
	MOVF        R3, 0 
	MOVWF       _v+3 
;p8a.c,47 :: 		unidad[0]='k'; unidad[1]='p'; unidad[2]='/'; unidad[3]='c';
	MOVLW       107
	MOVWF       _unidad+0 
	MOVLW       112
	MOVWF       _unidad+1 
	MOVLW       47
	MOVWF       _unidad+2 
	MOVLW       99
	MOVWF       _unidad+3 
;p8a.c,48 :: 		unidad[4]='m'; unidad[5]='2';
	MOVLW       109
	MOVWF       _unidad+4 
	MOVLW       50
	MOVWF       _unidad+5 
;p8a.c,49 :: 		break;
	GOTO        L_representar4
;p8a.c,50 :: 		default:   unidad[0]='k';     //Caso kPa POR DEFECTO
L_representar12:
	MOVLW       107
	MOVWF       _unidad+0 
;p8a.c,51 :: 		unidad[1]='P'; unidad[2]='a';
	MOVLW       80
	MOVWF       _unidad+1 
	MOVLW       97
	MOVWF       _unidad+2 
;p8a.c,52 :: 		break;
	GOTO        L_representar4
;p8a.c,53 :: 		}
L_representar3:
	MOVF        _escala+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_representar5
	MOVF        _escala+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_representar6
	MOVF        _escala+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_representar7
	MOVF        _escala+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_representar8
	MOVF        _escala+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_representar9
	MOVF        _escala+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_representar10
	MOVF        _escala+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_representar11
	GOTO        L_representar12
L_representar4:
;p8a.c,54 :: 		Lcd_Cmd(_LCD_CLEAR);     //Borramos pantalla lcd
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;p8a.c,55 :: 		FloatToStr(v,txt);
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
;p8a.c,56 :: 		Lcd_out(1,1,txt);        //Mostramos resultado por pantalla
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;p8a.c,57 :: 		Lcd_Chr_cp(' ');
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;p8a.c,58 :: 		Lcd_Out_CP(unidad);
	MOVLW       _unidad+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(_unidad+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;p8a.c,60 :: 		}
L_end_representar:
	RETURN      0
; end of _representar

_interrupt:

;p8a.c,62 :: 		void interrupt(){
;p8a.c,64 :: 		if(PIR1.ADIF){
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt13
;p8a.c,65 :: 		x=0;
	CLRF        _x+0 
	CLRF        _x+1 
;p8a.c,66 :: 		x=((ADRESH<<8) + ADRESL);      //Cargamos el valor muestreado de la tensión de entrada
	MOVF        ADRESH+0, 0 
	MOVWF       _x+1 
	CLRF        _x+0 
	MOVF        ADRESL+0, 0 
	ADDWF       _x+0, 1 
	MOVLW       0
	ADDWFC      _x+1, 1 
;p8a.c,71 :: 		representar();
	CALL        _representar+0, 0
;p8a.c,72 :: 		}
L_interrupt13:
;p8a.c,75 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt14
;p8a.c,76 :: 		PORTC.B0= !PORTC.B0;
	BTG         PORTC+0, 0 
;p8a.c,77 :: 		TMR0H= (3036>>8);      //Reseteamos el valor de alfa para hacer otra temporizacion de 1.5s
	MOVLW       11
	MOVWF       TMR0H+0 
;p8a.c,78 :: 		TMR0L= 3036;
	MOVLW       220
	MOVWF       TMR0L+0 
;p8a.c,79 :: 		ADCON0.GO=1;  //Comienza el muestreo de la señal analogica otra vez
	BSF         ADCON0+0, 2 
;p8a.c,81 :: 		}
L_interrupt14:
;p8a.c,83 :: 		if(INTCON3.INT2IF){
	BTFSS       INTCON3+0, 1 
	GOTO        L_interrupt15
;p8a.c,84 :: 		escala++;
	INCF        _escala+0, 1 
;p8a.c,85 :: 		escala= escala%8; //Modulo 8
	MOVLW       7
	ANDWF       _escala+0, 1 
;p8a.c,86 :: 		representar();
	CALL        _representar+0, 0
;p8a.c,87 :: 		}
L_interrupt15:
;p8a.c,89 :: 		PIR1.ADIF=0;     //Deshabilitamos interrupcion
	BCF         PIR1+0, 6 
;p8a.c,90 :: 		INTCON.TMR0IF=0;
	BCF         INTCON+0, 2 
;p8a.c,91 :: 		INTCON3.INT2IF=0;
	BCF         INTCON3+0, 1 
;p8a.c,92 :: 		}
L_end_interrupt:
L__interrupt20:
	RETFIE      1
; end of _interrupt

_main:

;p8a.c,94 :: 		void main() {
;p8a.c,95 :: 		TRISC.B0=0;
	BCF         TRISC+0, 0 
;p8a.c,96 :: 		PORTC.B0=0;
	BCF         PORTC+0, 0 
;p8a.c,97 :: 		TRISE.B0=1;  //Declarar RE0/AN5 como entrada
	BSF         TRISE+0, 0 
;p8a.c,98 :: 		TRISB.B2=1;           //portb.b2 como entrada
	BSF         TRISB+0, 2 
;p8a.c,100 :: 		ADCON0=0x69;      //Escogemos una combinacion en la que AN5 sea analogica y las tensiones de referencia vengan del micro (vdd y vss)
	MOVLW       105
	MOVWF       ADCON0+0 
;p8a.c,102 :: 		ADCON1=0xC0;     //prescaler 16 (el mas pequeño) Y AN5 analogica
	MOVLW       192
	MOVWF       ADCON1+0 
;p8a.c,104 :: 		Lcd_Init (); //Iniciamos el circuito de la pantalla LCD
	CALL        _Lcd_Init+0, 0
;p8a.c,106 :: 		INTCON2=0;            //Int0 por flancos de bajada, portb pull-ups activadas
	CLRF        INTCON2+0 
;p8a.c,108 :: 		INTCON3.INT2IF=0;
	BCF         INTCON3+0, 1 
;p8a.c,109 :: 		INTCON3.INT2IE=1;      //Habilitamos interrupcion para el boton
	BSF         INTCON3+0, 4 
;p8a.c,111 :: 		INTCON.TMR0IF=0;
	BCF         INTCON+0, 2 
;p8a.c,112 :: 		INTCON.TMR0IE=1;       //Habilitamos interrupcion del timer
	BSF         INTCON+0, 5 
;p8a.c,115 :: 		PIR1.ADIF=0;
	BCF         PIR1+0, 6 
;p8a.c,116 :: 		PIE1.ADIE=1;           //Habilitamos interrupcion para el convertidor A/D
	BSF         PIE1+0, 6 
;p8a.c,117 :: 		INTCON.PEIE=1;
	BSF         INTCON+0, 6 
;p8a.c,118 :: 		INTCON.GIE=1;
	BSF         INTCON+0, 7 
;p8a.c,120 :: 		T0CON=0x84;
	MOVLW       132
	MOVWF       T0CON+0 
;p8a.c,121 :: 		TMR0H= (3036>>8);
	MOVLW       11
	MOVWF       TMR0H+0 
;p8a.c,122 :: 		TMR0L= 3036;
	MOVLW       220
	MOVWF       TMR0L+0 
;p8a.c,123 :: 		ADCON0.GO=1; //Comienza el muestreo de la señal analogica
	BSF         ADCON0+0, 2 
;p8a.c,125 :: 		while(1);
L_main16:
	GOTO        L_main16
;p8a.c,126 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
