unsigned int valor;

void convertir(){
  PORTC.B0=0;     //CS a 0 para establecer comunicacion
  SPI1_WRITE(valor>>8);        //Primero el byte alto (Big Endian), se desplaza 8pos a la der. para obtener el byte alto
  SPI1_WRITE(valor);        //y luego el byte bajo
  PORTC.B0=1;     //Fin comunicacion, CS a 1
}

void main() {
 TRISC=0;
 PORTC.B0=1;      //PORTC.B0 conectado al terminal CS del convertidor D/A, Cs a 1, sin comunicacion
 SPI1_Init();     //Iniciamos convertidor D/A
 
  while(1){
     for(valor=0x3000; valor<0x3FFF; valor++){       //Tendiendo al valor alto
        convertir();
          delay_us(10);
     }
     for(valor=0x3FFF; valor>0x3000; valor--){       //Tendiendo al valor bajo
        convertir();
          delay_us(10);
     }

  }
}