#line 1 "D:/Escritorio/Prácticas HAE 18-19/HAE_3 viernes 10-30 a 12-30/p2_rcf/p2.c"
void main() {
 char d,u,i=0;
 char numeros[]={0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x67};
 ADCON1=0x07;

 TRISA.B0=0;
 TRISA.B1=0;
 TRISD=0;

 while(1){
 for(d=0;d<6;d++){
 for(u=0;u<10;u++){
 for(i=0;i<25;i++){
 PORTD=numeros[u];
 PORTA.B0=1;
 delay_ms(20);
 PORTA.B0=0;

 PORTD=numeros[d];
 PORTA.B1=1;
 delay_ms(20);
 PORTA.B1=0;
 }

 }

 }

 }
}
