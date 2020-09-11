#include<stdio.h>
#include<stdlib.h>



void corr(float x[],float y[],int x_len,int y_len)
{
	int n = x_len+y_len-1;
	float sum=0;
	float *yy[n],*Rxy,*xx;
	Rxy=(float*)calloc(n,sizeof(float));
	xx=(float*)calloc(n,sizeof(float));
	
	//To invert the first sequence
	for(int i=0,j=x_len-1;i<n,j>=0;i++,j--) xx[i] = x[j];
	//creating nxn square matrix with all zeros
	for(int i=0;i<n;i++)
		yy[i]=(float*)calloc(n,sizeof(float));
	
	//Initializing first column of yy as y and then shifting it : print yy to see
	for(int i=0;i<y_len;i++) yy[i][0] = y[i];
	
	
	for(int j=1;j<n;j++)
	{
		for(int i=1;i<n;i++)
			yy[i][j] = yy[i-1][j-1];
	}
	
	printf("\n\n");
	//.........................................................................
	//convolution of yy and inverse sequence of x i.e xx
	for(int i=0;i<n;i++)
	{
		for(int j=0;j<n;j++)
		{
			sum= sum+ yy[i][j]*xx[j];
		}

		Rxy[i] = sum;
		sum=0;
	}
	//...........................................................................
	printf("The corelation output is\n");
	for(int i=0;i<n;i++) printf("%f ",Rxy[i]);
}

int main()
{
	int x_len,y_len;
	float*x,*y;
	x=(float*)calloc(4,sizeof(float));
	y=(float*)calloc(3,sizeof(float));
	
	printf("Enter length of first signal\n");
	scanf("%d",&x_len);
	
	printf("Enter length of second signal\n");
	scanf("%d",&y_len);
	
	printf("Enter the first sequence\n");
	for(int i =0;i<x_len;i++) scanf("%f",&x[i]);
	printf("Enter the second sequence\n");
	for(int i =0;i<y_len;i++) scanf("%f",&y[i]);
	
	corr(x,y,x_len,y_len);
	return 0;
}


