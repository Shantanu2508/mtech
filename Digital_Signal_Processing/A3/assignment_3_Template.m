%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Assignment : 03
% Course     : DSP Lab 2021
% 
% Details    : This file generates OFDM pulses with digital modulation 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc;

%% Inputs
baseFreq = 5;             % Base Frequency
symTime = 1/baseFreq;     % Symbol Time
totalSubcarr = 2;         % Total Subcarriers (Should be less than or equal to FFT size)
fftSize = 16;             % FFT Size (Should be non zero integer)

%% Generate random bits with uniform distribution 
%%Map the bits to BPSK and QPSK 
% no. of the symbols equals to no. of subcarrier in assignment 2.
bpsk_data=rand(totalSubcarr);
qpsk_data=rand(totalSubcarr,2);
x_bpsk=psk(bpsk_data,2,1);
x_qpsk=psk(qpsk_data,4,1);
%% Generation of OFDM pulses as in assignment 2

%% IDFT of OFDM signal using summation
% This section of the code takes the IDFT of the OFDM signal 




%% IDFT of OFDM signal using Matlab IFFT
% This section of the code takes the IFFT of the OFDM signal 

% Both the output (your IDFT and Matlab IFFT) output should exactly match



%% Plotting the spectrum of the signal
% This section plots the spectrum of the signal

% Spectrum of the signal should exactly match with the subcarriers you have
% taken in the input. 

% If the spectrum doesn't match for any specific case then you should
% mention that case along with the reasons

% Power of the all the frequency bins should be 1. And you should mentioned
% how you have done the power adjustment (if you have done it)

function X=psk(data,m,A)
%% BPSK
if (m==2)
    bpsk_const=A*[-1,1];
    [~,I]=sort(SquareDist(bpsk_const',data));
    idx=I(1,:);
    for i=1:length(data)
        X(i)=bpsk_const(:,idx(i));
    end
end
%% QPSK
if m==4
    qpsk_const=A*[[1;1],[-1;1],[-1;-1],[1;-1]];
    [~,I]=sort(SquareDist(qpsk_const',data));
    idx=I(1,:);
    for i=1:length(data)
        X(i)=qpsk_const(:,idx(i));
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