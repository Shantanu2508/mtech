#include <iostream>
#include<stack>
using namespace std;

bool* NAND(bool* input[], int N)
{
    int n = 0;
    bool* output = new bool[N];
    stack<bool> NAND_Stack;
    for(int i = 0; i < N; i++)
    {
        NAND_Stack.push(input[i][0]);
        if(!NAND_Stack.top()|| !input[i][1])
        {
            output[n] = true;
            n++;
        }
        else
        {
            output[n] = false;
            n++;
        }
        NAND_Stack.pop();
    }
    return output;
}

bool* getX(bool* input[], int N)
{
    bool* X = new bool[N];
    for(int i = 0; i < N; i++)
    {
        X[i] = input[i][0];
    }
    return X;
}

bool* getY(bool* input[], int N)
{
    bool* Y = new bool[N];
    for(int i = 0; i < N; i++)
    {
        Y[i] = input[i][1];
    }
    return Y;
}

int main() {
 int N;
 cin >> N;
 bool** input = new bool*[N];
 bool* out1 = new bool[N];
 bool* out2 = new bool[N];
 
 //Take input
 for(int i = 0; i < N; i++)
 {
     input[i] = new bool[2];
 }
 
 for(int i = 0; i < N; i++)
 {
     for(int j = 0; j < 2; j++)
     {
         cin >> input[i][j];
     }
 }
 
 bool* X = new bool[N];
 X = getX(input,N);
 bool* Y = new bool[N];
 Y = getY(input,N);
 
 bool** temp1 = new bool*[N];
 for(int i = 0; i < N; i++)
 {
     temp1[i] = new bool[2];
 }
 for(int i = 0; i < N; i++)
 {
     temp1[i][0] = X[i];
     temp1[i][1] = X[i];
 }
 out1 = NAND(temp1,N);
 
 bool** temp2 = new bool*[N];
 for(int i = 0; i < N; i++)
 {
     temp2[i] = new bool[2];
 }
 for(int i = 0; i < N; i++)
 {
     temp2[i][0] = out1[i];
     temp2[i][1] = Y[i];
 }
 out2 = NAND(temp2,N);
 
 cout << "X Y OUT" << endl;
 for(int i = 0; i < N; i++)
 {
     cout << input[i][0] << " " << input[i][1] << " " << out2[i] << endl;
 }
 
 
 //De-allocate memory
 for(int i = 0; i < N; i++)
 {
     delete input[i];
     delete temp1[i];
     delete temp2[i];
 }
 delete input;
 delete temp1;
 delete temp2;
 delete out1;
 delete out2;
 return 0;
}