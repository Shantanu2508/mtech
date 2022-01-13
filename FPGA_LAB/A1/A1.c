/*
   Author: Shantanu Yadav
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
}

int main()
{
   bool X = false, Y = true, Z = true, W = false;
   bool result1, result2;
   result1 = F(X,Y,Z,W);
   result2 = KMAP(X,Y,Z,W);
   (result1 == result2)?(printf("F = K-Map reduced expression\n")):(printf("Results dont match\n"));
   return 0;
   
}
