load carbig

% Create table
tbl = table(Horsepower, Weight, Acceleration, Cylinders, MPG);

% View first 5 rows
head(tbl,5);

% Summary
summary(tbl);

% Count missing values
sum(ismissing(tbl));

% Remove rows containing missing values
clean_tbl = rmmissing(tbl);

% Select numerical features
x = clean_tbl{:, {'Horsepower','Weight','Acceleration'}};

% Normalize features to range [0,1]
x_norm = normalize(x, 'range');

% Standardize features (mean = 0, std = 1)
x_std = zscore(x);

% Histograms
figure;

subplot(1,3,1);
histogram(x(:,1));
title('Original');

subplot(1,3,2);
histogram(x_norm(:,1));
title('Normalized');

subplot(1,3,3);
histogram(x_std(:,1));
title('Standardized');

% Convert Cylinders to categorical
clean_tbl.Cylinders = categorical(clean_tbl.Cylinders);

% One-hot encode Cylinders
cyl_encoded = dummyvar(clean_tbl.Cylinders);

% Combine standardized numerical features + encoded cylinders
x_final = [x_std cyl_encoded];

% Correlation with MPG
corrVals = corr( ...
    clean_tbl{:, {'Horsepower','Weight','Acceleration'}}, ...
    clean_tbl.MPG, ...
    'Rows','complete');

disp('Correlation of features with MPG:');

disp(array2table(corrVals, ...
    'VariableNames', {'Correlation'}, ...
    'RowNames', {'Horsepower','Weight','Acceleration'}));