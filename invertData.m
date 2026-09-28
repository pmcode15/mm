function invData= invertData(Data,class)

% This function is used to invert the +1 Class and -1 Classes 

invData=Data;
n=size(invData,2);

%****************** Class-first ******************************

indices=(invData(:,n)==class);
invData(indices,n)=1;

%****************** Class-last *******************************

ind= ~indices;
invData(ind,n)=-1;

%*************************************************************



