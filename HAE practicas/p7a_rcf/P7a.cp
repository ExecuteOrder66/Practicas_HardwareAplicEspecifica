#line 1 "D:/Escritorio/Prácticas HAE 18-19/HAE_3 viernes 10-30 a 12-30/p7a_rcf/P7a.c"
unsigned int x=0;
float v;
char txt[6];

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
 PIR1.ADIF=0;

 x=0;
 x=(ADRESH<<8) + (ADRESL);
 v= x*0.0048828125;


 Lcd_Cmd(_LCD_CLEAR);
 FloatToStr(v,txt);
 Lcd_out(1,1,txt);
 delay_ms(1000);
 ADCON0.GO=1;


}

void main() {
 TRISA.B0=1;
 ADCON0=0x41;
 ADCON1=0xCE;

 Lcd_Init ();

 PIR1.ADIF=0;
 PIE1.ADIE=1;
 INTCON.PEIE=1;
 INTCON.GIE=1;

 ADCON0.GO=1;
 while(1);
}
