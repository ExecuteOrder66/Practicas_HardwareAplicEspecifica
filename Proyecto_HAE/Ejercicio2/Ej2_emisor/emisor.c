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
                volt = valorConv * 5 / 1024;        // Multiplicamos por resolucion del convertidor para obtener voltaje leido
                temper = 100.0 * volt -50.0;  // Calculamos temperatura a partir del voltaje
                puntero = &temper;   //puntero se le asigna el valor de la direccion de memoria de temper

               //Enviamos la informacion con en protocolo UART con cada uno de los punteros
               UART1_Write(*puntero);    //envio 1er byte
               delay_ms(10);
               UART1_Write(*(puntero+1));     //envio 2o byte
               delay_ms(10);
               UART1_Write(*(puntero+2));      //envio 3er byte
               delay_ms(10);
               UART1_Write(*(puntero+3));      //envio 4o byte
               delay_ms(10);

               PIR1.ADIF = 0;
        }
}

void main() {
     ADCON1 = 0x00;
     ADCON0 = 0x03;
     ADCON2 = 0x8D;

     TRISB =0;

     T0CON = 0X85;       //Temporizacion de 1.5s prescaler 64
     TMR0H = (18661>>8);      //alfa para 1.5s
     TMR0L = 18661;           //alfa para 1.5s

     UART1_Init(9600);
     delay_ms(300);

     INTCON.TMR0IF = 0;    //deshabiltiar flag interrupcion
     INTCON.TMR0IE = 1;   //habilitamos interrupciones TMR0

     PIR1.ADIF = 0;   //deshabilitamos flag interrupcion convertidor A/D
     PIE1.ADIE = 1;   //habilitamos interrupciones convertidor A/D

     INTCON.PEIE = 1;
     INTCON.GIE = 1;    // habilitamos interrupciones en general

     ADCON0.B1 = 1;    //comienza conversion convertidor A/D


     while(1){
         asm nop;
     }
}