#include<stdio.h>
#include<stdlib.h>
float *convolution (float x[] , float h[], int x_len, int h_len)
{
	float*y;
	
	int cov_len = x_len + h_len -1;
	
	y = (float*)calloc(cov_len,sizeof(float));
	for(int n=0;n<cov_len;n++)
	{
		float temp=0;
		for(int k=0;k<x_len;k++)
		{
			if((n-k)<0 || (n-k)>h_len-1) y[n]=y[n];
			else
			{
			temp=temp+x[k]*h[n-k];
			}
		}
		y[n]=temp;
	}
	return y;
	
}
//corr is function for finding correlation between x and y : Corelation is convolution of y and inv sequence of x i.e Rxy[k] = Conv( x(-n)y(n-k))
float *corr(float x[],float y[],int x_len,int y_len)
{
	int n = x_len+y_len-1;
	float sum=0;
	float *yy[n],*Rxy,*xx;
	Rxy=(float*)calloc(n,sizeof(float));
	xx=(float*)calloc(n,sizeof(float));
	

	//creating nxn square matrix with all zeros
	for(int i=0,j=x_len-1;i<n,j>=0;i++,j--) xx[i] = x[j];
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

	for(int i=0;i<n;i++)
	{
		for(int j=0;j<n;j++)
		{
			sum= sum+ yy[i][j]*xx[j];
		}

		Rxy[n-1-i] = sum;
		sum=0;
	}
	//...........................................................................
	return Rxy;
}







float *downsampling(float x[], int x_len, int sampling_factor)
{

	int new_len;
	if(x_len%2==0) new_len = x_len / sampling_factor;
	else new_len = (x_len) / sampling_factor + 1;
	float* sampled_x;
	sampled_x = (float*)calloc(new_len, sizeof(float));
	for (int i = 0, j = 0; i < x_len, j < new_len; i = i + sampling_factor, j++) sampled_x[j] = x[i];
	return sampled_x;
}


float *upsampling(float x[], int x_len, int sampling_factor)
{
	int j=0;
	int new_len = x_len + sampling_factor*x_len;
	float* sampled_x;
	sampled_x = (float*)calloc(new_len, sizeof(float));
	for (int i = 0; i < x_len; i++)
	{
		int t=sampling_factor;
		sampled_x[j] = x[i];
		while (t--)
		{
			j++;
			sampled_x[j] = 0;
		}
		j++;
	}
	return sampled_x;
}
