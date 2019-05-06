
_interrupt:

;p6a.c,1 :: 		void interrupt(){
;p6a.c,2 :: 		INTCON.TMR0IF=0;    //Deshabilitamos interrupción
	BCF         INTCON+0, 2 
;p6a.c,4 :: 		PORTC.B0=!PORTC.B0; //Cambia estado del terminal RC0
	BTG         PORTC+0, 0 
;p6a.c,5 :: 		if(PORTC.B0==0){
	BTFSC       PORTC+0, 0 
	GOTO        L_interrupt0
;p6a.c,7 :: 		TMR0L=81;      //Introducimos nuevo alfa para t=0'7ms
	MOVLW       81
	MOVWF       TMR0L+0 
;p6a.c,8 :: 		T0CON=0xC2;     //Encendemos temporizador para caso t=0.7ms y prescaler 8
	MOVLW       194
	MOVWF       T0CON+0 
;p6a.c,10 :: 		}else{
	GOTO        L_interrupt1
L_interrupt0:
;p6a.c,12 :: 		TMR0L=106;  //alfa para t=0'3ms precaler 4
	MOVLW       106
	MOVWF       TMR0L+0 
;p6a.c,13 :: 		T0CON=0xC1; //Encendemos temporizador para t=0'3ms y precaler 4
	MOVLW       193
	MOVWF       T0CON+0 
;p6a.c,15 :: 		}
L_interrupt1:
;p6a.c,17 :: 		}
L_end_interrupt:
L__interrupt5:
	RETFIE      1
; end of _interrupt

_main:

;p6a.c,18 :: 		void main() {
;p6a.c,20 :: 		TRISC=0;
	CLRF        TRISC+0 
;p6a.c,21 :: 		PORTC=0;
	CLRF        PORTC+0 
;p6a.c,23 :: 		T0CON=0x41;
	MOVLW       65
	MOVWF       T0CON+0 
;p6a.c,25 :: 		INTCON.TMR0IF=0;
	BCF         INTCON+0, 2 
;p6a.c,26 :: 		INTCON.TMR0IE=1;
	BSF         INTCON+0, 5 
;p6a.c,27 :: 		INTCON.GIE=1;
	BSF         INTCON+0, 7 
;p6a.c,29 :: 		TMR0L=106;        //Aqui introducimos el valor inicial (alfa)
	MOVLW       106
	MOVWF       TMR0L+0 
;p6a.c,31 :: 		T0CON=0xC1; //Activamos el temporizador
	MOVLW       193
	MOVWF       T0CON+0 
;p6a.c,32 :: 		while(1);
L_main2:
	GOTO        L_main2
;p6a.c,33 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
