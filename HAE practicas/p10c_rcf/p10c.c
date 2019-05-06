unsigned int valor;

void convertir(){
  PORTC.B0=0;     //CS a 0 para establecer comunicacion
  SPI1_WRITE(valor>>8);        //Primero el byte alto (Big Endian), se desplaza 8pos a la der. para obtener el byte alto
  SPI1_WRITE(valor);        //y luego el byte bajo
  delay_us(10);
  PORTC.B0=1;     //Fin comunicacion, CS a 1
}

void interrupt(){
     if(INTCON.INT0IF){
        valor+=0x10;      //Reducimos frecuencia-> aumentamos periodo
     }
     if(INTCON3.INT1IF){
        valor -=0x10;     //Aumentamos frecuencia-> reducimos periodo
     }

     INTCON.INT0IF=0;
     INTCON3.INT1IF=0;
}

void main() {
ADCON1=0x87;
 TRISC=0;
 TRISB.B0=1;
 TRISB.B1=1;
 PORTC.B0=1;      //PORTC.B0 conectado al terminal CS del convertidor D/A, Cs a 1, sin comunicacion
  valor=0x3FFF;
 INTCON2=0;

  INTCON.INT0IF=0;   //Interruptor 2
  INTCON.INT0IE=1;
  
  INTCON3.INT1IF=0;  //Interruptor 1
  INTCON3.INT1IE=1;

  INTCON.GIE=1;
   SPI1_Init();     //Iniciamos convertidor D/A
  while(1){
      convertir();
  }
}