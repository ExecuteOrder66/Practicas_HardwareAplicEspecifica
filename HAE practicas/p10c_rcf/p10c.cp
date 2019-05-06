#line 1 "D:/Escritorio/Prácticas HAE 18-19/HAE_3 viernes 10-30 a 12-30/p10c_rcf/p10c.c"
unsigned int valor;

void convertir(){
 PORTC.B0=0;
 SPI1_WRITE(valor>>8);
 SPI1_WRITE(valor);
 delay_us(10);
 PORTC.B0=1;
}

void interrupt(){
 if(INTCON.INT0IF){
 valor+=0x10;
 }
 if(INTCON3.INT1IF){
 valor -=0x10;
 }

 INTCON.INT0IF=0;
 INTCON3.INT1IF=0;
}

void main() {
ADCON1=0x87;
 TRISC=0;
 TRISB.B0=1;
 TRISB.B1=1;
 PORTC.B0=1;
 valor=0x3FFF;
 INTCON2=0;

 INTCON.INT0IF=0;
 INTCON.INT0IE=1;

 INTCON3.INT1IF=0;
 INTCON3.INT1IE=1;

 INTCON.GIE=1;
 SPI1_Init();
 while(1){
 convertir();
 }
}
