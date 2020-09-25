clc;
clear;
close;

L=64;
n=6;
fm=4000;
T=1/fm;
fs=2*fm;
Ts=1/fs;
Tb=Ts/6;
Tsym=2*Tb;
t=[0:Ts:T];
%100 sequence PCM seqeunce and quantization
sig_in=randi(100,1,100);
[sq_out,qnois,qlevel]=uniquan(sig_in,L);
[sqent_out,sqen_bit_out,sqen_out]=encode(sq_out,qlevel,L);

%PAM signal
plevels=[-3,-1,1,3];
[pam4]=pam4(sqent_out,plevels);


%Oversampling
fovsamp=4;
ak=sqent_out;
prect=ones(1,fovsamp);
prmatch=prect(end:-1:1);
j=1;
for i=1:length(pam4)
    count=fovsamp;
    while count > 0
        xrect(j)=pam4(i);
        j=j+1;
        count = count -1;
    end
end

%Adding AWGN noise
E_s = sum(xrect.^2)/length(xrect);
SNRdb=6;
SNR=10^(SNRdb/10);
noisepow=E_s/SNR;
std_dev=sqrt(noisepow);
noiseq=randn(length(xrect),1);
awgnois=std_dev*noiseq;
xrect=reshape(xrect,length(xrect),1);
y=xrect+awgnois;

%matched filter 
h_t=prect(end:-1:1);
h_t=h_t/norm(h_t);
for i=1:length(h_t)
    for j=i+fovsamp:1:length(h_t)+fovsamp
        h_t_shift(j)=h_t(i);
    end
end
z = conv(y,h_t_shift);
zk=z(fovsamp:fovsamp:end);
zk=zk(2:end);

%decision making
[decoded_pam4]=decision_metric(zk,plevels);
[PAM_BER]=BER(decoded_pam4,pam4);
[decoded_pcm]=decode_pam4(decoded_pam4,plevels,length(plevels));
[PCM_BER]=BER(decoded_pcm,sqent_out);
%SQNR
E_sig_in=sum(sig_in.^2)/length(sig_in);
maxA=max(sig_in);
minA=min(sig_in);
E_q=((maxA-minA)^2)/(12*L^2);
SQNR=E_sig_in/E_q;
SQNRdb=10*log(SQNR);
fprintf('BER of PAM = %d out of %d symbols\n',PAM_BER,length(pam4));
fprintf('BER of PCM = %d out of %d symbols\n',PCM_BER,length(sqent_out));
fprintf('SQNR of the input signal and quantized values is %f dB\n',SQNRdb);

%Plotting

subplot(2,1,1)
plot(sig_in);
legend('Input Signal');
xlabel('time(t)');ylabel('sig_in');

subplot(2,1,2)
stem(sq_out);
legend('Quantized Signal');
xlabel('time(t)');ylabel('sq_out');

figure(2)
subplot(2,1,1)
stem(pam4);
legend('PAM Signal');
xlabel('time(t)');ylabel('pam4');

subplot(2,1,2)
stem(xrect);
legend('Transmitted Signal');
xlabel('time(t)');ylabel('xrect');

figure(3);
subplot(3,1,1)
stem(y);
legend('Received Signal');
xlabel('time(t)');ylabel('y');

subplot(3,1,2)
stem(z);
legend('Output of Matched Filter Signal');
xlabel('time(t)');ylabel('z');

subplot(3,1,3)
stem(zk);
legend('Sampled at bit duration');
xlabel('time(t)');ylabel('zk');

figure(4)
subplot(2,1,1)
stem(decoded_pam4);
legend('Decoded PAM signal');
xlabel('time(t)');ylabel('decoded_pam4');

subplot(2,1,2)
stem(decoded_pcm);
legend('Decoded PCM signal Bits');
xlabel('time(t)');ylabel('decoded_pcm');
