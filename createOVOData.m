function ovoData = createOVOData(Data, class1, class2)



n = size(Data,2);


indices = (Data(:,n) == class1) | (Data(:,n) == class2);

ovoData = Data(indices,:);


indices1 = (ovoData(:,n) == class1);
ovoData(indices1,n) = 1;


indices2 = (ovoData(:,n) == class2);
ovoData(indices2,n) = -1;

end