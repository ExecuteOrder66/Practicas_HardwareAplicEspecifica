#line 1 "D:/Escritorio/Prácticas HAE 18-19/HAE_3 viernes 10-30 a 12-30/p8a_rcf/p8a.c"

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
char escala=0;
char unidad[7];

void representar(){
 char i;
 v= x*0.0048828125*22.2;
 v= v+10.5;
 for(i=0;i<7;i++) unidad[i]=0;
 switch(escala){
 case 1: v= v / 6.8927;
 unidad[0]='P'; unidad[1]='s'; unidad[2]='i';
 break;
 case 2: v= v / 101.325;
 unidad[0]='A'; unidad[1]='t'; unidad[2]='m';
 break;
 case 3: v=v / 0.1;
 unidad[0]='m'; unidad[1]='B'; unidad[2]='a'; unidad[3]='r';
 break;
 case 4: v=v / 0.13328;
 unidad[0]='m'; unidad[1]='m'; unidad[2]='H'; unidad[3]='g';
 break;
 case 5: v=v / 0.001;
 unidad[0]='N'; unidad[1]='/'; unidad[2]='m'; unidad[3]='2';
 break;
 case 6: v=v / 98.039;
 unidad[0]='K'; unidad[1]='g'; unidad[2]='/'; unidad[3]='c';
 unidad[4]='m'; unidad[5]='2';
 break;
 case 7: v= v / 9.81;
 unidad[0]='k'; unidad[1]='p'; unidad[2]='/'; unidad[3]='c';
 unidad[4]='m'; unidad[5]='2';
 break;
 default: unidad[0]='k';
 unidad[1]='P'; unidad[2]='a';
 break;
 }
 Lcd_Cmd(_LCD_CLEAR);
 FloatToStr(v,txt);
 Lcd_out(1,1,txt);
 Lcd_Chr_cp(' ');
 Lcd_Out_CP(unidad);

}

void interrupt(){

 if(PIR1.ADIF){
 x=0;
 x=((ADRESH<<8) + ADRESL);




 representar();
 }


 if(INTCON.TMR0IF){
 PORTC.B0= !PORTC.B0;
 TMR0H= (3036>>8);
 TMR0L= 3036;
 ADCON0.GO=1;

 }

 if(INTCON3.INT2IF){
 escala++;
 escala= escala%8;
 representar();
 }

 PIR1.ADIF=0;
 INTCON.TMR0IF=0;
 INTCON3.INT2IF=0;
}

void main() {
 TRISC.B0=0;
 PORTC.B0=0;
 TRISE.B0=1;
 TRISB.B2=1;

 ADCON0=0x69;

 ADCON1=0xC0;

 Lcd_Init ();

 INTCON2=0;

 INTCON3.INT2IF=0;
 INTCON3.INT2IE=1;

 INTCON.TMR0IF=0;
 INTCON.TMR0IE=1;


 PIR1.ADIF=0;
 PIE1.ADIE=1;
 INTCON.PEIE=1;
 INTCON.GIE=1;

 T0CON=0x84;
 TMR0H= (3036>>8);
 TMR0L= 3036;
 ADCON0.GO=1;

 while(1);
}
