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

    if(estado==0){ // estado de puerta cerrada

      if(presencia==1){
      abrir();
      estado=1;
      }

    }

    if(estado==1){ // estado de puerta abriendose

      if(abierta==1){
      parar();
      estado=2;
      }

      /*else if(presencia==0){
      cerrar();
      estado=3;
      }*/

    }

    if(estado==2){ // estado de puerta abierta
      
      if(temporizador==0){
            T0CON.TMR0ON=1;  //encendemos temporizacion
            temporizador++;
      }
      if(INTCON.TMR0IF){      //Se acaba la temporizacion
            T0CON.TMR0ON=0;   //Apagamos contador
      }
      if (presencia==0){
      cerrar();
      estado=3;
      }

    }

    if(estado==3){ // estado de puerta cerrandose

      if(cerrada==1){
      parar();
      estado=0;
      }

      /*else if(presencia==1){
      abrir();
      estado=1;
      }*/

    }

  }

  INTCON.TMR0IF=0; //Deshabilitamos flag interrupcion
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
T0CON=0x07; //Prescaler 256, modo 16bits  Se activa al tener la puerta abierta (5s)
TMR0H=(26474>>8);    //Alfa para temporizacion 5s
TMR0L=26474;           //Alfa para temporizacion 5s

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