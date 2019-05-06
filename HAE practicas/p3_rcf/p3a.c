void main() {
     char val,val_ant=1;
     
      ADCON1=0x07;
      RBPU_bit=0;
      TRISB.B1=0;
      

      while(1){


          if(PORTB.B0==0 & val==1)     //Si el valor anterior era 1 y el valor presente es 0, significa que se ha pulsado el boton
              PORTB.B1=!PORTB.B1;              //Encendemos el led si estaba apagado y viceversa, hace una operación NOT


          val=PORTB.B0;    //Almacenamos el valor de RB0
          delay_ms(100);    //Esperamos 100ms para muestrear otra vez
      }
}