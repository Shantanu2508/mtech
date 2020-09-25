function [sqent_out,sqen_bit_out,sqen_out]=encode(sq_out,qlevel,L)
partition=qlevel(1:L-1);
codebook=[0:L-1];
[Index,sqen_out]=quantiz(sq_out,partition,codebook);
sqen_bit_out=de2bi(sqen_out);
k=1;
for i=1:size(sqen_bit_out,1)
    for j=1:size(sqen_bit_out,2)
        sqent_out(k)=sqen_bit_out(i,j);
        k=k+1;
    end
end
end