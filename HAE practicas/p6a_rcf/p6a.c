void interrupt(){
   INTCON.TMR0IF=0;    //Deshabilitamos interrupción
   
   PORTC.B0=!PORTC.B0; //Cambia estado del terminal RC0
   if(PORTC.B0==0){
        // T0CON=0x42; //Apagamos temporizador  para caso t=0.3ms y prescaler 4
         TMR0L=81;      //Introducimos nuevo alfa para t=0'7ms
         T0CON=0xC2;     //Encendemos temporizador para caso t=0.7ms y prescaler 8

   }else{
        // T0CON=0x42; //Apagamos temporizador t=0'7ms prescaler 8
         TMR0L=106;  //alfa para t=0'3ms precaler 4
         T0CON=0xC1; //Encendemos temporizador para t=0'3ms y precaler 4

   }

}
void main() {
     //ir probando  2, 4, 8, 16, 32, 64, 128 y 256
     TRISC=0;
    PORTC=0;

    T0CON=0x41;

    INTCON.TMR0IF=0;
    INTCON.TMR0IE=1;
    INTCON.GIE=1;
    
    TMR0L=106;        //Aqui introducimos el valor inicial (alfa)
    
    T0CON=0xC1; //Activamos el temporizador
    while(1);
}