#line 1 "D:/Escritorio/Prácticas HAE 18-19/HAE_3 viernes 10-30 a 12-30/p1b_rcf/Nueva carpeta/p1c.c"
void main() {
 char i;
 char array[]={0x81,0x42,0x24,0x18,0x18,0x24,0x42,0x81};
 ADCON1 = 0x07;
 TRISC = 0x00;

 while(1){
 for(i=0;i<8;i++){
 PORTC=array[i];
 delay_ms(200);
 PORTC=array[i];
 delay_ms(100);
 }
 }
}
