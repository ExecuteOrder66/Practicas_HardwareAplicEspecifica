
_interrupt:

;p4b.c,4 :: 		void interrupt(){
;p4b.c,5 :: 		char bobinas []={0x01,0x03,0x02,0x06,0x04,0x0C,0x08,0x09};       //a-ab-b-bc-c-cd-d-da
	MOVLW       1
	MOVWF       interrupt_bobinas_L0+0 
	MOVLW       3
	MOVWF       interrupt_bobinas_L0+1 
	MOVLW       2
	MOVWF       interrupt_bobinas_L0+2 
	MOVLW       6
	MOVWF       interrupt_bobinas_L0+3 
	MOVLW       4
	MOVWF       interrupt_bobinas_L0+4 
	MOVLW       12
	MOVWF       interrupt_bobinas_L0+5 
	MOVLW       8
	MOVWF       interrupt_bobinas_L0+6 
	MOVLW       9
	MOVWF       interrupt_bobinas_L0+7 
	CLRF        interrupt_index_L0+0 
;p4b.c,7 :: 		if(giro135Hecho==0){
	MOVF        _giro135Hecho+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt0
;p4b.c,9 :: 		for(i=4;i<9;i+=2){
	MOVLW       4
	MOVWF       R1 
L_interrupt1:
	MOVLW       9
	SUBWF       R1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt2
;p4b.c,10 :: 		index=i%8;
	MOVLW       7
	ANDWF       R1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       interrupt_index_L0+0 
;p4b.c,11 :: 		PORTC=bobinas[index];
	MOVLW       interrupt_bobinas_L0+0
	MOVWF       FSR0 
	MOVLW       hi_addr(interrupt_bobinas_L0+0)
	MOVWF       FSR0H 
	MOVF        R0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       PORTC+0 
;p4b.c,12 :: 		delay_ms(200);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_interrupt4:
	DECFSZ      R13, 1, 1
	BRA         L_interrupt4
	DECFSZ      R12, 1, 1
	BRA         L_interrupt4
	DECFSZ      R11, 1, 1
	BRA         L_interrupt4
;p4b.c,13 :: 		PORTC=0;
	CLRF        PORTC+0 
;p4b.c,9 :: 		for(i=4;i<9;i+=2){
	MOVLW       2
	ADDWF       R1, 1 
;p4b.c,14 :: 		}
	GOTO        L_interrupt1
L_interrupt2:
;p4b.c,15 :: 		index++;
	INCF        interrupt_index_L0+0, 1 
;p4b.c,16 :: 		PORTC=bobinas[index];
	MOVLW       interrupt_bobinas_L0+0
	MOVWF       FSR0 
	MOVLW       hi_addr(interrupt_bobinas_L0+0)
	MOVWF       FSR0H 
	MOVF        interrupt_index_L0+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       PORTC+0 
;p4b.c,17 :: 		delay_ms(200);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_interrupt5:
	DECFSZ      R13, 1, 1
	BRA         L_interrupt5
	DECFSZ      R12, 1, 1
	BRA         L_interrupt5
	DECFSZ      R11, 1, 1
	BRA         L_interrupt5
;p4b.c,18 :: 		PORTC=0;
	CLRF        PORTC+0 
;p4b.c,19 :: 		giro135Hecho=1;
	MOVLW       1
	MOVWF       _giro135Hecho+0 
;p4b.c,20 :: 		}else{
	GOTO        L_interrupt6
L_interrupt0:
;p4b.c,23 :: 		for(i=16;i>0;i-=2){
	MOVLW       16
	MOVWF       R1 
L_interrupt7:
	MOVF        R1, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt8
;p4b.c,24 :: 		index=i%8;
	MOVLW       7
	ANDWF       R1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       interrupt_index_L0+0 
;p4b.c,25 :: 		PORTC=bobinas[index];
	MOVLW       interrupt_bobinas_L0+0
	MOVWF       FSR0 
	MOVLW       hi_addr(interrupt_bobinas_L0+0)
	MOVWF       FSR0H 
	MOVF        R0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       PORTC+0 
;p4b.c,26 :: 		delay_ms(200);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_interrupt10:
	DECFSZ      R13, 1, 1
	BRA         L_interrupt10
	DECFSZ      R12, 1, 1
	BRA         L_interrupt10
	DECFSZ      R11, 1, 1
	BRA         L_interrupt10
;p4b.c,27 :: 		PORTC=0;
	CLRF        PORTC+0 
;p4b.c,23 :: 		for(i=16;i>0;i-=2){
	MOVLW       2
	SUBWF       R1, 1 
;p4b.c,28 :: 		}
	GOTO        L_interrupt7
L_interrupt8:
;p4b.c,29 :: 		index--;
	DECF        interrupt_index_L0+0, 1 
;p4b.c,30 :: 		PORTC=bobinas[index];   //Excitamos ab
	MOVLW       interrupt_bobinas_L0+0
	MOVWF       FSR0 
	MOVLW       hi_addr(interrupt_bobinas_L0+0)
	MOVWF       FSR0H 
	MOVF        interrupt_index_L0+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       PORTC+0 
;p4b.c,31 :: 		delay_ms(200);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_interrupt11:
	DECFSZ      R13, 1, 1
	BRA         L_interrupt11
	DECFSZ      R12, 1, 1
	BRA         L_interrupt11
	DECFSZ      R11, 1, 1
	BRA         L_interrupt11
;p4b.c,32 :: 		PORTC=0;
	CLRF        PORTC+0 
;p4b.c,33 :: 		}
L_interrupt6:
;p4b.c,34 :: 		INTCON.INT0IF=0;   //deshabilitar flag de interrupcion
	BCF         INTCON+0, 1 
;p4b.c,35 :: 		}
L_end_interrupt:
L__interrupt18:
	RETFIE      1
; end of _interrupt

_main:

;p4b.c,37 :: 		void main() {
;p4b.c,39 :: 		TRISB.B0=1;
	BSF         TRISB+0, 0 
;p4b.c,40 :: 		TRISC=0;
	CLRF        TRISC+0 
;p4b.c,41 :: 		PORTC=0;
	CLRF        PORTC+0 
;p4b.c,43 :: 		INTCON2.RBPU=0;   //Activamos resistencia pull-up de RB0
	BCF         INTCON2+0, 7 
;p4b.c,44 :: 		INTCON2.INTEDG0=0;        //Interrupcion por flanco de bajada
	BCF         INTCON2+0, 6 
;p4b.c,45 :: 		INTCON.INT0IF=0;          //Flag de interrupcion a 0
	BCF         INTCON+0, 1 
;p4b.c,46 :: 		INTCON.INT0IE=1;          //Habilitamos interrupciones en el puerto INT0  (o RB0)
	BSF         INTCON+0, 4 
;p4b.c,47 :: 		INTCON.GIE=1;             //Habilitamos interrupciones de forma global
	BSF         INTCON+0, 7 
;p4b.c,50 :: 		PORTC.B0=1;
	BSF         PORTC+0, 0 
;p4b.c,51 :: 		delay_ms(200);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_main12:
	DECFSZ      R13, 1, 1
	BRA         L_main12
	DECFSZ      R12, 1, 1
	BRA         L_main12
	DECFSZ      R11, 1, 1
	BRA         L_main12
;p4b.c,52 :: 		PORTC.B0=0;
	BCF         PORTC+0, 0 
;p4b.c,55 :: 		PORTC.B1=1;
	BSF         PORTC+0, 1 
;p4b.c,56 :: 		delay_ms(200);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_main13:
	DECFSZ      R13, 1, 1
	BRA         L_main13
	DECFSZ      R12, 1, 1
	BRA         L_main13
	DECFSZ      R11, 1, 1
	BRA         L_main13
;p4b.c,58 :: 		PORTC.B2=1; //Para alcanzar -90º debemos excitar b y c a la vez
	BSF         PORTC+0, 2 
;p4b.c,59 :: 		delay_ms(200);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_main14:
	DECFSZ      R13, 1, 1
	BRA         L_main14
	DECFSZ      R12, 1, 1
	BRA         L_main14
	DECFSZ      R11, 1, 1
	BRA         L_main14
;p4b.c,61 :: 		PORTC.B1=0;
	BCF         PORTC+0, 1 
;p4b.c,62 :: 		PORTC.B2=0;
	BCF         PORTC+0, 2 
;p4b.c,64 :: 		while(1){
L_main15:
;p4b.c,66 :: 		}
	GOTO        L_main15
;p4b.c,67 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
