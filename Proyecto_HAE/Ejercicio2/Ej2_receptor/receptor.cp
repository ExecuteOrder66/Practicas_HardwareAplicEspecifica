#line 1 "C:/Users/El Cido/Desktop/Practicas_HardwareAplicEspecifica/Proyecto_HAE/Ejercicio2/Ej2_receptor/receptor.c"
char txt[14];
unsigned out;
int cont = 0;
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

void main() {

}
