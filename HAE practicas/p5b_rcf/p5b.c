#include "Tecla12INT.h"
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
     if(contador%2==1){       //Si el modulo da 1, indica que se ha pulsado el boton, salta la interrupcion al pulsar y al soltar el boton

        ByteToStr(uni,txt);
        Lcd_out(1,7,txt);
        uni++;
        if(uni==99)
                    uni=0;


     }
     contador++;   //Se incrementa el contador
     x=PORTB;
     INTCON.RBIF=0;
}

void main() {
    TRISB=0x10; //Bit 4 puerto B como entrada
    PORTB=0;

    INTCON2.RBPU=0; //se habilitan las resistencias de pullup del puerto B
    x=PORTB; //para poder borrar el RBIF
    INTCON.RBIF=0;  //Creamos una falsa interrupcion
    INTCON.RBIE=1;
    INTCON.GIE = 1;

    Lcd_Init();
    x=PORTB; //para poder borrar el RBIF
    INTCON.RBIF=1;
    while(1){
    
    }
}