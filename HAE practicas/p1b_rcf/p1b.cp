#line 1 "D:/Escritorio/Prácticas HAE 18-19/HAE_3 viernes 10-30 a 12-30/p1b_rcf/p1b.c"
void main() {

 ADCON1 = 0x07;
 TRISC.B0=0x00;
 PORTC.B0=0;
 while(1){

 PORTC.B0=1;
 delay_ms(200);
 PORTC.B0=0;
 delay_ms(100);

 }

}
