#include <avr/io.h>
#include <util/delay.h>
#include<stdbool.h>
  
bool NAND(bool A, bool B)
{
   return !(A && B);
}

bool NAND3(bool A, bool B, bool C)
{
   bool Y = NAND(A,B);
   return NAND(NAND(Y,Y),C);
}


int main (void)
{

// declare input pins
   DDRD |= 0b00000000;	
   // Arduino boards have a LED at PB5
   // set PB5, pin 13 of arduino as output
   DDRB    |= ((1 << DDB5));
   
   // declare variables
   int x,y,z,w,f,ip;

   while (1) {
    
	   ip = PIND;
	   x = ip & 0b00000100;
	   y = ip & 0b00001000;
	   z = ip & 0b00010000;
           w = ip & 0b00100000;


      	   f = NAND3(NAND(NAND(x,x),y),NAND(NAND(y,y),z),NAND(NAND(NAND(x,z),NAND(x,z)),w));
      	   //f = NAND3(x,y,z);

	   if(f)
              PORTB = ((1 <<  PB5));
	   else
	      PORTB = ((0 << PB5));
   }

  return 0;

}


