
char giro135Hecho=0;

void interrupt(){
     char bobinas []={0x01,0x03,0x02,0x06,0x04,0x0C,0x08,0x09};       //a-ab-b-bc-c-cd-d-da
     char i,index=0;
      if(giro135Hecho==0){
              //Para girar 135º a la izq debemos hacer c-d-a-ab
              for(i=4;i<9;i+=2){
                    index=i%8;
                    PORTC=bobinas[index];
                    delay_ms(200);
                    PORTC=0;
              }
              index++;
              PORTC=bobinas[index];
              delay_ms(200);
              PORTC=0;
              giro135Hecho=1;
       }else{
             //Si ya se hizo el giro de 135º, ahora pulsar el boton hace girar 360º hacia la dcha
             //La secuencia seria a-d-c-b-a-d-c-b-ab
              for(i=16;i>0;i-=2){
                    index=i%8;
                    PORTC=bobinas[index];
                    delay_ms(200);
                    PORTC=0;
              }
              index--;
              PORTC=bobinas[index];   //Excitamos ab
              delay_ms(200);
              PORTC=0;
       }
       INTCON.INT0IF=0;   //deshabilitar flag de interrupcion
}

void main() {

      TRISB.B0=1;
      TRISC=0;
      PORTC=0;
        //habilitar interrupciones
      INTCON2.RBPU=0;   //Activamos resistencia pull-up de RB0
      INTCON2.INTEDG0=0;        //Interrupcion por flanco de bajada
      INTCON.INT0IF=0;          //Flag de interrupcion a 0
      INTCON.INT0IE=1;          //Habilitamos interrupciones en el puerto INT0  (o RB0)
      INTCON.GIE=1;             //Habilitamos interrupciones de forma global

      //Giramos a -22.5º
      PORTC.B0=1;
      delay_ms(200);
      PORTC.B0=0;
      
      //Giramos a -67.5º
      PORTC.B1=1;
      delay_ms(200);
      //Giramos a -90º
      PORTC.B2=1; //Para alcanzar -90º debemos excitar b y c a la vez
      delay_ms(200);
      //Dejamos el rotor en -90º
      PORTC.B1=0;
      PORTC.B2=0;

      while(1);
}