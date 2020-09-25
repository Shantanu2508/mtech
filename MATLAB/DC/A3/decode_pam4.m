function [decoded_pcm]= decode_pam4(x,levels,L)
x=reshape(x,length(x),1);
partition=levels(1:end-1);
codebook=[0:L-1];
[i,decoded_bit_pcm]=quantiz(x,partition,codebook);
decoded_bit_pcm=reshape(decoded_bit_pcm,length(decoded_bit_pcm),1);
decoded_bit_pcm=de2bi(decoded_bit_pcm);
k=1;
for i=1:size(decoded_bit_pcm,1)
    for j=1:size(decoded_bit_pcm,2)
        decoded_pcm(k)=decoded_bit_pcm(i,j);
        k=k+1;
    end
end
end