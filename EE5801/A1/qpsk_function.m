function qpsk_function(L,ak,s)
qpsk_sym_set=unique(s);
len_s=length(s);

Es=mean(abs(qpsk_sym_set).^2);
s=s./sqrt(Es);
%awgn noise
noiseq=randn(len_s,1)+j*randn(len_s,1);
ber=[];
ser=[];
for i=1:20
    snrdb(i)=-5+i;
    snr=10^(snrdb(i)/10);
    noisvar=Es/(2*snr);
    noisdev=sqrt(noisvar);
    awgnois=noisdev*noiseq;
    y=s+awgnois;
    decoded_qpsk=decide_qpsk(y,qpsk_sym_set);
    decoded_qpsk=reshape(decoded_qpsk,length(decoded_qpsk),1);
    estimate=((decoded_qpsk == 1+j)*[0 0]) + ((decoded_qpsk == -1+j)*[1 0]) + ((decoded_qpsk==-1-j)*[1 1]) + ((decoded_qpsk== 1-j)*[0 1]); 
    decoded_qpsk=decoded_qpsk./sqrt(Es);
    ser=[ser;sum(decoded_qpsk~=s)/L];
    ber=[ber;sum(estimate~=ak)/L];
    ber_qpsk=ber(:,1);
    Q(i)=erfc(sqrt(snr/2)*sin(pi/4));
end
subplot(2,1,2);
figure=semilogy(snrdb,ber_qpsk,'b*-',snrdb,ser,'bo-',snrdb,Q,'k^-');
grid on;
axis([-5 15 .99e-4 1]);
legend('Observed QPSK BER','Observed QPSK SER','Analytical QPSK SER');
xlabel('SNR (dB)');
ylabel('Error  probability');
end

