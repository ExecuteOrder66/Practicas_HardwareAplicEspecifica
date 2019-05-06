#line 1 "C:/Users/El Cido/Desktop/Proyecto_HAE/codigo/Ej_UNO_Proyecto.c"
unsigned char estado = 0;
unsigned char cerrada = 0;
unsigned char abierta = 0;
unsigned char presencia = 0;
char temporizador=0;

void abrir(){
PORTC.B0=0;
PORTC.B1=1;
}

void cerrar(){
PORTC.B1=0;
PORTC.B0=1;
}

void parar(){
PORTC.B0=0;
PORTC.B1=0;
}

void interrupt(){

 if(PIR1.TMR1IF){
 TMR1H=(15536>>8);
 TMR1L=15536;
 PIR1.TMR1IF=0;
 cerrada = PORTB.B0;
 abierta = PORTB.B1;
 presencia = PORTB.B2;

 if(estado==0){

 if(presencia==1){
 abrir();
 estado=1;
 }

 }

 if(estado==1){

 if(abierta==1){
 parar();
 estado=2;
 }
#line 53 "C:/Users/El Cido/Desktop/Proyecto_HAE/codigo/Ej_UNO_Proyecto.c"
 }

 if(estado==2){

 if(temporizador==0){
 T0CON.TMR0ON=1;
 temporizador++;
 }
 if(INTCON.TMR0IF){
 T0CON.TMR0ON=0;
 }
 if (presencia==0){
 cerrar();
 estado=3;
 }

 }

 if(estado==3){

 if(cerrada==1){
 parar();
 estado=0;
 }
#line 83 "C:/Users/El Cido/Desktop/Proyecto_HAE/codigo/Ej_UNO_Proyecto.c"
 }

 }

 INTCON.TMR0IF=0;
}

void main() {

TRISC.B0=0;
TRISC.B1=0;
TRISB.B0=1;
TRISB.B1=1;
TRISB.B2=1;
PORTC.B0=0;
PORTC.B1=0;

INTCON.TMR0IF=0;
INTCON.TMR0IE=1;
T0CON=0x07;
TMR0H=(26474>>8);
TMR0L=26474;

T1CON=0xA5;
TMR1H=(15536>>8);
TMR1L=15536;
PIR1.TMR1IF=0;
PIE1.TMR1IE=1;
INTCON.PEIE=1;
INTCON.GIE=1;


while(1)
asm nop;

}
