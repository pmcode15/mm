function avg_accuracy=nFoldCV(data,n)

x=data(:,end-1);
y=data(:,end);

cv=cvpartition(size(x,1),'KFold',n);

for i=1:n
    trData=[x(training(cv,i),:),y(training(cv,i))];
    teData=[x(test(cv,i),:),y(test(cv,i))];

    accuracies(i)=nn(trData,teData);
    fprintf('%.2f%%\n',accuracies(i)*100);
end

avg_accuracy=mean(accuracies);
disp(avg_accuracy);