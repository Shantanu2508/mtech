function decoded_qpsk=decide_qpsk(y,c)
x1=c(1);
x2=c(2);
x3=c(3);
x4=c(4);
for i=1:length(y)
    d1=abs(y(i)-x1);
    d2=abs(y(i)-x2);
    d3=abs(y(i)-x3);
    d4=abs(y(i)-x4);
    mind=min([d1,d2,d3,d4]);
    if mind==d1 decoded_qpsk(i)=x1;
    end
    if mind==d2 decoded_qpsk(i)=x2;
    end
    if mind==d3 decoded_qpsk(i)=x3;
    end
    if mind==d4 decoded_qpsk(i)=x4;
    end
end
end