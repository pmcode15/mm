function accuracy = OVOSVMs(data,N)

[trainData,teData] = splitData(data);

[trData,valData] = splitData(trainData);

A = 1:N;

Pairs = [];

for class1 = 1:N-1
    for class2 = class1+1:N
        Pairs = [Pairs; class1 class2];
    end
end

C = [2^-10 2^-9 2^-8 2^-7 2^-6 2^-5 2^-4 ...
     2^-3 2^-2 2^-1 2^0 2^1 2^2 2^3 2^4 ...
     2^5 2^6 2^7 2^8 2^9 2^10];

accuracy = [];

for i = 1:length(C)

    options = svmlopt('C',C(i),'Verbosity',0);

    predict = [];

    for pair = 1:size(Pairs,1)

        class1 = Pairs(pair,1);
        class2 = Pairs(pair,2);

        Model = ['Model',int2str(class1),'Vs',int2str(class2)];

        x = createOVOData(trData,class1,class2);

        y = x(:,end);
        x(:,end) = [];

        svmlwrite('SVMLTrain',x,y);

        svm_learn(options,'SVMLTrain',Model);

        clear SVMLTrain x y;

        xval = createOVOData(valData,class1,class2);

        yval = xval(:,end);
        xval(:,end) = [];

        svmlwrite('SVMLVal',xval,yval);

        ModelOutput = ['ModelOutput', ...
                       int2str(class1),'Vs',int2str(class2)];

        svm_classify(options,'SVMLVal',Model,ModelOutput);

        svmpredict = svmlread(ModelOutput);

        predict = [predict,svmpredict];

    end

    accuracy(i) = OVOVoting(valData,predict,Pairs,A);

end

[elt,ind] = max(accuracy);

cOpt = C(ind);

options = svmlopt('C',cOpt,'Verbosity',0);

predict = [];

for pair = 1:size(Pairs,1)

    class1 = Pairs(pair,1);
    class2 = Pairs(pair,2);

    Model = ['Model',int2str(class1),'Vs',int2str(class2)];

    x = createOVOData(trData,class1,class2);

    y = x(:,end);
    x(:,end) = [];

    svmlwrite('SVMLTrain',x,y);

    svm_learn(options,'SVMLTrain',Model);

    xtest = createOVOData(teData,class1,class2);

    ytest = xtest(:,end);
    xtest(:,end) = [];

    svmlwrite('SVMLTest',xtest,ytest);

    ModelOutput = ['ModelOutput', ...
                   int2str(class1),'Vs',int2str(class2)];

    svm_classify(options,'SVMLTest',Model,ModelOutput);

    svmpredict = svmlread(ModelOutput);

    predict = [predict,svmpredict];

end

accuracy = OVOVoting(teData,predict,Pairs,A);

end