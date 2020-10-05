function [y]=decision_bpsk(x,d1,d2)
threshold=(d1+d2)/2;
for i=1:length(x)
    if x(i)>threshold
        y(i)=1+j*0;
    end
    if x(i)<threshold
        y(i)=-1+j*0;
    end
end
end