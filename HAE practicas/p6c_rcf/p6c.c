     char contando=0;
     char temp=0;
void interrupt(){
     //Como el tiempo máximo que se puede temporizar es de 8'38s (con 16 bits), para un minuto haremos 10 temporizaciones de 6s
     //Cada overflow del temporizador lanzará una interrupción del mismo tipo
     //Problema: Cómo evitar que el botón lance una interrupción mientras se realiza la temporización?
     if(INTCON3.INT1IF && INTCON3.INT1IE){  //Si activamos el interruptor
          if(contando==0){  //Si no estamos contando

               

               PORTC.B0=1;  //Ponemos RC0 a nivel alto
               T0CON=0x87;
               TMR0H=(18661>>8);    //Introducimos el alfa inicial;
               TMR0L= 18661;
               INTCON.TMR0IF=0;
                       INTCON.TMR0IE=1;
               contando=1;
                       INTCON3.INT1IE=0;
          }
           INTCON3.INT1IF=0;
     }
     if(INTCON.TMR0IF){
                       INTCON.TMR0IF=0;
                       if(temp<0){          //con temp<1 hace 2 temporizaciones, luego para hacer 10 temporizaciones-> temp<9
                                  temp++;
                                  TMR0H=(18661>>8);    //Reseteamos el alfa inicial;
                                  TMR0L= 18661;
                                  
                       }else{            //ya dimos las 10 iteraciones de 6s
                             temp=0;
                             contando=0;
                             PORTC.B0=0; //RC0 a nivel bajo, temporizacion ya terminada
                             T0CON=0x07;
                             INTCON3.INT1IF=0;
                             INTCON3.INT1IE=1;
                       }
     }
}

void main() {
        //Una vez pulsado el boton, iniciará la temporización de 1min y el botón quedará inutil hasta que esta acabe
        TRISB.B1=1;     //RB1 INPUT
        TRISC.B0=0;     //RC0 OUTPUT

        

        INTCON3.INT1IF=0;
        
        INTCON2.INTEDG1=0;
        

        INTCON3.INT1IE=1;
        
        INTCON.GIE=1;
        
        while(1);
}
