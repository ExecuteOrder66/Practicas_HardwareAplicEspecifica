#line 1 "D:/Escritorio/Prácticas HAE 18-19/HAE_3 viernes 10-30 a 12-30/p10a_rcf/p10a.c"
void main() {
 char alto,bajo;
 TRISC=0;
 PORTC.B0=1;
 alto= 0x3F;
 bajo= 0xFF;

 SPI1_Init();
 PORTC.B0=0;
 SPI1_WRITE(alto);
 SPI1_WRITE(bajo);
 PORTC.B0=1;
 while(1);
}
