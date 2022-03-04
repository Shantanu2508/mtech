/*
   Author: Shantanu Yadav
<<<<<<< HEAD
   Desc: The given boolean expression and the reduced K-Map expression are cross-verified.
*/
#include<stdio.h>
bool F(bool X, bool Y, bool Z, bool W)
{
   return (!X && !Y && !Z && !W) || (!X && !Y && !Z && W) || (!X && Y && !Z && !W) || (!X && Y && !Z && W) || (!X && Y && Z && W) || (!X && Y && Z && !W) || (X && Y && Z && W) || (X && !Y && !Z && !W) || (X && !Y && !Z && W) || (X && !Y && Z && W);
}

bool KMAP(bool X, bool Y, bool Z, bool W)
{
   return (!X && Y) || (!Y && Z) || (X && Z && W);
=======
   Desc: The boolean expression F(X,Y,Z,W) = X'Y + Y'Z + XZW is implemented using NAND gate
   Github Link : https://github.com/Shantanu2508/mtech/tree/master/FPGA_LAB/A1
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
>>>>>>> 719b4b3580cae5e223beaff81b818098e2bbc68c
}

int main()
{
   bool X = false, Y = true, Z = true, W = false;
<<<<<<< HEAD
   bool result1, result2;
   result1 = F(X,Y,Z,W);
   result2 = KMAP(X,Y,Z,W);
   (result1 == result2)?(printf("F = K-Map reduced expression\n")):(printf("Results dont match\n"));
=======
   bool result;
   result = F(X,Y,Z,W);
   (result)?(printf("1\n")):(printf("0\n"));
>>>>>>> 719b4b3580cae5e223beaff81b818098e2bbc68c
   return 0;
   
}
