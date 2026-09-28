function accuracy = OVOVoting(actual,predict,Classes)

[m,n] = size(actual);

numClasses = length(Classes);

correct = 0;

for i = 1:m

    votes = zeros(1,numClasses);

    for j = 1:n

        if predict(i,j) == 1
            votes(j) = votes(j) + 1;

        else
            votes(j+1) = votes(j+1) + 1;
        end

    end

    [~,winner] = max(votes);

    if actual(i,end) == Classes(winner)
        correct = correct + 1;
    end

end

accuracy = correct / m;

end