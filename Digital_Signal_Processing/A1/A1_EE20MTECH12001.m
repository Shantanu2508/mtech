%DSP Lab: Assignment 1 
%Author: Shantanu Yadav, EE20MTECH12001, IIT Hyderabad
%This program contains 3 parts:
%1)Correlation
%2)Orthogonality Check
%3) Fourier Transform of sinc pulse
%......................................................


%Auto-correlation
clc;clear;
n=256;
x=100*rand(1,n);
x=x';
N=length(x);
Rxx=correlation1(x,N);
Sxx=dft1(Rxx,N);
display(Rxx);
display(Sxx);
[Sp,Sm]=cart2pol(real(Sxx),imag(Sxx));
figure();
subplot(211),stem(Rxx),title('Autocorrelation function'),xlabel('x'),ylabel('Rxx');
subplot(212),stem(Sm),title('PSD function'),xlabel('x'),ylabel('Sxx');


%DFT of sinc pulse
B=10;
init_len=5;
fin_len=100;
%dft_sinc(init_len,fin_len,B);
%...............................
a=1/B;
for i=init_len:10:fin_len
To=i*B;
Ts=1/8*B;
No=To/Ts;
t=-Ts*(No):Ts:Ts*(No-1);t=t';
y=sinc(a*t);
k=0:2*No-1;k=k';
w=2*pi*k/To;
%Yf2=fft(y);
Yf=dft1(y,2*No);
[Yp,Ym]=cart2pol(real(Yf),imag(Yf));
figure();
subplot(311),stem(t,y),title('Sinc function'),xlabel('time(t)'),ylabel('sinc(t)');
subplot(312),stem(w,Ym),title('Magnitude Spectrum'),xlabel('frequency(w)'),ylabel('|Yf|');
subplot(313),stem(w,Yp),title('Phase Spectrum'),xlabel('frequency(w)'),ylabel('<(Yf)');
end
%...............................

%Orthogonality of sin/cos
T=2*pi;B=1/T;
fs=100*B;
Ts=1/fs;
t=0:Ts:T;t=t';
y1=sin(t);
y2=cos(t);
yy=innerproduct1(y1,y2);
display(yy);

%Function Definitions
function Rxx=correlation1(x,N)
A=zeros(N,N);
for i=1:length(x)
    A(:,i)=[zeros(i-1,1)' x(1:N-i+1)']';
end
X=A(:,1);
Rxx=A'*X;
Rxx=[Rxx(N:-1:2)' Rxx']';
end

function Yf=dft1(yk,N)
for k=1:N
    sum=0;
    for i=1:N
        sum=sum+yk(i)*exp(-j*2*pi*k*i/N);
    end
    Yf(k)=sum;
end
Yf=Yf';
Yf=fftshift(Yf);
end

function x=innerproduct1(y1,y2)
x=round(y1'*y2);
end