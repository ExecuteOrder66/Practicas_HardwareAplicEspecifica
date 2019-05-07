
_interrupt:

;emisor.c,6 :: 		void interrupt(){
;emisor.c,8 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt0
;emisor.c,9 :: 		PORTB.B0 = !PORTB.B0;
	BTG         PORTB+0, 0 
;emisor.c,10 :: 		TMR0H = (18661>>8);
	MOVLW       72
	MOVWF       TMR0H+0 
;emisor.c,11 :: 		TMR0L = 18661;
	MOVLW       229
	MOVWF       TMR0L+0 
;emisor.c,12 :: 		ADCON0.B1 = 1;
	BSF         ADCON0+0, 1 
;emisor.c,13 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;emisor.c,14 :: 		}
L_interrupt0:
;emisor.c,16 :: 		if(PIR1.ADIF){
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt1
;emisor.c,17 :: 		valorConv = ADRESL + (ADRESH << 8);
	MOVF        ADRESH+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        ADRESL+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	CALL        _word2double+0, 0
	MOVF        R0, 0 
	MOVWF       _valorConv+0 
	MOVF        R1, 0 
	MOVWF       _valorConv+1 
	MOVF        R2, 0 
	MOVWF       _valorConv+2 
	MOVF        R3, 0 
	MOVWF       _valorConv+3 
;emisor.c,18 :: 		volt = valorConv * 5 / 1024;        // Multiplicamos por resolucion del convertidor para obtener voltaje leido
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       129
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       137
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _volt+0 
	MOVF        R1, 0 
	MOVWF       _volt+1 
	MOVF        R2, 0 
	MOVWF       _volt+2 
	MOVF        R3, 0 
	MOVWF       _volt+3 
;emisor.c,19 :: 		temper = 100.0 * volt -50.0;  // Calculamos temperatura a partir del voltaje
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       133
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       132
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _temper+0 
	MOVF        R1, 0 
	MOVWF       _temper+1 
	MOVF        R2, 0 
	MOVWF       _temper+2 
	MOVF        R3, 0 
	MOVWF       _temper+3 
;emisor.c,20 :: 		puntero = &temper;   //puntero se le asigna el valor de la direccion de memoria de temper
	MOVLW       _temper+0
	MOVWF       _puntero+0 
	MOVLW       hi_addr(_temper+0)
	MOVWF       _puntero+1 
;emisor.c,23 :: 		UART1_Write(*puntero);    //envio 1er byte
	MOVFF       _puntero+0, FSR0
	MOVFF       _puntero+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;emisor.c,24 :: 		delay_ms(10);
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_interrupt2:
	DECFSZ      R13, 1, 1
	BRA         L_interrupt2
	DECFSZ      R12, 1, 1
	BRA         L_interrupt2
	NOP
;emisor.c,25 :: 		UART1_Write(*(puntero+1));     //envio 2o byte
	MOVLW       1
	ADDWF       _puntero+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _puntero+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;emisor.c,26 :: 		delay_ms(10);
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_interrupt3:
	DECFSZ      R13, 1, 1
	BRA         L_interrupt3
	DECFSZ      R12, 1, 1
	BRA         L_interrupt3
	NOP
;emisor.c,27 :: 		UART1_Write(*(puntero+2));      //envio 3er byte
	MOVLW       2
	ADDWF       _puntero+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _puntero+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;emisor.c,28 :: 		delay_ms(10);
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_interrupt4:
	DECFSZ      R13, 1, 1
	BRA         L_interrupt4
	DECFSZ      R12, 1, 1
	BRA         L_interrupt4
	NOP
;emisor.c,29 :: 		UART1_Write(*(puntero+3));      //envio 4o byte
	MOVLW       3
	ADDWF       _puntero+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      _puntero+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;emisor.c,30 :: 		delay_ms(10);
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_interrupt5:
	DECFSZ      R13, 1, 1
	BRA         L_interrupt5
	DECFSZ      R12, 1, 1
	BRA         L_interrupt5
	NOP
;emisor.c,32 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;emisor.c,33 :: 		}
L_interrupt1:
;emisor.c,34 :: 		}
L_end_interrupt:
L__interrupt10:
	RETFIE      1
; end of _interrupt

_main:

;emisor.c,36 :: 		void main() {
;emisor.c,37 :: 		ADCON1 = 0x00;
	CLRF        ADCON1+0 
;emisor.c,38 :: 		ADCON0 = 0x03;
	MOVLW       3
	MOVWF       ADCON0+0 
;emisor.c,39 :: 		ADCON2 = 0x8D;
	MOVLW       141
	MOVWF       ADCON2+0 
;emisor.c,41 :: 		TRISB =0;
	CLRF        TRISB+0 
;emisor.c,43 :: 		T0CON = 0X85;       //Temporizacion de 1.5s prescaler 64
	MOVLW       133
	MOVWF       T0CON+0 
;emisor.c,44 :: 		TMR0H = (18661>>8);      //alfa para 1.5s
	MOVLW       72
	MOVWF       TMR0H+0 
;emisor.c,45 :: 		TMR0L = 18661;           //alfa para 1.5s
	MOVLW       229
	MOVWF       TMR0L+0 
;emisor.c,47 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;emisor.c,48 :: 		delay_ms(300);
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       12
	MOVWF       R12, 0
	MOVLW       51
	MOVWF       R13, 0
L_main6:
	DECFSZ      R13, 1, 1
	BRA         L_main6
	DECFSZ      R12, 1, 1
	BRA         L_main6
	DECFSZ      R11, 1, 1
	BRA         L_main6
	NOP
	NOP
;emisor.c,50 :: 		INTCON.TMR0IF = 0;    //deshabiltiar flag interrupcion
	BCF         INTCON+0, 2 
;emisor.c,51 :: 		INTCON.TMR0IE = 1;   //habilitamos interrupciones TMR0
	BSF         INTCON+0, 5 
;emisor.c,53 :: 		PIR1.ADIF = 0;   //deshabilitamos flag interrupcion convertidor A/D
	BCF         PIR1+0, 6 
;emisor.c,54 :: 		PIE1.ADIE = 1;   //habilitamos interrupciones convertidor A/D
	BSF         PIE1+0, 6 
;emisor.c,56 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;emisor.c,57 :: 		INTCON.GIE = 1;    // habilitamos interrupciones en general
	BSF         INTCON+0, 7 
;emisor.c,59 :: 		ADCON0.B1 = 1;    //comienza conversion convertidor A/D
	BSF         ADCON0+0, 1 
;emisor.c,62 :: 		while(1){
L_main7:
;emisor.c,63 :: 		asm nop;
	NOP
;emisor.c,64 :: 		}
	GOTO        L_main7
;emisor.c,65 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
