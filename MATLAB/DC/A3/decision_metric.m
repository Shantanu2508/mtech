function [y]=decision_metric(x,levels)
for i =1:length(x)
    minerr=(x(i)-levels(1))^2;
    minerr_index=1;
    for j=1:length(levels)
        err=(x(i)-levels(j))^2;
        if minerr > err
            minerr=err;
            minerr_index = j;
        end
    y(i)=levels(minerr_index);
end
end