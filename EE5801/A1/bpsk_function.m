function bpsk(L,akbpsk,sbpsk)
bpsk_set=unique(sbpsk);
dbpsk=1;
Es_bpsk=mean(bpsk_set.^2);
Eb_bpsk=Es_bpsk/2;
sbpsk=sbpsk./sqrt(Es_bpsk);
noiseq_bpsk=randn(length(sbpsk),1);
ber_bpsk=[];
ser_bpsk=[];
for i=1:20
    snrdb_bpsk(i)=-5+i;
    snr=10^(snrdb_bpsk(i)/10);
    noisvar_bpsk=Es_bpsk/snr;
    noisdev_bpsk=sqrt(noisvar_bpsk);
    awgnois_bpsk=noisdev_bpsk*noiseq_bpsk;
    y_bpsk=sbpsk+awgnois_bpsk;
    decoded_bpsk=decide_bpsk(y_bpsk,bpsk_set);
    decoded_bpsk=reshape(decoded_bpsk,L,1);
    ser_bpsk=[ser_bpsk;sum(decoded_bpsk~=sbpsk)/L];
    estimate_bits=((decoded_bpsk==-1)*1)+((decoded_bpsk==1)*0);
    ber_bpsk=[ber_bpsk;sum(estimate_bits~=akbpsk)/L];
    Q_bpsk(i)=0.5*erfc(sqrt(snr/2));
    clear y_bpsk,awgnois_bpsk;
end
subplot(2,1,1);
figure=semilogy(snrdb_bpsk,ber_bpsk,'r*-',snrdb_bpsk,ser_bpsk,'ro-',snrdb_bpsk,Q_bpsk,'k^-');
grid on;
axis([-5 15 .99e-4 1]);
legend('Observed BPSK BER','Observed BPSK SER','Analytical BPSK SER');
xlabel('SNR (dB)');
ylabel('Error  probability');
end