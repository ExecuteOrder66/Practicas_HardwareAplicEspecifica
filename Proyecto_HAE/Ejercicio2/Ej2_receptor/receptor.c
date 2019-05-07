//RECEPTOR
char txt[14];
unsigned out;
int contador = 0;
float temperatura;
char *puntero;

// Lcd pinout settings
sbit LCD_RS at RB2_bit;
sbit LCD_EN at RB3_bit;
sbit LCD_D7 at RB7_bit;
sbit LCD_D6 at RB6_bit;
sbit LCD_D5 at RB5_bit;
sbit LCD_D4 at RB4_bit;
// Pin direction
sbit LCD_RS_Direction at TRISB2_bit;
sbit LCD_EN_Direction at TRISB3_bit;
sbit LCD_D7_Direction at TRISB7_bit;
sbit LCD_D6_Direction at TRISB6_bit;
sbit LCD_D5_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB4_bit;

void interrupt(){

        if(PIR1.RCIF){
              *(puntero+contador)=UART1_READ();   //Leemos el byte recibido (seran 4)
              contador++;
              //Si el contador llega a 4 quiere decir que se han recibido los 4 bytes de datos
              if(contador==4){
                      Lcd_Cmd(_LCD_CLEAR);
                      FloatToStr(temperatura,txt);
                      lcd_out(1,1,txt);
                      Lcd_Chr_cp(223);
                      Lcd_Chr_cp('C');
                      contador=0;       //reiniciamos valor contador a 0
               }
               PIR1.RCIF=0;
         }

}

void main() {
    ADCON1 = 0x0f;
     puntero = &temperatura;

     //Para interrupcion de recepcion de mensajes
     PIR1.RCIF = 0;        //deshabilitamos flag interrupcion
     PIE1.RCIE = 1;        //habilitamos interrupcion recepcion mensaje
     
     INTCON.PEIE = 1;
     INTCON.GIE = 1;
     Lcd_Init();
     UART1_Init(9600);
     delay_ms(300);
     while(1){
          asm nop;
     }
}