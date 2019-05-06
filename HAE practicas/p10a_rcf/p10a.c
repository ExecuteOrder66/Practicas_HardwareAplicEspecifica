void main() {
 char alto,bajo;
 TRISC=0;
 PORTC.B0=1;      //PORTC.B0 conectado al terminal CS del convertidor D/A
 alto= 0x3F;
 bajo= 0xFF;

 SPI1_Init();     //Iniciamos convertidor D/A
 PORTC.B0=0;     //CS a 0 para establecer comunicacion
 SPI1_WRITE(alto);        //Primero el byte alto (Big Endian)
 SPI1_WRITE(bajo);        //y luego el byte bajo
 PORTC.B0=1;     //Fin comunicacion, CS a 1
 while(1);
}