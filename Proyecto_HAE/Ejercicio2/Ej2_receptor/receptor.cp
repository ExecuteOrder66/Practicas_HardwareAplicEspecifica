#line 1 "C:/Users/El Cido/Desktop/Practicas_HardwareAplicEspecifica/Proyecto_HAE/Ejercicio2/Ej2_receptor/receptor.c"

char txt[14];
unsigned out;
int contador = 0;
float temperatura;
char *puntero;


sbit LCD_RS at RB2_bit;
sbit LCD_EN at RB3_bit;
sbit LCD_D7 at RB7_bit;
sbit LCD_D6 at RB6_bit;
sbit LCD_D5 at RB5_bit;
sbit LCD_D4 at RB4_bit;

sbit LCD_RS_Direction at TRISB2_bit;
sbit LCD_EN_Direction at TRISB3_bit;
sbit LCD_D7_Direction at TRISB7_bit;
sbit LCD_D6_Direction at TRISB6_bit;
sbit LCD_D5_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB4_bit;

void interrupt(){

 if(PIR1.RCIF){
 *(puntero+contador)=UART1_READ();
 contador++;

 if(contador==4){
 Lcd_Cmd(_LCD_CLEAR);
 FloatToStr(temperatura,txt);
 lcd_out(1,1,txt);
 Lcd_Chr_cp(223);
 Lcd_Chr_cp('C');
 contador=0;
 }
 PIR1.RCIF=0;
 }

}

void main() {
 ADCON1 = 0x0f;
 puntero = &temperatura;


 PIR1.RCIF = 0;
 PIE1.RCIE = 1;

 INTCON.PEIE = 1;
 INTCON.GIE = 1;
 Lcd_Init();
 UART1_Init(9600);
 delay_ms(300);
 while(1){
 asm nop;
 }
}
