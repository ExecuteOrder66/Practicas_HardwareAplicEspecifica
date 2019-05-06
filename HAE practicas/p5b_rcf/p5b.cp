#line 1 "D:/Escritorio/Pr�cticas HAE 18-19/HAE_3 viernes 10-30 a 12-30/p5b_rcf/p5b.c"
#line 1 "d:/escritorio/pr�cticas hae 18-19/hae_3 viernes 10-30 a 12-30/p5b_rcf/tecla12int.h"
#line 25 "d:/escritorio/pr�cticas hae 18-19/hae_3 viernes 10-30 a 12-30/p5b_rcf/tecla12int.h"
unsigned char tecla()
{

unsigned char columna=0, fila, aux1=0x10, aux2;

unsigned char teclado[4][3]={{49, 50, 51},{52, 53, 54},{55, 56, 57}, {42, 48, 35}};

delay_ms( 10 );

 for(fila=0; fila< 4 ; fila++)
 {
 if((PORTB&aux1)==0x00) break;
 aux1=(aux1<<1);
 }

 PORTB=0x01;

 while((PORTB& 0xF0 )!= 0xF0 )
 {
 PORTB=(PORTB<<1);
 columna++;
 }


 PORTB=0x00;

 do
 {delay_ms(2);
 }while((PORTB&0xF0)!=0xF0);



 aux2=teclado[fila][columna];
 return aux2;
}
#line 2 "D:/Escritorio/Pr�cticas HAE 18-19/HAE_3 viernes 10-30 a 12-30/p5b_rcf/p5b.c"
char x;
char uni=0,contador=0;
char txt[4];

sbit LCD_RS at RD2_bit;
sbit LCD_EN at RD3_bit;
sbit LCD_D7 at RD7_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D4 at RD4_bit;

sbit LCD_RS_Direction at TRISD2_bit;
sbit LCD_EN_Direction at TRISD3_bit;
sbit LCD_D7_Direction at TRISD7_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D4_Direction at TRISD4_bit;

void interrupt(){
 Lcd_Cmd(_LCD_CURSOR_OFF);
 if(contador==0){
 Lcd_out(1,1,"Turno:  0");
 uni++;
 }
 if(contador%2==1){

 ByteToStr(uni,txt);
 Lcd_out(1,7,txt);
 uni++;
 if(uni==99)
 uni=0;


 }
 contador++;
 x=PORTB;
 INTCON.RBIF=0;
}

void main() {
 TRISB=0x10;
 PORTB=0;

 INTCON2.RBPU=0;
 x=PORTB;
 INTCON.RBIF=0;
 INTCON.RBIE=1;
 INTCON.GIE = 1;

 Lcd_Init();

 INTCON.RBIF=1;
 while(1){

 }
}
