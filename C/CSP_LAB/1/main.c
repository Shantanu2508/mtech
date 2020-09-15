#include<stdio.h>
#include<stdlib.h>
#include"sigimp.h"
int main()
{
     
     	int operation_number,sampling_factor;
     	int x_len,h_len;
     	
     	//take input length
     	printf("enter length of first signal\n");
	scanf("%d",&x_len);
	printf("enter length of second signal\n");
	scanf("%d",&h_len);
	
	float *x,*h;
	x=(float*)calloc(x_len,sizeof(float));
	h=(float*)calloc(h_len,sizeof(float));
	
	//take values of signals
	printf("Enter the values of first signal\n");
	for(int i=0;i<x_len;i++)scanf("%f",&x[i]);
	printf("Enter the values of second signal\n");
	for(int i=0;i<h_len;i++)scanf("%f",&h[i]);
	printf("Enter sampling factor\n");
	scanf("%d",&sampling_factor);
	
	int cont = 1;
	
	while(cont)
	{
	printf("Select the operation :\n"" Note upsampling and downsampling will be done on the first signal\n"" Operation List : \n ""1.Convolution \n"" 2.Correlation \n"" 3.Down Sampling \n ""4.Upsampling \n");
	
	scanf("%d",&operation_number);
	switch (operation_number)
	{
		case(1): convolution(x,h,x_len,h_len);break;
		case(2): corr(x,h,x_len,h_len);break;
		case(3):downsampling(x,x_len,sampling_factor);break; 
		case(4):upsampling(x,x_len,sampling_factor); break;
		default: printf("Wrong choice\n");break; 
		}
		printf("\nTo continue press 1 and to exit press 0\n");
		scanf("%d",&cont);
	}
        return 0;
}
