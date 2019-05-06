
_interrupt:

;p6c.c,3 :: 		void interrupt(){
;p6c.c,7 :: 		if(INTCON3.INT1IF && INTCON3.INT1IE){  //Si activamos el interruptor
	BTFSS       INTCON3+0, 0 
	GOTO        L_interrupt2
	BTFSS       INTCON3+0, 3 
	GOTO        L_interrupt2
L__interrupt9:
;p6c.c,8 :: 		if(contando==0){  //Si no estamos contando
	MOVF        _contando+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt3
;p6c.c,12 :: 		PORTC.B0=1;  //Ponemos RC0 a nivel alto
	BSF         PORTC+0, 0 
;p6c.c,13 :: 		T0CON=0x87;
	MOVLW       135
	MOVWF       T0CON+0 
;p6c.c,14 :: 		TMR0H=(18661>>8);    //Introducimos el alfa inicial;
	MOVLW       72
	MOVWF       TMR0H+0 
;p6c.c,15 :: 		TMR0L= 18661;
	MOVLW       229
	MOVWF       TMR0L+0 
;p6c.c,16 :: 		INTCON.TMR0IF=0;
	BCF         INTCON+0, 2 
;p6c.c,17 :: 		INTCON.TMR0IE=1;
	BSF         INTCON+0, 5 
;p6c.c,18 :: 		contando=1;
	MOVLW       1
	MOVWF       _contando+0 
;p6c.c,19 :: 		INTCON3.INT1IE=0;
	BCF         INTCON3+0, 3 
;p6c.c,20 :: 		}
L_interrupt3:
;p6c.c,21 :: 		INTCON3.INT1IF=0;
	BCF         INTCON3+0, 0 
;p6c.c,22 :: 		}
L_interrupt2:
;p6c.c,23 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt4
;p6c.c,24 :: 		INTCON.TMR0IF=0;
	BCF         INTCON+0, 2 
;p6c.c,25 :: 		if(temp<0){          //con temp<1 hace 2 temporizaciones, luego para hacer 10 temporizaciones-> temp<9
	MOVLW       0
	SUBWF       _temp+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt5
;p6c.c,26 :: 		temp++;
	INCF        _temp+0, 1 
;p6c.c,27 :: 		TMR0H=(18661>>8);    //Reseteamos el alfa inicial;
	MOVLW       72
	MOVWF       TMR0H+0 
;p6c.c,28 :: 		TMR0L= 18661;
	MOVLW       229
	MOVWF       TMR0L+0 
;p6c.c,30 :: 		}else{            //ya dimos las 10 iteraciones de 6s
	GOTO        L_interrupt6
L_interrupt5:
;p6c.c,31 :: 		temp=0;
	CLRF        _temp+0 
;p6c.c,32 :: 		contando=0;
	CLRF        _contando+0 
;p6c.c,33 :: 		PORTC.B0=0; //RC0 a nivel bajo, temporizacion ya terminada
	BCF         PORTC+0, 0 
;p6c.c,34 :: 		T0CON=0x07;
	MOVLW       7
	MOVWF       T0CON+0 
;p6c.c,35 :: 		INTCON3.INT1IE=1;
	BSF         INTCON3+0, 3 
;p6c.c,36 :: 		}
L_interrupt6:
;p6c.c,37 :: 		}
L_interrupt4:
;p6c.c,38 :: 		}
L_end_interrupt:
L__interrupt11:
	RETFIE      1
; end of _interrupt

_main:

;p6c.c,40 :: 		void main() {
;p6c.c,42 :: 		TRISB.B1=1;     //RB1 INPUT
	BSF         TRISB+0, 1 
;p6c.c,43 :: 		TRISC.B0=0;     //RC0 OUTPUT
	BCF         TRISC+0, 0 
;p6c.c,47 :: 		INTCON3.INT1IF=0;
	BCF         INTCON3+0, 0 
;p6c.c,49 :: 		INTCON2.INTEDG1=0;
	BCF         INTCON2+0, 5 
;p6c.c,52 :: 		INTCON3.INT1IE=1;
	BSF         INTCON3+0, 3 
;p6c.c,54 :: 		INTCON.GIE=1;
	BSF         INTCON+0, 7 
;p6c.c,56 :: 		while(1);
L_main7:
	GOTO        L_main7
;p6c.c,57 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
