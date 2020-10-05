clc;
close;
clear;

%16-QAM
T=1;
fs=8;
prect=ones(1,fs);
prect=prect/norm(prect);
match_p=prect(end:-1:1);

L=100000;
%16-QAM signal of length L=100000
ak=4*round(rand(L,1))+2*round(rand(L,1))-3 ...
    +j*(4*round(rand(L,1))+2*round(rand(L,1))-3);

aku=upsample(ak,fs);
s=conv(aku,prect);
len_s=length(s);

%symbol energy of 16-QAM is 2.5d^2
d=2;
Es=2.5*d^2;

%awgn noise
noiseq=randn(len_s,1)+j*randn(len_s,1);
for i=1:15
    snrdb(i)=-5+i;
    snr=10^(snrdb(i)/10);
    noisvar=Es/snr;
    noisdev=sqrt(noisvar);
    awgnois=noisdev*noiseq;
    y=s+awgnois;
%match filter
    z=conv(y,match_p);
    clear y,awgnois;
    %zk=z(1+delayrc:fs:end);
    zk=z(1:fs:end);
    [decoded_qam]=decision_qam16(zk,d);
    decoded_qam=decoded_qam(1:length(ak));
    decoded_qam=reshape(decoded_qam,length(decoded_qam),1);
    %BER
    Q(i)=3*0.5*erfc(sqrt((2*snr/5)/2));
end
figure(1);
ber_figure=semilogy(snrdb,Q,'b-*');
axis([-5 12 .99e-1 2]);
legend('16-QAM');
xlabel('SNR (dB)');
ylabel('Symbol error  probability');

figure(2);
subplot(111)
plot(real(zk(1:length(zk)/10)),imag(zk((1:length(zk)/10))),'.');
axis([-4 4 -4 4]);
xlabel('Real part of matched filter output samples');
ylabel('Imaginary part of matched filter output samples');

figure(3)
subplot(111)
plot(real(decoded_qam),imag(decoded_qam),'.');
axis([-4 4 -4 4]);
legend('16-QAM Constellation');
xlabel('Real part of decoded QAM 16 output');
ylabel('Imaginary part of decoded QAM 16 output');


