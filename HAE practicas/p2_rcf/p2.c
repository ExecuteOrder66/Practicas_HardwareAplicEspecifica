void main() {
    char d,u,i=0;
    char numeros[]={0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x67};
    ADCON1=0x07;
    
    TRISA.B0=0;
    TRISA.B1=0;
    TRISD=0;
    
    while(1){
              for(d=0;d<6;d++){
                                for(u=0;u<10;u++){
                                                 for(i=0;i<25;i++){
                                                              PORTD=numeros[u];     //numero de unidades deseado al puerto D
                                                              PORTA.B0=1;           //Encendemos display de unidades
                                                              delay_ms(20);         //50T=> 20ms mostrando el valor de unidades
                                                              PORTA.B0=0;           //Apagamos display de unidades
                                                              
                                                              PORTD=numeros[d];     //numero de decenas deseado al puerto D
                                                              PORTA.B1=1;           //Encendemos display de decenas
                                                              delay_ms(20);         //50T=> 20ms mostrando el valor de unidades
                                                              PORTA.B1=0;           //Apagamos display de decenas
                                                  } 

                                }

              }

      }
}