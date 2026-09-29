load fisheriris

x=meas;
y=species;

cv=cvpartition(y,'HoldOut',0.3);
xtrain=x(training(cv),:);
xtest=x(test(cv),:);
ytrain=y(training(cv),:);
ytest=y(test(cv),:);

model=fitcknn(xtrain,ytrain,'NumNeighbors',3);
ypred=predict(model,xtest);

acc=100*sum(strcmp(ypred,ytest))/numel(ytest);
fprintf("Accuracy:%.2f%%",acc);

%%%%%%%%%%%%
load fisheriris

x=meas;
y=species;

cv=cvpartition(y,'Holdout',0.3);
xtrain=x(training(cv),:);
xtest=x(test(cv),:);
ytrain=y(training(cv),:);
ytest=y(test(cv),:);

knum=[1,3,5];

for i=1:length(knum)
    k=knum(i);
    model=fitcknn(xtrain,ytrain,'NumNeighbors',k);
    ypred=predict(model,xtest);
    acc=100*sum(strcmp(ypred,ytest))/numel(ytest);
    fprintf("Accuracy:%.2f%%",acc);
end


%%%%%%%%%%%%
load fisheriris

x=meas;
y=species;

cv=cvpartition(y,'Holdout',0.3);
xtrain=x(training(cv),:);
xtest=x(test(cv),:);
ytrain=y(training(cv),:);
ytest=y(test(cv),:);

kernels={'linear','ploynomial','rbf'};
accuracy=zeros(length(kernels),1)

for i=1:length(kernels)
    kernel=kernels{i};
    svm=templateSVM('KernelFunction',kernel);
    model=fitcecoc(xtrain,ytrain,'Learners',svm);
    ypred=predict(model,xtest);
    accuracy(i)=100*sum(ypred==ytest)/numel(ytest);
    fprintf("Accuracy:%.2f%%",acc);
end

%%%%%
svm = templateSVM('KernelFunction','linear');

model = fitcecoc(xtrain, ytrain, ...
    'Learners', svm, ...
    'Coding', 'onevsone');
%%%%%%%
model=fitctree(xtrain,ytrain);

%%%%%%%
data = {

    'sunny', 'warm', 'normal', 'strong', 'warm', 'same', 'yes';

    'sunny', 'warm', 'high', 'strong', 'warm', 'same', 'yes';

    'rainy', 'cold', 'high', 'strong', 'warm', 'change', 'no';

    'sunny', 'warm', 'high', 'strong', 'cool', 'change', 'yes'

};

[m,n] = size(data);

n = n - 1;

hypo = cell(1,n);

for i = 1:m

    if strcmp(data{i,end},'yes')

        if isempty(hypo{1})

            for j = 1:n
                hypo{j} = data{i,j};
            end

        else

            for j = 1:n

                if ~strcmp(hypo{j},data{i,j})
                    hypo{j} = '?';
                end

            end

        end

    end

end

disp(hypo);

%%%%
load fisheriris
X = meas;
y = species;
% Train Decision Tree
TreeMdl = fitctree(X, y);
% visualise
view(TreeMdl, 'Mode', 'graph')
% Predict & evaluate
ypred = predict(TreeMdl, X);
% Random Forest (Ensemble Bagged Trees)
RF_Mdl = fitcensemble(X, y, 'Method', 'Bag');
ypred_rf = predict(RF_Mdl, X);


%%%

load fisheriris
X = meas;
Y = species;
nFolds = 5;
cv = cvpartition(Y, 'KFold', nFolds);
accuracy = zeros(nFolds,1);
for i = 1:nFolds

    % Training and test indices
    trainIdx = training(cv, i);
    testIdx = test(cv, i);

    % Train kNN model
    model = fitcknn(X(trainIdx,:), Y(trainIdx), 'NumNeighbors', 5);
    % Prediction
    predictions = categorical(predict(model, X(testIdx,:)));

    % Evaluation
    accuracy(i) = sum(predictions == Y(testIdx)) / numel(predictions);
    fprintf('Fold %d Accuracy: %.2f%%\n', i, accuracy(i)*100);
end
% Overall performance
fprintf('\nAverage accuracy across %d folds: %.2f%%\n', nFolds,
mean(accuracy)*100);

model = fitcsvm(X(trainIdx,:), Y(trainIdx), 'KernelFunction', 'linear'); 


          
             
          
   