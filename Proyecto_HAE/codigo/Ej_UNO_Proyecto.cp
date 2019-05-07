#line 1 "C:/Users/El Cido/Desktop/Practicas_HardwareAplicEspecifica/Proyecto_HAE/codigo/Ej_UNO_Proyecto.c"
unsigned char estado = 0;
unsigned char cerrada = 0;
unsigned char abierta = 0;
unsigned char presencia = 0;
char temporizador = 0;

void abrir() {
 PORTC.B0 = 0;
 PORTC.B1 = 1;
}

void cerrar() {
 PORTC.B1 = 0;
 PORTC.B0 = 1;
}

void parar() {
 PORTC.B0 = 0;
 PORTC.B1 = 0;
}

void interrupt() {

 if (PIR1.TMR1IF) {
 TMR1H = (15536 >> 8);
 TMR1L = 15536;
 PIR1.TMR1IF = 0;
 cerrada = PORTB.B0;
 abierta = PORTB.B1;
 presencia = PORTB.B2;

 if (estado == 0) {
 if (presencia == 1) {
 estado = 1;
 abrir();
 }
 }

 if (estado == 1) {
 if (abierta == 1) {
 estado = 2;
 parar();
 }
 }

 if (estado == 2) {
 if (presencia == 0) {
 estado = 3;
 T0CON = 0x06;
 TMR0H = (3036 >> 8);
 TMR0L = 3036;
 T0CON.TMR0ON = 1;
 PORTD.B0 = !PORTD.B0;
 }
 }

 if (estado == 3) {
 if (INTCON.TMR0IF) {
 T0CON.TMR0ON = 0;
 INTCON.TMR0IF = 0;
 PORTD.B0 = !PORTD.B0;
 if (presencia == 1) {
 estado = 2;
 } else {
 estado = 4;
 cerrar();
 }
 }
 }

 if (estado == 4) {
 if (cerrada == 1) {
 parar();
 estado = 0;
 } else if (presencia == 1) {
 estado = 5;
 parar();
 T0CON = 0x05;
 TMR0H = (3036 >> 8);
 TMR0L = 3036;
 T0CON.TMR0ON = 1;
 PORTD.B0 = !PORTD.B0;
 }
 }

 if (estado == 5) {
 if (INTCON.TMR0IF) {
 T0CON.TMR0ON = 0;
 INTCON.TMR0IF = 0;
 PORTD.B0 = !PORTD.B0;
 if (presencia == 1) {
 estado = 1;
 abrir();
 } else {
 estado = 4;
 cerrar();
 }
 }
 }
 }
 INTCON.TMR0IF = 0;
}

void main() {

 TRISC.B0 = 0;
 TRISC.B1 = 0;
 TRISB.B0 = 1;
 TRISB.B1 = 1;
 TRISB.B2 = 1;
 TRISD.B0 = 0;
 PORTC.B0 = 0;
 PORTC.B1 = 0;
 PORTD.B0 = 0;

 INTCON.TMR0IF = 0;
 INTCON.TMR0IE = 0;

 T1CON = 0xA5;
 TMR1H = (15536 >> 8);
 TMR1L = 15536;
 PIR1.TMR1IF = 0;
 PIE1.TMR1IE = 1;
 INTCON.PEIE = 1;
 INTCON.GIE = 1;


 while (1)
 asm nop;

}
