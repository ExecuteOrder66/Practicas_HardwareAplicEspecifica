#line 1 "D:/Escritorio/Prácticas HAE 18-19/HAE_3 viernes 10-30 a 12-30/p3b_rcf/p3b.c"
void main() {


 ADCON1 = 0x07;
 RBPU_bit=0;
 TRISB.B0=1;
 INTCON.PEIE=0;
 RCON.IPEN=0;
 INTCON2.INTEDG0=0;
 INTCON.INT0IF=0;
 INTCON.INT0IE=1;
 INTCON.GIE=1;

 while(1){
 1+1;
 }
}

void interrupt(){

 PORTB.B1=!PORTB.B1;

 INTCON.INT0IF=0;
}
