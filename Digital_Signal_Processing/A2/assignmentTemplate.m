%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Name       : Shantanu Yadav
% Roll No.   : EE20MTECH12001
% Assignment : 02
% Course     : DSP Lab 2021
% 
% Details    : This file generates OFDM pulses 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc;

%% Inputs:
baseFreq = 5;             % Base Frequency
symTime = 1/baseFreq;     % Symbol Time
totalSubcarr = 2;         % Total Subcarriers (Should be less than or equal to FFT size)
fftSize = 16;             % FFT Size (Should be non zero integer)

% Code should not take any other input other than the above ones
% Code should run for all the valid combinations of the inputs above

% Find out the sampling frequency of the signal
fs=fftSize*baseFreq;
%% Generation of OFDM pulses
% This section of the code generates 'totalSubcarr' OFDM pulses for a given 
% symbol time 'symTime'
Ton=(totalSubcarr*symTime)/fftSize;
Ts=1/fs;
t_i=0:Ts:Ts*(fftSize-1);t_i=t_i';

xk=ones(totalSubcarr,1);
xk=[xk' zeros(1,(fftSize-totalSubcarr))]'
xk=fftshift(xk);

figure(1);
stem(xk),title("Input Signal"),xlabel("n"),ylabel("xk");

%% DFT of OFDM signal using summation
% This section of the code takes the DFT of the OFDM signal 
s_i=idft(xk,fftSize);

%% DFT of OFDM signal using Matlab FFT
% This section of the code takes the FFT of the OFDM signal 

% Both the output (your DFT and Matlab FFT) output should exactly match
% You should explain why you have taken fftshift and what happens if you
% don't take it
%If fftshift is not used the N-fft algorithm (and dft algorithm) generates
%an output of size N with starting frequency to be 0 and the data is
%mirrored after N/2 samples i.e for any x between [0,N/2] the fft output
%has the property that fft_output(x)=fft_output(x+N/2). 
%By using fftshift it rearranges the output by shifting the zero-frequency
%compenent to the centre.

s_i2=ifft(xk,fftSize);

figure(2);
subplot(211),plot(t_i,abs(s_i)),title("IDFT"),xlabel("time(t)"),ylabel("s(t)");
subplot(212),plot(t_i,abs(s_i2)),title("IFFT"),xlabel("time(t)"),ylabel("s(t)");

%% Plotting the spectrum of the signal
% This section plots the spectrum of the signal
Xk=fft(s_i);
figure(3);
stem(Xk),title("DFT"),xlabel("N-values"),ylabel("Xk");

% Spectrum should exactly match the signal taken in the input. 

% If the spectrum doesn't match for any specific case then you should
% mention that case along with the reasons

% Power of the all the frequency bins should be 1. And you should mentioned
% how you have done the power adjustment (if you have done it)
%Power normalization is done by dividing ofdm signal vector
%by square root of power content of ofdm signal vector times the fftSize.

%% Function Definitions

function Yf=idft(yk,N)
for k=0:N-1
    sum=0;
    for i=0:N-1   
        sum=sum+yk(i+1)*exp(j*2*pi*k*i/N);
    end
    Yf(k+1)=sum;
end
Yf=Yf'/N;
end
