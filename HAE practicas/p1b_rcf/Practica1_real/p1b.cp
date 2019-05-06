#line 1 "D:/Escritorio/Prácticas HAE 18-19/HAE_3 viernes 10-30 a 12-30/p1b_rcf/Nueva carpeta/p1b.c"
void main() {
 char i;
 char array[]={0x01,0x02,0x04,0x08,0x10,0x20,0x40,0x80};
 ADCON1 = 0x07;
 TRISC = 0x00;
 PORTC = 0;
 while(1){
 for(i=0;i<8;i++){
 PORTC=array[i];
 delay_ms(200);
 PORTC=array[i];
 delay_ms(100);
 }
 }

}
