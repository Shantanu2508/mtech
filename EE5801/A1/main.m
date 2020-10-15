clc;
close;
clear;

L=100000;
%.........................................
%QPSK
ak=round(rand(L,2));
s=-2*ak(:,1)+1 + j*(-2*ak(:,2)+1);
qpsk_function(L,ak,s);
%...........................................
akbpsk=round(rand(L,1));
sbpsk=-2*akbpsk+1;
bpsk_function(L,akbpsk,sbpsk);
%............................................