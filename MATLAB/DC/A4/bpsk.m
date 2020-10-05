clc;
close;
clear;

T=1;
fc=1/T;
prect=ones(1,fc);
match_p=prect(end:-1:1);
A=prect(1);
Ep=A^2*T;
L=100000;

ak=round(rand(L,1));
s=sqrt(Ep)*exp(j*pi*ak);

d=1;
Es=d^2;
noiseq=randn(length(s),1);
for i=1:15
    snrdb(i)=-5+i;
    snr=10^(snrdb(i)/10);
    noisvar=Es/snr;
    noisdev=sqrt(noisvar);
    awgnois=noisdev*noiseq;
    y=s+awgnois;
    decoded_bpsk=decision_bpsk(y,d,d);
    Q(i)=0.5*erfc(sqrt(snr));
    clear y,awgnois;
end

figure(1);
ber_figure=semilogy(snrdb,Q,'b-*');
axis([-5 12 .99e-5 2]);
legend('BPSK');
xlabel('SNR (dB)');
ylabel('Symbol error  probability');


figure(2)
subplot(111)
plot(real(decoded_bpsk),imag(decoded_bpsk),'.');
axis([-2 2 -2 2]);
legend('BPSK Constellation');
xlabel('Real part of decoded BPSK output');
ylabel('Imaginary part of decoded BPSK output');
