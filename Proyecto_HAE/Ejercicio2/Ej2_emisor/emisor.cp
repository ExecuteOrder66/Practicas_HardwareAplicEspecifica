#line 1 "C:/Users/El Cido/Desktop/Practicas_HardwareAplicEspecifica/Proyecto_HAE/Ejercicio2/Ej2_emisor/emisor.c"

char txt[14];
float temper,volt;
char *puntero;
float valorConv;

void interrupt(){

 if(INTCON.TMR0IF){
 PORTB.B0 = !PORTB.B0;
 TMR0H = (18661>>8);
 TMR0L = 18661;
 ADCON0.B1 = 1;
 INTCON.TMR0IF = 0;
 }

 if(PIR1.ADIF){
 valorConv = ADRESL + (ADRESH << 8);
 volt = valorConv * 5 / 1024;
 temper = 100.0 * volt -50.0;
 puntero = &temper;


 UART1_Write(*puntero);
 delay_ms(10);
 UART1_Write(*(puntero+1));
 delay_ms(10);
 UART1_Write(*(puntero+2));
 delay_ms(10);
 UART1_Write(*(puntero+3));
 delay_ms(10);

 PIR1.ADIF = 0;
 }
}

void main() {
 ADCON1 = 0x00;
 ADCON0 = 0x03;
 ADCON2 = 0x8D;

 TRISB =0;

 T0CON = 0X85;
 TMR0H = (18661>>8);
 TMR0L = 18661;

 UART1_Init(9600);
 delay_ms(300);

 INTCON.TMR0IF = 0;
 INTCON.TMR0IE = 1;

 PIR1.ADIF = 0;
 PIE1.ADIE = 1;

 INTCON.PEIE = 1;
 INTCON.GIE = 1;

 ADCON0.B1 = 1;


 while(1){
 asm nop;
 }
}
