void main() {
        char i;
        char array[]={0x81,0x42,0x24,0x18,0x18,0x24,0x42,0x81};
        ADCON1 = 0x07;
        TRISC = 0x00;
        
        while(1){
               for(i=0;i<8;i++){
                  PORTC=array[i];        //enciende led
                  delay_ms(200);
                  PORTC=array[i];        //apaga led
                  delay_ms(100);
               }
        }
}