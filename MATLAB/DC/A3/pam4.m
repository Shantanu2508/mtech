function [pamout]=pam4(x,plevels)
k=1;
for i=1:300
    for j=1:2
        pamout(i,j)=x(k);
        k=k+1;
    end
end
pamout=bi2de(pamout);
codebook=[-3,-1,1,3];
partition=[0 1 2];
[index,pamout]=quantiz(pamout,partition,codebook);
end


