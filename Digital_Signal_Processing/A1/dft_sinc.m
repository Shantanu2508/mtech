function dft_sinc(init_len,fin_len,B)
a=1/B;
for i=init_len:10:fin_len
To=i*B;
Ts=1/8*B;
No=To/Ts;
t=-Ts*(No):Ts:Ts*(No-1);t=t';
y=sinc(a*t);
k=0:2*No-1;k=k';
w=2*pi*k/To;
Yf=fft(y);
[Yp,Ym]=cart2pol(real(Yf),imag(Yf));
figure();
subplot(311),stem(t,y),title('Sinc function'),xlabel('time(t)'),ylabel('sinc(t)');
subplot(312),stem(w(1:No),Ym(1:No)),title('Magnitude Spectrum'),xlabel('frequency(w)'),ylabel('|Yf|');
subplot(313),stem(w(1:No),Yp(1:No)),title('Phase Spectrum'),xlabel('frequency(w)'),ylabel('<(Yf)');
end
end