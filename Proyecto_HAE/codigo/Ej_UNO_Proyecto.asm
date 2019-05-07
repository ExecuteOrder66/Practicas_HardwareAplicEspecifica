
_abrir:

;Ej_UNO_Proyecto.c,7 :: 		void abrir() {
;Ej_UNO_Proyecto.c,8 :: 		PORTC.B0 = 0;
	BCF         PORTC+0, 0 
;Ej_UNO_Proyecto.c,9 :: 		PORTC.B1 = 1;
	BSF         PORTC+0, 1 
;Ej_UNO_Proyecto.c,10 :: 		}
L_end_abrir:
	RETURN      0
; end of _abrir

_cerrar:

;Ej_UNO_Proyecto.c,12 :: 		void cerrar() {
;Ej_UNO_Proyecto.c,13 :: 		PORTC.B1 = 0;
	BCF         PORTC+0, 1 
;Ej_UNO_Proyecto.c,14 :: 		PORTC.B0 = 1;
	BSF         PORTC+0, 0 
;Ej_UNO_Proyecto.c,15 :: 		}
L_end_cerrar:
	RETURN      0
; end of _cerrar

_parar:

;Ej_UNO_Proyecto.c,17 :: 		void parar() {
;Ej_UNO_Proyecto.c,18 :: 		PORTC.B0 = 0;
	BCF         PORTC+0, 0 
;Ej_UNO_Proyecto.c,19 :: 		PORTC.B1 = 0;
	BCF         PORTC+0, 1 
;Ej_UNO_Proyecto.c,20 :: 		}
L_end_parar:
	RETURN      0
; end of _parar

_interrupt:

;Ej_UNO_Proyecto.c,22 :: 		void interrupt() {
;Ej_UNO_Proyecto.c,24 :: 		if (PIR1.TMR1IF) {
	BTFSS       PIR1+0, 0 
	GOTO        L_interrupt0
;Ej_UNO_Proyecto.c,25 :: 		TMR1H = (15536 >> 8);
	MOVLW       60
	MOVWF       TMR1H+0 
;Ej_UNO_Proyecto.c,26 :: 		TMR1L = 15536;
	MOVLW       176
	MOVWF       TMR1L+0 
;Ej_UNO_Proyecto.c,27 :: 		PIR1.TMR1IF = 0;
	BCF         PIR1+0, 0 
;Ej_UNO_Proyecto.c,28 :: 		cerrada = PORTB.B0;
	MOVLW       0
	BTFSC       PORTB+0, 0 
	MOVLW       1
	MOVWF       _cerrada+0 
;Ej_UNO_Proyecto.c,29 :: 		abierta = PORTB.B1;
	MOVLW       0
	BTFSC       PORTB+0, 1 
	MOVLW       1
	MOVWF       _abierta+0 
;Ej_UNO_Proyecto.c,30 :: 		presencia = PORTB.B2;
	MOVLW       0
	BTFSC       PORTB+0, 2 
	MOVLW       1
	MOVWF       _presencia+0 
;Ej_UNO_Proyecto.c,32 :: 		if (estado == 0) {
	MOVF        _estado+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt1
;Ej_UNO_Proyecto.c,33 :: 		if (presencia == 1) {
	MOVF        _presencia+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt2
;Ej_UNO_Proyecto.c,34 :: 		estado = 1;
	MOVLW       1
	MOVWF       _estado+0 
;Ej_UNO_Proyecto.c,35 :: 		abrir();
	CALL        _abrir+0, 0
;Ej_UNO_Proyecto.c,36 :: 		}
L_interrupt2:
;Ej_UNO_Proyecto.c,37 :: 		}
L_interrupt1:
;Ej_UNO_Proyecto.c,39 :: 		if (estado == 1) {
	MOVF        _estado+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt3
;Ej_UNO_Proyecto.c,40 :: 		if (abierta == 1) {
	MOVF        _abierta+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt4
;Ej_UNO_Proyecto.c,41 :: 		estado = 2;
	MOVLW       2
	MOVWF       _estado+0 
;Ej_UNO_Proyecto.c,42 :: 		parar();
	CALL        _parar+0, 0
;Ej_UNO_Proyecto.c,43 :: 		}
L_interrupt4:
;Ej_UNO_Proyecto.c,44 :: 		}
L_interrupt3:
;Ej_UNO_Proyecto.c,46 :: 		if (estado == 2) {
	MOVF        _estado+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt5
;Ej_UNO_Proyecto.c,47 :: 		if (presencia == 0) {
	MOVF        _presencia+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt6
;Ej_UNO_Proyecto.c,48 :: 		estado = 3;
	MOVLW       3
	MOVWF       _estado+0 
;Ej_UNO_Proyecto.c,49 :: 		T0CON = 0x06; //Se configura el Timer0 para 4 segundos
	MOVLW       6
	MOVWF       T0CON+0 
;Ej_UNO_Proyecto.c,50 :: 		TMR0H = (3036 >> 8);
	MOVLW       11
	MOVWF       TMR0H+0 
;Ej_UNO_Proyecto.c,51 :: 		TMR0L = 3036;
	MOVLW       220
	MOVWF       TMR0L+0 
;Ej_UNO_Proyecto.c,52 :: 		T0CON.TMR0ON = 1;
	BSF         T0CON+0, 7 
;Ej_UNO_Proyecto.c,53 :: 		PORTD.B0 = !PORTD.B0;
	BTG         PORTD+0, 0 
;Ej_UNO_Proyecto.c,54 :: 		}
L_interrupt6:
;Ej_UNO_Proyecto.c,55 :: 		}
L_interrupt5:
;Ej_UNO_Proyecto.c,57 :: 		if (estado == 3) {
	MOVF        _estado+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt7
;Ej_UNO_Proyecto.c,58 :: 		if (INTCON.TMR0IF) {
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt8
;Ej_UNO_Proyecto.c,59 :: 		T0CON.TMR0ON = 0;
	BCF         T0CON+0, 7 
;Ej_UNO_Proyecto.c,60 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;Ej_UNO_Proyecto.c,61 :: 		PORTD.B0 = !PORTD.B0;
	BTG         PORTD+0, 0 
;Ej_UNO_Proyecto.c,62 :: 		if (presencia == 1) {
	MOVF        _presencia+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt9
;Ej_UNO_Proyecto.c,63 :: 		estado = 2;
	MOVLW       2
	MOVWF       _estado+0 
;Ej_UNO_Proyecto.c,64 :: 		} else {
	GOTO        L_interrupt10
L_interrupt9:
;Ej_UNO_Proyecto.c,65 :: 		estado = 4;
	MOVLW       4
	MOVWF       _estado+0 
;Ej_UNO_Proyecto.c,66 :: 		cerrar();
	CALL        _cerrar+0, 0
;Ej_UNO_Proyecto.c,67 :: 		}
L_interrupt10:
;Ej_UNO_Proyecto.c,68 :: 		}
L_interrupt8:
;Ej_UNO_Proyecto.c,69 :: 		}
L_interrupt7:
;Ej_UNO_Proyecto.c,71 :: 		if (estado == 4) {
	MOVF        _estado+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt11
;Ej_UNO_Proyecto.c,72 :: 		if (cerrada == 1) {
	MOVF        _cerrada+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt12
;Ej_UNO_Proyecto.c,73 :: 		parar();
	CALL        _parar+0, 0
;Ej_UNO_Proyecto.c,74 :: 		estado = 0;
	CLRF        _estado+0 
;Ej_UNO_Proyecto.c,75 :: 		} else if (presencia == 1) {
	GOTO        L_interrupt13
L_interrupt12:
	MOVF        _presencia+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt14
;Ej_UNO_Proyecto.c,76 :: 		estado = 5;
	MOVLW       5
	MOVWF       _estado+0 
;Ej_UNO_Proyecto.c,77 :: 		parar();
	CALL        _parar+0, 0
;Ej_UNO_Proyecto.c,78 :: 		T0CON = 0x05; //Se configura el Timer0 para 2 segundos
	MOVLW       5
	MOVWF       T0CON+0 
;Ej_UNO_Proyecto.c,79 :: 		TMR0H = (3036 >> 8);
	MOVLW       11
	MOVWF       TMR0H+0 
;Ej_UNO_Proyecto.c,80 :: 		TMR0L = 3036;
	MOVLW       220
	MOVWF       TMR0L+0 
;Ej_UNO_Proyecto.c,81 :: 		T0CON.TMR0ON = 1;
	BSF         T0CON+0, 7 
;Ej_UNO_Proyecto.c,82 :: 		PORTD.B0 = !PORTD.B0;
	BTG         PORTD+0, 0 
;Ej_UNO_Proyecto.c,83 :: 		}
L_interrupt14:
L_interrupt13:
;Ej_UNO_Proyecto.c,84 :: 		}
L_interrupt11:
;Ej_UNO_Proyecto.c,86 :: 		if (estado == 5) {
	MOVF        _estado+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt15
;Ej_UNO_Proyecto.c,87 :: 		if (INTCON.TMR0IF) {
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt16
;Ej_UNO_Proyecto.c,88 :: 		T0CON.TMR0ON = 0;
	BCF         T0CON+0, 7 
;Ej_UNO_Proyecto.c,89 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;Ej_UNO_Proyecto.c,90 :: 		PORTD.B0 = !PORTD.B0;
	BTG         PORTD+0, 0 
;Ej_UNO_Proyecto.c,91 :: 		if (presencia == 1) {
	MOVF        _presencia+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt17
;Ej_UNO_Proyecto.c,92 :: 		estado = 1;
	MOVLW       1
	MOVWF       _estado+0 
;Ej_UNO_Proyecto.c,93 :: 		abrir();
	CALL        _abrir+0, 0
;Ej_UNO_Proyecto.c,94 :: 		} else {
	GOTO        L_interrupt18
L_interrupt17:
;Ej_UNO_Proyecto.c,95 :: 		estado = 4;
	MOVLW       4
	MOVWF       _estado+0 
;Ej_UNO_Proyecto.c,96 :: 		cerrar();
	CALL        _cerrar+0, 0
;Ej_UNO_Proyecto.c,97 :: 		}
L_interrupt18:
;Ej_UNO_Proyecto.c,98 :: 		}
L_interrupt16:
;Ej_UNO_Proyecto.c,99 :: 		}
L_interrupt15:
;Ej_UNO_Proyecto.c,100 :: 		}
L_interrupt0:
;Ej_UNO_Proyecto.c,101 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;Ej_UNO_Proyecto.c,102 :: 		}
L_end_interrupt:
L__interrupt25:
	RETFIE      1
; end of _interrupt

_main:

;Ej_UNO_Proyecto.c,104 :: 		void main() {
;Ej_UNO_Proyecto.c,106 :: 		TRISC.B0 = 0;
	BCF         TRISC+0, 0 
;Ej_UNO_Proyecto.c,107 :: 		TRISC.B1 = 0;
	BCF         TRISC+0, 1 
;Ej_UNO_Proyecto.c,108 :: 		TRISB.B0 = 1;
	BSF         TRISB+0, 0 
;Ej_UNO_Proyecto.c,109 :: 		TRISB.B1 = 1;
	BSF         TRISB+0, 1 
;Ej_UNO_Proyecto.c,110 :: 		TRISB.B2 = 1;
	BSF         TRISB+0, 2 
;Ej_UNO_Proyecto.c,111 :: 		TRISD.B0 = 0;
	BCF         TRISD+0, 0 
;Ej_UNO_Proyecto.c,112 :: 		PORTC.B0 = 0;
	BCF         PORTC+0, 0 
;Ej_UNO_Proyecto.c,113 :: 		PORTC.B1 = 0;
	BCF         PORTC+0, 1 
;Ej_UNO_Proyecto.c,114 :: 		PORTD.B0 = 0;
	BCF         PORTD+0, 0 
;Ej_UNO_Proyecto.c,116 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;Ej_UNO_Proyecto.c,117 :: 		INTCON.TMR0IE = 0;
	BCF         INTCON+0, 5 
;Ej_UNO_Proyecto.c,119 :: 		T1CON = 0xA5;
	MOVLW       165
	MOVWF       T1CON+0 
;Ej_UNO_Proyecto.c,120 :: 		TMR1H = (15536 >> 8);
	MOVLW       60
	MOVWF       TMR1H+0 
;Ej_UNO_Proyecto.c,121 :: 		TMR1L = 15536;
	MOVLW       176
	MOVWF       TMR1L+0 
;Ej_UNO_Proyecto.c,122 :: 		PIR1.TMR1IF = 0;
	BCF         PIR1+0, 0 
;Ej_UNO_Proyecto.c,123 :: 		PIE1.TMR1IE = 1;
	BSF         PIE1+0, 0 
;Ej_UNO_Proyecto.c,124 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;Ej_UNO_Proyecto.c,125 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;Ej_UNO_Proyecto.c,128 :: 		while (1)
L_main19:
;Ej_UNO_Proyecto.c,129 :: 		asm nop;
	NOP
	GOTO        L_main19
;Ej_UNO_Proyecto.c,131 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
