function Yf=dft(yk,N)
for k=1:N
    sum=0;
    for i=1:N
        sum=sum+yk(i)*exp(-j*2*pi*k*i/N);
    end
    Yf(k)=sum;
end
Yf=Yf';
end