
_tecla:

;tecla12int.h,25 :: 		unsigned char tecla() // Esta funcion devuelve el valor asociado a la tecla
;tecla12int.h,28 :: 		unsigned char columna=0, fila, aux1=0x10, aux2;
	CLRF        tecla_columna_L0+0 
	MOVLW       16
	MOVWF       tecla_aux1_L0+0 
	MOVLW       49
	MOVWF       tecla_teclado_L0+0 
	MOVLW       50
	MOVWF       tecla_teclado_L0+1 
	MOVLW       51
	MOVWF       tecla_teclado_L0+2 
	MOVLW       52
	MOVWF       tecla_teclado_L0+3 
	MOVLW       53
	MOVWF       tecla_teclado_L0+4 
	MOVLW       54
	MOVWF       tecla_teclado_L0+5 
	MOVLW       55
	MOVWF       tecla_teclado_L0+6 
	MOVLW       56
	MOVWF       tecla_teclado_L0+7 
	MOVLW       57
	MOVWF       tecla_teclado_L0+8 
	MOVLW       42
	MOVWF       tecla_teclado_L0+9 
	MOVLW       48
	MOVWF       tecla_teclado_L0+10 
	MOVLW       35
	MOVWF       tecla_teclado_L0+11 
;tecla12int.h,32 :: 		delay_ms(Debounce);// antes de empezar a escanear las filas y las columnas se
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_tecla0:
	DECFSZ      R13, 1, 1
	BRA         L_tecla0
	DECFSZ      R12, 1, 1
	BRA         L_tecla0
	NOP
;tecla12int.h,34 :: 		for(fila=0; fila<Rows; fila++) // escaneamos las filas para averiguar la fila
	CLRF        tecla_fila_L0+0 
L_tecla1:
	MOVLW       4
	SUBWF       tecla_fila_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_tecla2
;tecla12int.h,36 :: 		if((PORTB&aux1)==0x00) break; //en la fila de la tecla pulsada hay un 0 y en
	MOVF        tecla_aux1_L0+0, 0 
	ANDWF       PORTB+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_tecla4
	GOTO        L_tecla2
L_tecla4:
;tecla12int.h,37 :: 		aux1=(aux1<<1);                //las demás hay un 1.
	RLCF        tecla_aux1_L0+0, 1 
	BCF         tecla_aux1_L0+0, 0 
;tecla12int.h,34 :: 		for(fila=0; fila<Rows; fila++) // escaneamos las filas para averiguar la fila
	INCF        tecla_fila_L0+0, 1 
;tecla12int.h,38 :: 		}
	GOTO        L_tecla1
L_tecla2:
;tecla12int.h,40 :: 		PORTB=0x01; // valor del puerto B para escanear la primera columna (columna=0).
	MOVLW       1
	MOVWF       PORTB+0 
;tecla12int.h,42 :: 		while((PORTB&MASK)!=MASK)// se escanean las columnas hasta que se encuentra la
L_tecla5:
	MOVLW       240
	ANDWF       PORTB+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       240
	BTFSC       STATUS+0, 2 
	GOTO        L_tecla6
;tecla12int.h,44 :: 		PORTB=(PORTB<<1);       //caso, las filas estarán todas a 1. Al escanear las
	MOVF        PORTB+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	MOVWF       PORTB+0 
;tecla12int.h,45 :: 		columna++;            //columnas se produce un flanco de subida en el terminal
	INCF        tecla_columna_L0+0, 1 
;tecla12int.h,46 :: 		}                      //correspondiente a la fila de la tecla pulsada, lo que
	GOTO        L_tecla5
L_tecla6:
;tecla12int.h,49 :: 		PORTB=0x00; //condiciones del PORTB de espera a que se pulse una nueva tecla
	CLRF        PORTB+0 
;tecla12int.h,51 :: 		do // esperamos a que se deje de pulsar la tecla para enviar su valor.
L_tecla7:
;tecla12int.h,52 :: 		{delay_ms(2);
	MOVLW       6
	MOVWF       R12, 0
	MOVLW       48
	MOVWF       R13, 0
L_tecla10:
	DECFSZ      R13, 1, 1
	BRA         L_tecla10
	DECFSZ      R12, 1, 1
	BRA         L_tecla10
	NOP
;tecla12int.h,53 :: 		}while((PORTB&0xF0)!=0xF0); //Al soltar la tecla, se produce un cambio de nivel
	MOVLW       240
	ANDWF       PORTB+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       240
	BTFSS       STATUS+0, 2 
	GOTO        L_tecla7
;tecla12int.h,57 :: 		aux2=teclado[fila][columna];//devuelve el valor ASCII de la tecla pulsada
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        tecla_fila_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       tecla_teclado_L0+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(tecla_teclado_L0+0)
	ADDWFC      R1, 1 
	MOVF        tecla_columna_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
;tecla12int.h,58 :: 		return aux2;
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
;tecla12int.h,59 :: 		}
L_end_tecla:
	RETURN      0
; end of _tecla

_interrupt:

;p5b.c,20 :: 		void interrupt(){
;p5b.c,21 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;p5b.c,22 :: 		if(contador==0){
	MOVF        _contador+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt11
;p5b.c,23 :: 		Lcd_out(1,1,"Turno:  0");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_p5b+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_p5b+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;p5b.c,24 :: 		uni++;
	INCF        _uni+0, 1 
;p5b.c,25 :: 		}
L_interrupt11:
;p5b.c,26 :: 		if(contador%2==1){       //Si el modulo da 1, indica que se ha pulsado el boton, salta la interrupcion al pulsar y al soltar el boton
	MOVLW       1
	ANDWF       _contador+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt12
;p5b.c,28 :: 		ByteToStr(uni,txt);
	MOVF        _uni+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _txt+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;p5b.c,29 :: 		Lcd_out(1,7,txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;p5b.c,30 :: 		uni++;
	INCF        _uni+0, 1 
;p5b.c,31 :: 		if(uni==99)
	MOVF        _uni+0, 0 
	XORLW       99
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt13
;p5b.c,32 :: 		uni=0;
	CLRF        _uni+0 
L_interrupt13:
;p5b.c,35 :: 		}
L_interrupt12:
;p5b.c,36 :: 		contador++;   //Se incrementa el contador
	INCF        _contador+0, 1 
;p5b.c,37 :: 		x=PORTB;
	MOVF        PORTB+0, 0 
	MOVWF       _x+0 
;p5b.c,38 :: 		INTCON.RBIF=0;
	BCF         INTCON+0, 0 
;p5b.c,39 :: 		}
L_end_interrupt:
L__interrupt18:
	RETFIE      1
; end of _interrupt

_main:

;p5b.c,41 :: 		void main() {
;p5b.c,42 :: 		TRISB=0x10; //Bit 4 puerto B como entrada
	MOVLW       16
	MOVWF       TRISB+0 
;p5b.c,43 :: 		PORTB=0;
	CLRF        PORTB+0 
;p5b.c,45 :: 		INTCON2.RBPU=0; //se habilitan las resistencias de pullup del puerto B
	BCF         INTCON2+0, 7 
;p5b.c,46 :: 		x=PORTB; //para poder borrar el RBIF
	MOVF        PORTB+0, 0 
	MOVWF       _x+0 
;p5b.c,47 :: 		INTCON.RBIF=0;  //Creamos una falsa interrupcion
	BCF         INTCON+0, 0 
;p5b.c,48 :: 		INTCON.RBIE=1;
	BSF         INTCON+0, 3 
;p5b.c,49 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;p5b.c,51 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;p5b.c,53 :: 		INTCON.RBIF=1;
	BSF         INTCON+0, 0 
;p5b.c,54 :: 		while(1){
L_main14:
;p5b.c,56 :: 		}
	GOTO        L_main14
;p5b.c,57 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
