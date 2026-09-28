function rate=knn1(trData,teData);

m=size(trData,1);
n=size(teData,1);

predict=zeros(n,1);

for test=1:n
    Euc=zeros(m,1);
    for train=1:m
        Euc(train)=norm(trData(train,1:end-1)-teData(test,1:end-1));
    end
    [~,ind]=sort(Euc);
    nearest=ind(1:k);
    neNeigh=trData(nearest,end);
    majority=mode(neNeigh);
    predict(test)=majority;
end

actual=test(:,end);
rate=100*sum(predict==actual)/n;

     
