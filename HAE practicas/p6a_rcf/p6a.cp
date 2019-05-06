#line 1 "D:/Escritorio/Prácticas HAE 18-19/HAE_3 viernes 10-30 a 12-30/p6a_rcf/p6a.c"
void interrupt(){
 INTCON.TMR0IF=0;

 PORTC.B0=!PORTC.B0;
 if(PORTC.B0==0){

 TMR0L=81;
 T0CON=0xC2;

 }else{

 TMR0L=106;
 T0CON=0xC1;

 }

}
void main() {

 TRISC=0;
 PORTC=0;

 T0CON=0x41;

 INTCON.TMR0IF=0;
 INTCON.TMR0IE=1;
 INTCON.GIE=1;

 TMR0L=106;

 T0CON=0xC1;
 while(1);
}
