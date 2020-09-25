clc;
clear;
close;

L=64;
n=6;

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