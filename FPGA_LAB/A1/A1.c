/*
   Author: Shantanu Yadav
   Desc: The given boolean expression obtained using K-Map is implemented using NAND gate
*/
#include<stdio.h>
#include<stdbool.h>

bool NAND(bool A, bool B)
{
   return !(A && B);
}

bool NAND3(bool A, bool B, bool C)
{
   !((A && B) && C);
}


bool F(bool X, bool Y, bool Z, bool W)
{

   return NAND3(NAND(NAND(X,X),Y),NAND(NAND(Y,Y),Z),NAND(NAND(NAND(X,Z),NAND(X,Z)),W));
}

int main()
{
   bool X = false, Y = true, Z = true, W = false;
   bool result;
   result = F(X,Y,Z,W);
   (result)?(printf("1\n")):(printf("0\n"));
   return 0;
   
}
