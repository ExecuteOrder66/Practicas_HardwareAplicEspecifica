
_abrir:

;Ej_UNO_Proyecto.c,7 :: 		void abrir(){
;Ej_UNO_Proyecto.c,8 :: 		PORTC.B0=0;
	BCF         PORTC+0, 0 
;Ej_UNO_Proyecto.c,9 :: 		PORTC.B1=1;
	BSF         PORTC+0, 1 
;Ej_UNO_Proyecto.c,10 :: 		}
L_end_abrir:
	RETURN      0
; end of _abrir

_cerrar:

;Ej_UNO_Proyecto.c,12 :: 		void cerrar(){
;Ej_UNO_Proyecto.c,13 :: 		PORTC.B1=0;
	BCF         PORTC+0, 1 
;Ej_UNO_Proyecto.c,14 :: 		PORTC.B0=1;
	BSF         PORTC+0, 0 
;Ej_UNO_Proyecto.c,15 :: 		}
L_end_cerrar:
	RETURN      0
; end of _cerrar

_parar:

;Ej_UNO_Proyecto.c,17 :: 		void parar(){
;Ej_UNO_Proyecto.c,18 :: 		PORTC.B0=0;
	BCF         PORTC+0, 0 
;Ej_UNO_Proyecto.c,19 :: 		PORTC.B1=0;
	BCF         PORTC+0, 1 
;Ej_UNO_Proyecto.c,20 :: 		}
L_end_parar:
	RETURN      0
; end of _parar

_interrupt:

;Ej_UNO_Proyecto.c,22 :: 		void interrupt(){
;Ej_UNO_Proyecto.c,24 :: 		if(PIR1.TMR1IF){
	BTFSS       PIR1+0, 0 
	GOTO        L_interrupt0
;Ej_UNO_Proyecto.c,25 :: 		TMR1H=(15536>>8);
	MOVLW       60
	MOVWF       TMR1H+0 
;Ej_UNO_Proyecto.c,26 :: 		TMR1L=15536;
	MOVLW       176
	MOVWF       TMR1L+0 
;Ej_UNO_Proyecto.c,27 :: 		PIR1.TMR1IF=0;
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
;Ej_UNO_Proyecto.c,32 :: 		if(estado==0){ // estado de puerta cerrada
	MOVF        _estado+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt1
;Ej_UNO_Proyecto.c,34 :: 		if(presencia==1){
	MOVF        _presencia+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt2
;Ej_UNO_Proyecto.c,35 :: 		abrir();
	CALL        _abrir+0, 0
;Ej_UNO_Proyecto.c,36 :: 		estado=1;
	MOVLW       1
	MOVWF       _estado+0 
;Ej_UNO_Proyecto.c,37 :: 		}
L_interrupt2:
;Ej_UNO_Proyecto.c,39 :: 		}
L_interrupt1:
;Ej_UNO_Proyecto.c,41 :: 		if(estado==1){ // estado de puerta abriendose
	MOVF        _estado+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt3
;Ej_UNO_Proyecto.c,43 :: 		if(abierta==1){
	MOVF        _abierta+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt4
;Ej_UNO_Proyecto.c,44 :: 		parar();
	CALL        _parar+0, 0
;Ej_UNO_Proyecto.c,45 :: 		estado=2;
	MOVLW       2
	MOVWF       _estado+0 
;Ej_UNO_Proyecto.c,46 :: 		}
L_interrupt4:
;Ej_UNO_Proyecto.c,53 :: 		}
L_interrupt3:
;Ej_UNO_Proyecto.c,55 :: 		if(estado==2){ // estado de puerta abierta
	MOVF        _estado+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt5
;Ej_UNO_Proyecto.c,57 :: 		if(temporizador==0){
	MOVF        _temporizador+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt6
;Ej_UNO_Proyecto.c,58 :: 		T0CON.TMR0ON=1;  //encendemos temporizacion
	BSF         T0CON+0, 7 
;Ej_UNO_Proyecto.c,59 :: 		temporizador++;
	INCF        _temporizador+0, 1 
;Ej_UNO_Proyecto.c,60 :: 		}
L_interrupt6:
;Ej_UNO_Proyecto.c,61 :: 		if(INTCON.TMR0IF){      //Se acaba la temporizacion
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt7
;Ej_UNO_Proyecto.c,62 :: 		T0CON.TMR0ON=0;   //Apagamos contador
	BCF         T0CON+0, 7 
;Ej_UNO_Proyecto.c,63 :: 		temporizador=0;
	CLRF        _temporizador+0 
;Ej_UNO_Proyecto.c,64 :: 		if (presencia==0){  //No se detecta presencia
	MOVF        _presencia+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt8
;Ej_UNO_Proyecto.c,65 :: 		cerrar();        //Pasamos al estado cerrandose
	CALL        _cerrar+0, 0
;Ej_UNO_Proyecto.c,66 :: 		estado=3;
	MOVLW       3
	MOVWF       _estado+0 
;Ej_UNO_Proyecto.c,67 :: 		}
L_interrupt8:
;Ej_UNO_Proyecto.c,68 :: 		}
L_interrupt7:
;Ej_UNO_Proyecto.c,71 :: 		}
L_interrupt5:
;Ej_UNO_Proyecto.c,73 :: 		if(estado==3){ // estado de puerta cerrandose
	MOVF        _estado+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt9
;Ej_UNO_Proyecto.c,75 :: 		if(cerrada==1){
	MOVF        _cerrada+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt10
;Ej_UNO_Proyecto.c,76 :: 		parar();
	CALL        _parar+0, 0
;Ej_UNO_Proyecto.c,77 :: 		estado=0;
	CLRF        _estado+0 
;Ej_UNO_Proyecto.c,78 :: 		}
L_interrupt10:
;Ej_UNO_Proyecto.c,85 :: 		}
L_interrupt9:
;Ej_UNO_Proyecto.c,87 :: 		}
L_interrupt0:
;Ej_UNO_Proyecto.c,89 :: 		INTCON.TMR0IF=0; //Deshabilitamos flag interrupcion
	BCF         INTCON+0, 2 
;Ej_UNO_Proyecto.c,90 :: 		}
L_end_interrupt:
L__interrupt17:
	RETFIE      1
; end of _interrupt

_main:

;Ej_UNO_Proyecto.c,92 :: 		void main() {
;Ej_UNO_Proyecto.c,94 :: 		TRISC.B0=0;
	BCF         TRISC+0, 0 
;Ej_UNO_Proyecto.c,95 :: 		TRISC.B1=0;
	BCF         TRISC+0, 1 
;Ej_UNO_Proyecto.c,96 :: 		TRISB.B0=1;
	BSF         TRISB+0, 0 
;Ej_UNO_Proyecto.c,97 :: 		TRISB.B1=1;
	BSF         TRISB+0, 1 
;Ej_UNO_Proyecto.c,98 :: 		TRISB.B2=1;
	BSF         TRISB+0, 2 
;Ej_UNO_Proyecto.c,99 :: 		PORTC.B0=0;
	BCF         PORTC+0, 0 
;Ej_UNO_Proyecto.c,100 :: 		PORTC.B1=0;
	BCF         PORTC+0, 1 
;Ej_UNO_Proyecto.c,102 :: 		INTCON.TMR0IF=0;
	BCF         INTCON+0, 2 
;Ej_UNO_Proyecto.c,103 :: 		INTCON.TMR0IE=1;
	BSF         INTCON+0, 5 
;Ej_UNO_Proyecto.c,104 :: 		T0CON=0x07; //Prescaler 256, modo 16bits  Se activa al tener la puerta abierta (5s)
	MOVLW       7
	MOVWF       T0CON+0 
;Ej_UNO_Proyecto.c,105 :: 		TMR0H=(26474>>8);    //Alfa para temporizacion 5s
	MOVLW       103
	MOVWF       TMR0H+0 
;Ej_UNO_Proyecto.c,106 :: 		TMR0L=26474;           //Alfa para temporizacion 5s
	MOVLW       106
	MOVWF       TMR0L+0 
;Ej_UNO_Proyecto.c,108 :: 		T1CON=0xA5;
	MOVLW       165
	MOVWF       T1CON+0 
;Ej_UNO_Proyecto.c,109 :: 		TMR1H=(15536>>8);
	MOVLW       60
	MOVWF       TMR1H+0 
;Ej_UNO_Proyecto.c,110 :: 		TMR1L=15536;
	MOVLW       176
	MOVWF       TMR1L+0 
;Ej_UNO_Proyecto.c,111 :: 		PIR1.TMR1IF=0;
	BCF         PIR1+0, 0 
;Ej_UNO_Proyecto.c,112 :: 		PIE1.TMR1IE=1;
	BSF         PIE1+0, 0 
;Ej_UNO_Proyecto.c,113 :: 		INTCON.PEIE=1;
	BSF         INTCON+0, 6 
;Ej_UNO_Proyecto.c,114 :: 		INTCON.GIE=1;
	BSF         INTCON+0, 7 
;Ej_UNO_Proyecto.c,117 :: 		while(1)
L_main11:
;Ej_UNO_Proyecto.c,118 :: 		asm nop;
	NOP
	GOTO        L_main11
;Ej_UNO_Proyecto.c,120 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
