function [y] = BER(x1,x2)
z=x1~=x2;
count =0;
for i=1:length(z)
    if z(i)==1
        count=count+1;
    end
y=count;
end