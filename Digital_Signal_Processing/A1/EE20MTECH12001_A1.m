%Autocorrelation
clc;clear all;close;
x=[2 3 -1];
x=x';
N=length(x);
A=zeros(N,N);
for i=1:length(x)
    A(:,i)=[zeros(i-1,1)' x(1:N-i+1)']';
end
X=A(:,1);
Rxx=A'*X;
Rxx=[Rxx(N:-1:2)' Rxx']';
display(Rxx);

%sinc function and FT
clc;clear;
B=10;
a=1/B;
for i=5:10:100
To=i*B;
Ts=1/8*B;
fs=1/Ts;
No=To/Ts;
t=-Ts*(No):Ts:Ts*(No-1);t=t';
%t=linspace(-10*B,10*B);
y=sinc(a*t);
%subplot(311),stem(t,y);
k=0:2*No-1;k=k';
w=2*pi*k/To;
Yf=fft(y);
[Yp,Ym]=cart2pol(real(Yf),imag(Yf));
figure();
subplot(211),stem(w(1:No),Ym(1:No));
subplot(212),stem(w(1:No),Yp(1:No));
end

%Orthogonality
clc;clear;
T=2*pi;B=1/T;
fs=100*B;
Ts=1/fs;
t=0:Ts:T;t=t';

y1=sin(t);
y2=cos(t);
subplot(211),stem(t,y1);
subplot(212),stem(t,y2);

x=round(y1'*y2);
display(x);
