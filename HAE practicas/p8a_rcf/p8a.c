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
char txt[14];
float v;
char escala=0;
char unidad[7];

void representar(){
     char i;
     v= x*0.0048828125*22.2;        //Este valor numero es la resolucion del convertidor A/D---->   resolucion= (Vref+ - Vref-)/2^n  (en este caso n=10)
     v= v+10.5;                     //AQUI ya tenemos la presion en kPa
     for(i=0;i<7;i++) unidad[i]=0;     //Reseteamos cadena unidad
     switch(escala){
                    case 1:  v= v /  6.8927;       //Caso Psi     1 Psi = 6’8927 kPa
                               unidad[0]='P'; unidad[1]='s'; unidad[2]='i';
                               break;
                    case 2:  v= v /  101.325;      //Caso Atm     1 Atm = 101’325 kPa
                               unidad[0]='A'; unidad[1]='t'; unidad[2]='m';
                               break;
                    case 3:  v=v / 0.1;            //Caso mBar    1 mBar = 0’1 kPa
                               unidad[0]='m'; unidad[1]='B'; unidad[2]='a'; unidad[3]='r';
                               break;
                    case 4:  v=v /  0.13328;               //Caso mmHg    1 mmHg = 0’13328 kPa
                               unidad[0]='m'; unidad[1]='m'; unidad[2]='H'; unidad[3]='g';
                               break;
                    case 5:  v=v / 0.001;   //Caso N/m2     1 N/m2 = 1 Pa = 0’001 kPa
                               unidad[0]='N'; unidad[1]='/'; unidad[2]='m'; unidad[3]='2';
                               break;
                    case 6:  v=v / 98.039;   //Caso Kg/cm2    1 Kg/cm2 = 98’039 kpa
                               unidad[0]='K'; unidad[1]='g'; unidad[2]='/'; unidad[3]='c';
                               unidad[4]='m'; unidad[5]='2';
                               break;
                    case 7:   v= v / 9.81;   //Caso kp/cm2
                              unidad[0]='k'; unidad[1]='p'; unidad[2]='/'; unidad[3]='c';
                               unidad[4]='m'; unidad[5]='2';
                               break;
                    default:   unidad[0]='k';     //Caso kPa POR DEFECTO
                               unidad[1]='P'; unidad[2]='a';
                               break;
     }
     Lcd_Cmd(_LCD_CLEAR);     //Borramos pantalla lcd
     FloatToStr(v,txt);
     Lcd_out(1,1,txt);        //Mostramos resultado por pantalla
     Lcd_Chr_cp(' ');
     Lcd_Out_CP(unidad);

}

void interrupt(){
     //Si se activa la interrupcion del convertidor
     if(PIR1.ADIF){
       x=0;
       x=((ADRESH<<8) + ADRESL);      //Cargamos el valor muestreado de la tensión de entrada

       //Vi= resolucion*D + Vref-   (como en este caso Vref- es 0, no la sumamos)
       //MULTIPLICAMOS X 100 para tener la temperatura
       //MARCAR LCD Y CONVERSIONS en las librerias del proyecto(View/Library manager/System Libraries)
       representar();
     }

        //Si se activa la interrupcion del timer (1'5s)
       if(INTCON.TMR0IF){
                         PORTC.B0= !PORTC.B0;
          TMR0H= (3036>>8);      //Reseteamos el valor de alfa para hacer otra temporizacion de 1.5s
          TMR0L= 3036;
          ADCON0.GO=1;  //Comienza el muestreo de la señal analogica otra vez

       }

      if(INTCON3.INT2IF){
                        escala++;
                        escala= escala%8; //Modulo 8
                        representar();
      }

     PIR1.ADIF=0;     //Deshabilitamos interrupcion
     INTCON.TMR0IF=0;
     INTCON3.INT2IF=0;
}

void main() {
     TRISC.B0=0;
     PORTC.B0=0;
     TRISE.B0=1;  //Declarar RE0/AN5 como entrada
     TRISB.B2=1;           //portb.b2 como entrada

     ADCON0=0x69;      //Escogemos una combinacion en la que AN5 sea analogica y las tensiones de referencia vengan del micro (vdd y vss)
                       //ATENCION AL CANAL ESCOGIDO, DEBE SER EL DE AN5
     ADCON1=0xC0;     //prescaler 16 (el mas pequeño) Y AN5 analogica

      Lcd_Init (); //Iniciamos el circuito de la pantalla LCD

      INTCON2=0;            //Int0 por flancos de bajada, portb pull-ups activadas

      INTCON3.INT2IF=0;
      INTCON3.INT2IE=1;      //Habilitamos interrupcion para el boton

      INTCON.TMR0IF=0;
      INTCON.TMR0IE=1;       //Habilitamos interrupcion del timer


      PIR1.ADIF=0;
      PIE1.ADIE=1;           //Habilitamos interrupcion para el convertidor A/D
      INTCON.PEIE=1;
      INTCON.GIE=1;

      T0CON=0x84;
      TMR0H= (3036>>8);
      TMR0L= 3036;
      ADCON0.GO=1; //Comienza el muestreo de la señal analogica

      while(1);
}
