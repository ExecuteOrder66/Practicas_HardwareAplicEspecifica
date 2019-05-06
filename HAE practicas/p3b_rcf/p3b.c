void main() {

      
      ADCON1 = 0x07;
      INTCON2.RBPU=0;   //Activamos resistencia pull-up de RB0
      TRISB.B0=1;
	 TRISB.B1=0;
	 PORTB.B1=0;
      INTCON.PEIE=0;            //Interrupcion tipo core
      RCON.IPEN=0;              //No emplearemos prioridad en las interrupciones
      INTCON2.INTEDG0=0;        //Interrupcion por flanco de bajada
      INTCON.INT0IF=0;          //Flag de interrupcion a 0
      INTCON.INT0IE=1;          //Habilitamos interrupciones en el puerto INT0  (o RB0)
      INTCON.GIE=1;             //Habilitamos interrupciones de forma global
      
      while(1){
           1+1;
      }
}

void interrupt(){
     //Si se ha lanzado la interrupción es que se ha pulsado el boton
       PORTB.B1=!PORTB.B1;              //Encendemos el led si estaba apagado y viceversa, hace una operación NOT
       
       INTCON.INT0IF=0;                 //Deshabilitamos flag de interrupcion
}
