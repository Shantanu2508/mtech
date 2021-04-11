%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Assignment : 05
% Name       : Shantanu Yadav
% Roll No    : EE20MTECH12001
% Course     : DSP Lab 2021
% 
% Details    : Time Offset Estimation in OFDM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc;

%% Inputs
baseFreq = 5;             % Base Frequency
symTime = 1/baseFreq;     % Symbol Time
totalSubcarr=256000;
fftSize = 256;     % FFT Size (Should be non zero integer)
L=32;               %length of cyclic prefix
%% 
fs=fftSize*baseFreq;
Tsubcarr=symTime/fftSize; %Time for each sub carrier
Ton=totalSubcarr*Tsubcarr;
Ts=1/fs;
t_i=0:Ts:Ts*(fftSize-1);t_i=t_i';

K=50;
T=Tsubcarr/K;
f=1/Tsubcarr;
t=0:T:symTime-T;
%% Basis function for PSK Modulation
qpsk_basis_function=[sqrt(2/Ton)*cos(2*pi*f*t) ; sqrt(2/Ton)*sin(2*pi*f*t)] ;
qpsk_basis_size=size(qpsk_basis_function);
%% Generate random bits with uniform distribution 
%%Map the bits to QPSK 
% no. of the symbols equals to no. of subcarrier in assignment 2.
%generate N random numbers in the interval (a,b) with the formula r = a + (b-a).*rand(N,1). 

qpsk_bits=randi([0,1],totalSubcarr,2);

qpsk_data=(2*qpsk_bits(:,1)-1)+1i*(2*qpsk_bits(:,2)-1);

%% OFDM Transmitter
parallel_qpsk=reshape(qpsk_data,[fftSize,totalSubcarr/fftSize ]);
parallel_si_qpsk=idft_mat(parallel_qpsk,fftSize);
si_qpsk=reshape(parallel_si_qpsk,[totalSubcarr,1]);
%si_qpsk_cp=[si_qpsk(totalSubcarr-L+1:totalSubcarr)' si_qpsk']';
%% AWGN noise
%channel model: y=x+n where n is complex noise
M_qpsk=length(si_qpsk);

Es_qpsk=sum(abs(si_qpsk).^2)/M_qpsk;
Eb_qpsk=Es_qpsk/2;

SNR=1;

time_offset_array=[ceil(0.01*fftSize):ceil(0.1*fftSize)]; %Time Offset Array

for j=1:length(time_offset_array)
    no=time_offset_array(j);
for i=0:50
    SNRb(i+1)=i*SNR;
    SNRs_qpsk(i+1)=SNRb(i+1)+10*log(2);
    
    SNR_lin_qpsk(i+1)=10^(SNRs_qpsk(i+1)/10);
    
    sigma_qpsk(i+1)=sqrt(Es_qpsk/(2*SNR_lin_qpsk(i+1)));
    
    n_qpsk=sigma_qpsk(i+1)*(randn(M_qpsk,1)+1i*randn(M_qpsk,1));
    yn=si_qpsk+n_qpsk;
    yn=[zeros(1,no) yn(1:length(yn)-no).'].';
    yn=reshape(yn,fftSize,totalSubcarr/fftSize);
    n_qpsk=reshape(n_qpsk,fftSize,totalSubcarr/fftSize);
    
    Yk=dft_mat(yn,fftSize);
    
    %%running this command gives better performance but it considers
    %%frequency domain analysis
    %Yk=shiftedFFT(parallel_si_qpsk,no,fftSize)+dft_mat(n_qpsk,fftSize);
    Hk=Yk./parallel_qpsk;
    
    S=sum(conj(Hk(2:fftSize,:)).*Hk(1:fftSize-1,:))/(fftSize-1);
    estimate_no=abs((fftSize*log(S))/(1i*2*pi));
    err=(no*ones(1,totalSubcarr/fftSize)-estimate_no).^2;
    mse(i+1)=sum(err)/length(err);
end
hold on
grid on
%plot(SNRb,mse);
semilogy(SNRb,mse);
xlabel("SNR");
ylabel("Mean Square Estimation Error for Time Offset");
end
%% FUNCTION DEFINITIONS:

function X=psk(data,m,A)
%% BPSK
if (m==2)
    bpsk_const=A*[-1,1];
    X=zeros(size(data))';
    [~,I]=sort(SquareDist(bpsk_const',data));
    idx=I(1,:);
    for i=1:length(data)
        X(i)=bpsk_const(:,idx(i));
    end
end
%% QPSK
if m==4
    qpsk_const=A*[[1;1],[-1;1],[-1;-1],[1;-1]];
    X=zeros(size(data))';
    [~,I]=sort(SquareDist(qpsk_const',data));
    idx=I(1,:);
    for i=1:length(data)
        X(:,i)=qpsk_const(:,idx(i));
    end
end
end
%% Function to calculate Euclidean Distance
function D = SquareDist(X1, X2)
% SQUAREDIST - computes Euclidean SQUARED distance matrix
%
% E = distance(X1, X2)
%
%    X1 - (NxD) matrix
%    X2 - (MxD) matrix
%
% Returns:
%    E - (NxM) Euclidean SQUARED distances between vectors in X1 and X2

n = size(X1, 1);
m = size(X2, 1);

sq1 = sum(X1.*X1, 2);
sq2 = sum(X2.*X2, 2);

D = sq1*ones(1, m) + ones(n, 1)*sq2' - 2*(X1*X2');
end
%% 
function Yf=idft(yk,N)
for k=0:N-1
    sum=0;
    for j=0:N-1   
        sum=sum+yk(j+1)*exp(1i*2*pi*k*j/N);
    end
    Yf(k+1)=sum;
end
Yf=Yf.'/N;
end
%% IDFT using Matrix
function xn=idft_mat(Xk,N)
%Generating NxN idft mat
IDFT_mat=zeros(N,N);
W=exp(1i*2*pi/N);
for n=0:N-1
    for k=0:N-1
        IDFT_mat(n+1,k+1)=(W^(n*k))/N;
    end
end
%display(IDFT_mat);
xn=IDFT_mat*Xk;
end
%% DFT code using Matrix
function Xk=dft_mat(xn,N)
IDFT_mat=zeros(N,N);
W=exp(-1i*2*pi/N);
for n=0:N-1
    for k=0:N-1
        IDFT_mat(n+1,k+1)=(W^(n*k));
    end
end
%display(DFT_mat);
Xk=IDFT_mat*xn;
end


function Yk=shiftedFFT(xn,shift,fftSize)
    factor_arr=zeros(1,fftSize);
    for k=0:fftSize-1
        factor_arr(k+1)=exp((-1i*2*pi*k*shift)/fftSize);
    end
    factor_arr=reshape(factor_arr,fftSize,1);
    Xk=fft(xn);
    Yk=factor_arr.*Xk;
end