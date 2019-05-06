unsigned int x=0;
float v;
char txt[6];
// Lcd pinout settings 
sbit LCD_RS at RD2_bit;
sbit LCD_EN at RD3_bit;
sbit LCD_D7 at RD7_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D4 at RD4_bit;
// Pin direction
sbit LCD_RS_Direction at TRISD2_bit;
sbit LCD_EN_Direction at TRISD3_bit;
sbit LCD_D7_Direction at TRISD7_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D4_Direction at TRISD4_bit;

void interrupt(){
     PIR1.ADIF=0;     //Deshabilitamos interrupcion
     
     x=0;
     x=(ADRESH<<8) + (ADRESL);      //Cargamos el valor muestreado de la tensión de entrada
     v= x*0.0048828125;             //Este valor numero es la resolucion del convertidor A/D---->   resolucion= (Vref+ - Vref-)/2^n  (en este caso n=10)
     //Vi= resolucion*D + Vref-   (como en este caso Vref- es 0, no la sumamos)
     //MARCAR LCD Y CONVERSIONS en las librerias del proyecto(View/Library manager/System Libraries)
     Lcd_Cmd(_LCD_CLEAR);     //Borramos pantalla lcd
     FloatToStr(v,txt);
     Lcd_out(1,1,txt);        //Mostramos resultado por pantalla
     delay_ms(1000);    //Frecuencia de muestro de 1Hz
     ADCON0.GO=1;  //Comienza el muestreo de la señal analogica otra vez
     
//
}

void main() {
     TRISA.B0=1;  //Declarar An0 como entrada
     ADCON0=0x41;      //Escogemos una combinacion en la que AN0 sea analogica y las tensiones de referencia vengan del micro (vdd y vss)
     ADCON1=0xCE;     //prescaler 16 (el mas pequeño)
      
      Lcd_Init (); //Iniciamos el circuito de la pantalla LCD
      
      PIR1.ADIF=0;
      PIE1.ADIE=1;
      INTCON.PEIE=1;
      INTCON.GIE=1;

      ADCON0.GO=1; //Comienza el muestreo de la señal analogica
      while(1);
}