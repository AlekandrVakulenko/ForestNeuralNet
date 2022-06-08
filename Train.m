



Size = size(Pixel, 4);
Indexes = randperm(Size);

Pixel_Shuffle = Pixel(:, :, :, Indexes);
Orig_category_biot_Shuffle = Orig_category_biot(Indexes, :);


X_train = Pixel_Shuffle(:, :, :, 2501:end);
Y_train = Orig_category_biot_Shuffle(2501:end);

X_Validation = Pixel_Shuffle(:, :, :, 1:2500);
Y_Validation = Orig_category_biot_Shuffle(1:2500);


%%
clc

miniBatchSize  = 100;
validationFrequency = 200;
Pptions = trainingOptions('adam', ...
    'MiniBatchSize', miniBatchSize, ...
    'MaxEpochs', 5000, ...
    'InitialLearnRate', 1e-3, ...
    'LearnRateSchedule', 'piecewise', ...
    'LearnRateDropFactor', 0.99, ...
    'LearnRateDropPeriod', 3, ...
    'Shuffle', 'every-epoch', ...
    'ValidationData', {X_Validation, Y_Validation}, ...
    'ValidationFrequency', validationFrequency, ...
    'Plots', 'training-progress', ...
    'Verbose', false, ...
    'ExecutionEnvironment', 'auto', ...
    'OutputFcn', @(x)makeLogVertAx(x, 1));


BGnet_06_may = trainNetwork(X_train, Y_train, Layers, Pptions)
%SAVE BGnet_05 AS 5 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

%%

clc
N = 17;

[Label, Scores] = classify(BGnet, Pixel(1,:,1,N));
Label_true = Orig_category_biot(N);

disp([num2str(N) ':' newline char(Label_true) newline ' -> ' newline char(Label) newline])

%% vectorize
clc
[Label, Scores] = classify(BGnet, Pixel(1,:,1,1:1000));
double(Label)

%%
clc

Range = Orig_category_biot == "6.1_Лес_березняк";
% Range = Orig_category_biot == "8.1_Поля";

Indexes = find(Range);

Pixel_part = Pixel(1,:,1,Indexes);

k=0;
Label = "";
% Label_true = "";
for i = 1:numel(Indexes)

    ind = Indexes(i);
    
[Label_out, ~] = classify(BGnet_06_may, Pixel(1,:,1,ind));
Label_true_out = Orig_category_biot(ind);

if Label_out ~= Label_true_out
    k=k+1;
    Label(k, 1) = Label_true_out;
    Label(k, 2) = Label_out;
    flag = "ERROR";
else
    flag = "OK";
end
    disp([num2str(i) '/' num2str(numel(Indexes)) ' ' char(flag)])
end






















