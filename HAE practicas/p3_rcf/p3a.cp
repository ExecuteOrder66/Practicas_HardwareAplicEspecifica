#line 1 "D:/Escritorio/Prácticas HAE 18-19/HAE_3 viernes 10-30 a 12-30/p3_rcf/p3a.c"
void main() {
 char val,val_ant=1;

 ADCON1=0x07;
 RBPU_bit=0;
 TRISB.B1=0;


 while(1){


 if(PORTB.B0==0 & val==1)
 PORTB.B1=!PORTB.B1;



 val=PORTB.B0;
 delay_ms(100);
 }
}
