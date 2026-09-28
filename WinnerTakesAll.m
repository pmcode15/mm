function accuracy = WinnerTakesAll(actual,predict,Classes)

% Using the Winner-Takes-All Strategy 

[m,n] = size(actual);
[maxp,classp] = max(predict,[],2);
accuracy = sum(actual(:,n)==Classes(classp)')/m;
% winner=mode(classp);

