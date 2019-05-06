#line 1 "D:/Escritorio/Prácticas HAE 18-19/HAE_3 viernes 10-30 a 12-30/p6c_rcf/p6c.c"
 char contando=0;
 char temp=0;
void interrupt(){



 if(INTCON3.INT1IF && INTCON3.INT1IE){
 if(contando==0){



 PORTC.B0=1;
 T0CON=0x87;
 TMR0H=(18661>>8);
 TMR0L= 18661;
 INTCON.TMR0IF=0;
 INTCON.TMR0IE=1;
 contando=1;
 INTCON3.INT1IE=0;
 }
 INTCON3.INT1IF=0;
 }
 if(INTCON.TMR0IF){
 INTCON.TMR0IF=0;
 if(temp<0){
 temp++;
 TMR0H=(18661>>8);
 TMR0L= 18661;

 }else{
 temp=0;
 contando=0;
 PORTC.B0=0;
 T0CON=0x07;
 INTCON3.INT1IE=1;
 }
 }
}

void main() {

 TRISB.B1=1;
 TRISC.B0=0;



 INTCON3.INT1IF=0;

 INTCON2.INTEDG1=0;


 INTCON3.INT1IE=1;

 INTCON.GIE=1;

 while(1);
}
