void main() {
        char i;
        char array[]={0x01,0x02,0x04,0x08,0x10,0x20,0x40,0x80};
        ADCON1 = 0x07;
        TRISC = 0x00;        //Terminales del puerto C como salidas
        PORTC = 0;
        while(1){
                for(i=0;i<8;i++){        //bucle para recorrer todos los terminales
                        PORTC=array[i];        //enciende led
                        delay_ms(200);
                        PORTC=array[i];        //apaga led
                        delay_ms(100);
                }
        }

}