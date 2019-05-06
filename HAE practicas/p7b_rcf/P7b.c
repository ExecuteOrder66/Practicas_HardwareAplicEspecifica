
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
unsigned int x;
char txt[14];    //FIJARSE TAMAÑO CADENA PARA FLOAT->MINIMO 14
float v;
void interrupt(){
     //Si se activa la interrupcion del convertidor
     if(PIR1.ADIF){

       x=0;
       x=((ADRESH<<8) + ADRESL);      //Cargamos el valor muestreado de la tensión de entrada
       v= x*0.48828125;             //Este valor numero es la resolucion del convertidor A/D---->   resolucion= (Vref+ - Vref-)/2^n  (en este caso n=10)
       //Vi= resolucion*D + Vref-   (como en este caso Vref- es 0, no la sumamos)
       //MULTIPLICAMOS X 100 para tener la temperatura
       //MARCAR LCD Y CONVERSIONS en las librerias del proyecto(View/Library manager/System Libraries)
       Lcd_Cmd(_LCD_CLEAR);     //Borramos pantalla lcd
       FloatToStr(v,txt);
       Lcd_out(1,1,txt);        //Mostramos resultado por pantalla
       PORTC.B1=!PORTC.B1;
     }
        
        //Si se activa la interrupcion del timer (1'5s)
       if(INTCON.TMR0IF){
          PORTC.B0=!PORTC.B0;
          TMR0H= (18661>>8);      //Reseteamos el valor de alfa para hacer otra temporizacion de 1.5s
          TMR0L= 18661;
          ADCON0.GO=1;  //Comienza el muestreo de la señal analogica otra vez
          
       }


     PIR1.ADIF=0;     //Deshabilitamos interrupcion
     INTCON.TMR0IF=0;
}


void main() {
     TRISE.B1=1;  //Declarar RE1/AN6 como entrada
     TRISC=0;
     PORTC=0;
     ADCON0=0x71;      //Escogemos una combinacion en la que AN6 sea analogica y las tensiones de referencia vengan del micro (vdd y vss)
                       //ATENCION AL CANAL ESCOGIDO, DEBE SER EL DE AN6
     ADCON1=0xC0;     //prescaler 16 (el mas pequeño) Y AN6 analogica

      Lcd_Init (); //Iniciamos el circuito de la pantalla LCD


      INTCON.TMR0IF=0;
      INTCON.TMR0IE=1;
      

      PIR1.ADIF=0;
      PIE1.ADIE=1;
      INTCON.PEIE=1;
      INTCON.GIE=1;

      T0CON=0x85;
      TMR0H= (18661>>8);
      TMR0L= 18661;
      ADCON0.GO=1; //Comienza el muestreo de la señal analogica

      while(1);
}