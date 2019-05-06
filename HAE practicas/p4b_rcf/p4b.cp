#line 1 "D:/Escritorio/Prácticas HAE 18-19/HAE_3 viernes 10-30 a 12-30/p4b_rcf/p4b.c"

char giro135Hecho=0;

void interrupt(){
 char bobinas []={0x01,0x03,0x02,0x06,0x04,0x0C,0x08,0x09};
 char i,index=0;
 if(giro135Hecho==0){

 for(i=4;i<9;i+=2){
 index=i%8;
 PORTC=bobinas[index];
 delay_ms(200);
 PORTC=0;
 }
 index++;
 PORTC=bobinas[index];
 delay_ms(200);
 PORTC=0;
 giro135Hecho=1;
 }else{


 for(i=16;i>0;i-=2){
 index=i%8;
 PORTC=bobinas[index];
 delay_ms(200);
 PORTC=0;
 }
 index--;
 PORTC=bobinas[index];
 delay_ms(200);
 PORTC=0;
 }
 INTCON.INT0IF=0;
}

void main() {

 TRISB.B0=1;
 TRISC=0;
 PORTC=0;

 INTCON2.RBPU=0;
 INTCON2.INTEDG0=0;
 INTCON.INT0IF=0;
 INTCON.INT0IE=1;
 INTCON.GIE=1;


 PORTC.B0=1;
 delay_ms(200);
 PORTC.B0=0;


 PORTC.B1=1;
 delay_ms(200);

 PORTC.B2=1;
 delay_ms(200);

 PORTC.B1=0;
 PORTC.B2=0;

 while(1){

 }
}
