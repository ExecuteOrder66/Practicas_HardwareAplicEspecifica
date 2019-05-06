void main() {
	//int i;
	ADCON1 = 0x07;
	TRISC.B0=0x00;	//Terminales del puerto C como salidas
	PORTC.B0=0;
	while(1){
		//for(i=0;i<8;i++){        //bucle para recorrer todos los terminales
			PORTC.B0=1;	//enciende led
			delay_ms(200);
			PORTC.B0=0;	//apaga led
			delay_ms(100);
		//}
	}

}