function Rxx=correlation(x,N)
A=zeros(N,N);
for i=1:length(x)
    A(:,i)=[zeros(i-1,1)' x(1:N-i+1)']';
end
X=A(:,1);
Rxx=A'*X;
Rxx=[Rxx(N:-1:2)' Rxx']';
end