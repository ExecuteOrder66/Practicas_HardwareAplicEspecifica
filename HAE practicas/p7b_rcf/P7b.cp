#line 1 "D:/Escritorio/Pr�cticas HAE 18-19/HAE_3 viernes 10-30 a 12-30/p7b_rcf/P7b.c"


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
unsigned int x;
char txt[14];
float v;
void interrupt(){

 if(PIR1.ADIF){

 x=0;
 x=((ADRESH<<8) + ADRESL);
 v= x*0.48828125;



 Lcd_Cmd(_LCD_CLEAR);
 FloatToStr(v,txt);
 Lcd_out(1,1,txt);
 PORTC.B1=!PORTC.B1;
 }


 if(INTCON.TMR0IF){
 PORTC.B0=!PORTC.B0;
 TMR0H= (18661>>8);
 TMR0L= 18661;
 ADCON0.GO=1;

 }


 PIR1.ADIF=0;
 INTCON.TMR0IF=0;
}


void main() {
 TRISE.B1=1;
 TRISC=0;
 PORTC=0;
 ADCON0=0x71;
 ADCON1=0xC0;

 Lcd_Init ();


 INTCON.TMR0IF=0;
 INTCON.TMR0IE=1;


 PIR1.ADIF=0;
 PIE1.ADIE=1;
 INTCON.PEIE=1;
 INTCON.GIE=1;

 T0CON=0x85;
 TMR0H= (18661>>8);
 TMR0L= 18661;
 ADCON0.GO=1;

 while(1);
}
