#include <Arduino.h>
//PIN declaration
#define OUT 13

int NAND(int A, int B)
{
	return !(A && B);
}

int NAND3(int A, int B, int C)
{
	return !((A && B)&& C);
}

void setup() 
{
	pinMode(OUT,OUTPUT);
}

void loop() 
{
	int out;
	for(int i = 0; i < 2; i++)
	{
		for(int j = 0; j < 2; j++)
		{
			for(int k = 0; k < 2; k++)
			{
				for(int l = 0; l < 2; l++)
				{
					out = NAND3(NAND(NAND(i,i),j),NAND(NAND(j,j),k),NAND(NAND(NAND(i,k),NAND(i,k)),l));
					if(out)
					{
						digitalWrite(OUT,HIGH);
						delay(200);
					}
					else
					{
						digitalWrite(OUT,LOW);
						delay(200);
					}

				}
			}
		}
	}
}
