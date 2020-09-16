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
	
	//output parameters
	float *y,*Rxy,*sampled_downx,*sampled_upx;
	//output lengths
	int conv_len = x_len+h_len-1;
	int corr_len = x_len+h_len-1;
	int down_len;
	if(x_len%2==0) down_len = x_len / sampling_factor;
	else down_len = (x_len) / sampling_factor + 1;
	int up_len = x_len + sampling_factor*x_len;
	int cont = 1;
	
	while(cont)
	{
	printf("Select the operation :\n"" Note upsampling and downsampling will be done on the first signal\n"" Operation List : \n ""1.Convolution \n"" 2.Correlation \n"" 3.Down Sampling \n ""4.Upsampling \n");
	
	scanf("%d",&operation_number);
	switch (operation_number)
	{
		case(1): y=convolution(x,h,x_len,h_len);
		printf("The convoluted signal y is :\n");
	        for(int n=0;n<conv_len;n++)printf("%f ",y[n]);break;
	        
		case(2): Rxy=corr(x,h,x_len,h_len);
		printf("The corelation output is\n");
	        for(int i=0;i<corr_len;i++) printf("%f ",Rxy[i]);break;
	        
		case(3):sampled_downx=downsampling(x,x_len,sampling_factor);
		printf("down-sampled signal is : \n");
	        for (int i = 0; i < down_len; i++) printf("%f ", sampled_downx[i]);
                break; 
                
		case(4):sampled_upx=upsampling(x,x_len,sampling_factor); 
	        printf("The up-sampled signal is \n");
	        for (int j = 0; j < up_len; j++) printf("%0.4f ", sampled_upx[j]);break;
	        
		default: printf("Wrong choice\n");break; 
		}
		printf("\nTo continue press 1 and to exit press 0\n");
		scanf("%d",&cont);
	}
        return 0;
}
