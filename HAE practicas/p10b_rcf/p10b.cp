#line 1 "D:/Escritorio/Prácticas HAE 18-19/HAE_3 viernes 10-30 a 12-30/p10b_rcf/p10b.c"
unsigned int valor;

void convertir(){
 PORTC.B0=0;
 SPI1_WRITE(valor>>8);
 SPI1_WRITE(valor);
 PORTC.B0=1;
}

void main() {
 TRISC=0;
 PORTC.B0=1;
 SPI1_Init();

 while(1){
 for(valor=0x3000; valor<0x3FFF; valor++){
 convertir();
 delay_us(10);
 }
 for(valor=0x3FFF; valor>0x3000; valor--){
 convertir();
 delay_us(10);
 }

 }
}
