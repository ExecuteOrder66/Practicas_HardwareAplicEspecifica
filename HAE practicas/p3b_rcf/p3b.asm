
_main:

;p3b.c,1 :: 		void main() {
;p3b.c,4 :: 		ADCON1 = 0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;p3b.c,5 :: 		RBPU_bit=0;   //Activamos resistencia pull-up de RB0
	BCF         RBPU_bit+0, BitPos(RBPU_bit+0) 
;p3b.c,6 :: 		TRISB.B0=1;
	BSF         TRISB+0, 0 
;p3b.c,7 :: 		INTCON.PEIE=0;            //Interrupcion tipo core
	BCF         INTCON+0, 6 
;p3b.c,8 :: 		RCON.IPEN=0;              //No emplearemos prioridad en las interrupciones
	BCF         RCON+0, 7 
;p3b.c,9 :: 		INTCON2.INTEDG0=0;        //Interrupcion por flanco de bajada
	BCF         INTCON2+0, 6 
;p3b.c,10 :: 		INTCON.INT0IF=0;          //Flag de interrupcion a 0
	BCF         INTCON+0, 1 
;p3b.c,11 :: 		INTCON.INT0IE=1;          //Habilitamos interrupciones en el puerto INT0  (o RB0)
	BSF         INTCON+0, 4 
;p3b.c,12 :: 		INTCON.GIE=1;             //Habilitamos interrupciones de forma global
	BSF         INTCON+0, 7 
;p3b.c,14 :: 		while(1){
L_main0:
;p3b.c,16 :: 		}
	GOTO        L_main0
;p3b.c,17 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt:

;p3b.c,19 :: 		void interrupt(){
;p3b.c,21 :: 		PORTB.B1=!PORTB.B1;              //Encendemos el led si estaba apagado y viceversa, hace una operación NOT
	BTG         PORTB+0, 1 
;p3b.c,23 :: 		INTCON.INT0IF=0;                 //Deshabilitamos flag de interrupcion
	BCF         INTCON+0, 1 
;p3b.c,24 :: 		}
L_end_interrupt:
L__interrupt4:
	RETFIE      1
; end of _interrupt
