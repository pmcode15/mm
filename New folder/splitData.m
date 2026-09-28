function [trData,teData]=splitData(data)

[m,n]=size(data);
random=randperm(m);
data=data(random,:);


split=round(m*0.7);
trData=data(1:split,:);
teData=data(split+1:m,:);
