function rate = nn(trData,teData)

m=size(trData,1);
n=size(teData,1);

for test=1:n
    for train=1:m        
        Euc(train)=norm(trData(train,1:end-1)-teData(test,1:end-1));
    end
    [~,index]=min(Euc);
    predict(test)=trData(index,end);
end

actual=teData(:,end);
rate=100*sum(actual==predict')/n;



