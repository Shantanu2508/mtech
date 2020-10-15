function [decoded_bpsk]=decide_bpsk(y,c)
x1=c(1);
x2=c(2);
for i=1:length(y)
    d1=abs(y(i)-x1);
    d2=abs(y(i)-x2);
    if d1>d2 
        decoded_bpsk(i)=x2;
    end
    if d1<d2
        decoded_bpsk(i)=x1;
    end
end
end