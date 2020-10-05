function [y]=decision_qam16(x,d)
for i=1:length(x)
    
    %1st quadrant
    if real(x(i))>d && imag(x(i))>d
        y(i)=3+j*3;
    end
    if real(x(i)) >0 && real(x(i))<=d && imag(x(i))>d
     y(i)=1+j*3;
    end
    if real(x(i))>0 && real(x(i))<=d && imag(x(i))<=d && imag(x(i))>0
        y(i)=1+j*1;
    end
    if real(x(i))>d && imag(x(i))<=d && imag(x(i))>0
        y(i)=3+j*1;
    end
    
   %second quadrant
   if real(x(i))<=-d && imag(x(i))>d
        y(i)=-3+j*3;
    end
    if real(x(i))<=-d && imag(x(i))<=d && imag(x(i))>0
     y(i)=-3+j*1;
    end
    if real(x(i))>-d && real(x(i))<0 && imag(x(i))<=d && imag(x(i))>0
        y(i)=-1+j*1;
    end
    if real(x(i))>-d && real(x(i))<0 && imag(x(i))>d
        y(i)=-1+j*3;
    end
    
    %third quadrant
    if real(x(i))<=-d && imag(x(i))>-d && imag(x(i)) < 0
        y(i)=-3-j*1;
    end
    if real(x(i))<=-d && imag(x(i))<=-d
     y(i)=-3-j*3;
    end
    if real(x(i))>-d && real(x(i))<0 && imag(x(i))<=-d
        y(i)=-1-j*3;
    end
    if real(x(i))>-d && real(x(i))<0 && imag(x(i))>-d && imag(x(i))<0
        y(i)=-1-j*1;
    end
    
    %fourth quadrant
    if real(x(i))>d && imag(x(i))<=-d
        y(i)=3-j*3;
    end
    if real(x(i)) >0 && real(x(i))<=d && imag(x(i))>-d && imag(x(i)) < 0
     y(i)=1-j*1;
    end
    if real(x(i))>0 && real(x(i))<=d && imag(x(i))<=-d 
        y(i)=1-j*3;
    end
    if real(x(i))>d && imag(x(i))<=0 && imag(x(i))>-d
        y(i)=3-j*1;
    end
    end
end