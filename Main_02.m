%% 1111
clc
addpath('_include')
load('MAIN_DATA_V3.mat')
% clearvars Density_rel Humidity Table_type
Month_list = [3 4 5 6 7];

Month = 4;

Month_ind = find(Month_list == Month);
Pixel_pre = Satellite(:, :, Month_ind);

Where_is_nan = isnan(Pixel_pre);
[row, col] =find(Where_is_nan);
row = unique(row);

Pixel_pre(row, :) = [];
Density_rel(row) = [];
Humidity(row) = [];
Orig_category_biot(row) = [];
Table_type(row) = [];

% NormC = sum(Pixel_pre.^2, 2).^0.5;
% NormC = repmat(NormC, 1, 9);
% Pixel_pre = Pixel_pre./NormC;
% Pixel_pre(:, 10) = NormC(:, 1);

Pixel_pre = permute(Pixel_pre, [2, 1]);

Pixel_pre(:, :, 2, 2) = 0;
Pixel_pre = permute(Pixel_pre, [3, 1, 4, 2]);
Pixel_pre(2, :, :, :) = [];
Pixel_pre(:, :, 2, :) = [];

Pixel = Pixel_pre;

clearvars ans ch1 ch2 ch3 ch4 ch5 ch6 ch7 ch8 ch9 row col Where_is_nan Pixel_pre Pixel_pre_2
clearvars Satellite
clearvars Month_list Month Month_ind
%% look at cats
clc
Category_U = unique(Orig_category_biot)
categories(Orig_category_biot)
clearvars ans Category_U
%% Replace cats 2222
clc
profile_N = 4;

filename = "XLSX Input 2\Categories.xlsx";
Replace_list = load_replace_cells(filename);
Orig_category_biot_small = cat_union(Orig_category_biot, Replace_list, profile_N);

Orig_category_biot_small = removecats(Orig_category_biot_small, 'Orig_category_biot');

Cats_unique = unique(Orig_category_biot_small)

clearvars filename profile_N Replace_list
%% Create Net Layers
clc

% range = Table_type == "DEF";
range = Table_type == "HIP";
range = range | (Orig_category_biot_small == "Водный объект");
range = range | (Orig_category_biot_small == "Антропоген");
% range = Table_type == "DEF" | Table_type == "HIP";
Net_input = Pixel(:,:,:,range);
Net_target = Density_rel_cat(range);

% Net_target = Orig_category_biot_small;
% Net_input = Pixel;

Cats_unique = unique(Net_target);

Input_size = size(Net_input, 2);

Layers_1 = [
    imageInputLayer([1 Input_size 1],"Name","imageinput","Normalization","none")
    
    fullyConnectedLayer(256,"Name","fc_1")
    leakyReluLayer(0.01,"Name","leakyrelu_1")
    
    fullyConnectedLayer(512,"Name","fc_2")
    leakyReluLayer(0.01,"Name","leakyrelu_2")
    
    fullyConnectedLayer(1024,"Name","fc_3")
    leakyReluLayer(0.01,"Name","leakyrelu_3")
    
    fullyConnectedLayer(256,"Name","fc_4")
    reluLayer("Name","relu_4")
    
    fullyConnectedLayer(numel(Cats_unique),"Name","fc_5")
    
    softmaxLayer("Name","softmax")
    classificationLayer("Name","classoutput")];

Layers_2 = [
    imageInputLayer([1 Input_size 1],"Name","imageinput","Normalization","none")
    
    fullyConnectedLayer(400,"Name","fc_1")
    leakyReluLayer(0.01,"Name","leakyrelu_1")
    
    fullyConnectedLayer(700,"Name","fc_2")
    leakyReluLayer(0.01,"Name","leakyrelu_2")
    
    fullyConnectedLayer(1300,"Name","fc_3")
    leakyReluLayer(0.01,"Name","leakyrelu_3")
    
    fullyConnectedLayer(320,"Name","fc_4")
    reluLayer("Name","relu_4")
    
    fullyConnectedLayer(numel(Cats_unique),"Name","fc_5")
    
    softmaxLayer("Name","softmax")
    classificationLayer("Name","classoutput")];

Layers_3 = [
    imageInputLayer([1 Input_size 1],"Name","imageinput","Normalization","none")
    
    fullyConnectedLayer(50,"Name","fc_1")
    leakyReluLayer(0.01,"Name","leakyrelu_1")
    
    fullyConnectedLayer(100,"Name","fc_2")
    leakyReluLayer(0.01,"Name","leakyrelu_2")
    
    fullyConnectedLayer(200,"Name","fc_3")
    leakyReluLayer(0.01,"Name","leakyrelu_3")
    
    fullyConnectedLayer(80,"Name","fc_4")
    reluLayer("Name","relu_4")
    
    fullyConnectedLayer(numel(Cats_unique),"Name","fc_5")
    
    softmaxLayer("Name","softmax")
    classificationLayer("Name","classoutput")];

Layers_4 = [
    imageInputLayer([1 Input_size 1],"Name","imageinput","Normalization","none")
    
    fullyConnectedLayer(20,"Name","fc_1")
    leakyReluLayer(0.01,"Name","leakyrelu_1")
    
    fullyConnectedLayer(40,"Name","fc_2")
    leakyReluLayer(0.01,"Name","leakyrelu_2")
    
    fullyConnectedLayer(50,"Name","fc_3")
    leakyReluLayer(0.01,"Name","leakyrelu_3")
    
    fullyConnectedLayer(50,"Name","fc_4")
    reluLayer("Name","relu_4")
    
    fullyConnectedLayer(numel(Cats_unique),"Name","fc_5")
    
    softmaxLayer("Name","softmax")
    classificationLayer("Name","classoutput")];

Layers = Layers_1;

Classification_Layer = Layers(end);
Classification_Layer.Classes = unique(Net_target);
Layers(end) = Classification_Layer;

clearvars Classification_Layer Input_size
clearvars Layers_1 Layers_2 Layers_3

%%
% Orig_category_biot_small = Orig_category_biot_small_BU;
% Pixel = Pixel_BU;
% Orig_category_biot_small_BU = Orig_category_biot_small;
% Pixel_BU = Pixel;
Delete_ind = randperm(3800) + 6717; %2800 4800
Net_target(Delete_ind) = [];
Net_input(:, :, :, Delete_ind) = [];

Delete_ind = randperm(1000) + 4257; %2000
Net_target(Delete_ind) = [];
Net_input(:, :, :, Delete_ind) = [];

%%
Size = size(Net_input, 4);
Indexes = randperm(Size);

Val_part = 3500;

X_train_Shuffle = Net_input(:, :, :, Indexes);
Y_train_Shuffle = Net_target(Indexes, :);


X_train = X_train_Shuffle(:, :, :, Val_part+1:end);
Y_train = Y_train_Shuffle(Val_part+1:end);

X_Validation = X_train_Shuffle(:, :, :, 1:Val_part);
Y_Validation = Y_train_Shuffle(1:Val_part);

clearvars Size Indexes
% clearvars Pixel_Shuffle Orig_category_biot_Shuffle

%% new training set shuffle (no)

% hold on
% plot(double(Orig_category_biot_small))
% plot(squeeze(Pixel(1,9,1,:))'*2000)

plot(Y_Validation)

% plot(Y_train)

%%
clc


Pptions = trainingOptions('adam', ...
    'MiniBatchSize', 1000, ...
    'MaxEpochs', 40000, ...
    'InitialLearnRate', 5e-3, ...
    'LearnRateSchedule', 'piecewise', ...
    'LearnRateDropFactor', 0.97, ...
    'LearnRateDropPeriod', 15, ...
    'Shuffle', 'every-epoch', ...
    'ValidationData', {X_Validation, Y_Validation}, ...
    'ValidationFrequency', 200, ...
    'Plots', 'training-progress', ...
    'Verbose', false, ...
    'ExecutionEnvironment', 'auto');

% 'OutputFcn', @(x)makeLogVertAx(x, 1)

% Forest_net_V3_01 = trainNetwork(X_train, Y_train, Layers, Pptions);
Density_net_HIP_V3_01 = trainNetwork(X_train, Y_train, Layers, Pptions);


clearvars Pptions
%%

clearvars X_train Y_train X_Validation Y_Validation

%%
clc
% Category_U
Cats_unique

%%
clc
% Dataset_in = Pixel;
% Dataset_out = Orig_category_biot_small;
Dataset_in = X_Validation;
Dataset_out = Y_Validation;
% Dataset_in = X_train;
% Dataset_out = Y_train;

Test_net = Forest_net_V3_01;
% Test_net = Density_net_01;

% Range = Dataset_out == "Лиственный сухой лес";
% Range = Dataset_out == "Лиственный влажный лес";
% Range = Dataset_out == "Хвойный сухой лес";
% Range = Dataset_out == "Хвойный влажный лес";

% Range = Dataset_out == "Лиственный лес";
% Range = Dataset_out == "Хвойный лес";
% Range = Dataset_out == "Болото";
% Range = Dataset_out == "Вырубка";
% Range = Dataset_out == "Лес";
% Range = Dataset_out == "Поля";
% Range = Dataset_out == "Водный объект";
% Range = Dataset_out == "Антропоген";

% Range = Dataset_out == "zero";
% Range = Dataset_out == "low";
% Range = Dataset_out == "mid";
% Range = Dataset_out == "high";

Indexes = find(Range);

% Pixel_part = Pixel(1,:,1,Indexes);

k = 0;
Label = "";
% Label_true = "";
for i = 1:numel(Indexes)

    ind = Indexes(i);
    
[Label_out, scores] = classify(Test_net, Dataset_in(1,:,1,ind));
Label_true_out = Dataset_out(ind);

if Label_out ~= Label_true_out
    k=k+1;
    Label(k, 1) = Label_true_out;
    Label(k, 2) = Label_out;
    flag = "ERROR";
else
    flag = "OK    ";
end
    disp([num2str(i) '/' num2str(numel(Indexes)) ' ' char(flag) '    ' char(Label_out) '   ' num2str(scores)])
end

Accuracy = 1 - size(Label,1) / size(Indexes,1);

disp([newline 'Accuracy:' num2str(round(Accuracy*1000)/10) '%']);

clearvars Test_net

%%
clc
% Category_U
Cats_unique

%% histogram cut 3333
clc
clearvars Orig_category_biot
Coeffs_out = [];
Density_rel_out = [];
Humidity_out = [];
Orig_category_biot_small_out = [];
Table_type_out = [];


Cats_unique = unique(Orig_category_biot_small);
Coeffs = squeeze(Pixel)';

clearvars Pixel

for current_cat_N = 1:numel(Cats_unique)
    current_cat = Cats_unique(current_cat_N)
    % range = Orig_category_biot_small == "Лиственный лес";
    % range = Orig_category_biot_small == "Хвойный лес";
    % range = Orig_category_biot_small == "Молодняк";
    
    % range = Orig_category_biot_small == "Болото";
    % range = Orig_category_biot_small == "Вырубка";
    % range = Orig_category_biot_small == "Лес";
    % range = Orig_category_biot_small == "Поля";
    % range = Orig_category_biot_small == "Водный объект";
    % range = Orig_category_biot_small == "Антропоген";
    
    range = Orig_category_biot_small == current_cat;
    
    Coeffs_part = Coeffs(range, :);
    Density_rel_part = Density_rel(range);
    Humidity_part = Humidity(range);
    Category_part = Orig_category_biot_small(range);
    Table_type_part = Table_type(range);
    
    P_value = 5;
    
    for N = 1:size(Coeffs_part, 2)
        Data = Coeffs_part(:, N);
        
        P_low = prctile(Data, P_value);
        P_high = prctile(Data, 100-P_value);
        
        if N == 1
            remove_range = (Data < P_low | Data > P_high);
        else
            remove_range = remove_range | (Data < P_low | Data > P_high);
        end
        %     Data(~stay_range) = [];
        
%         figure
%         hold on
%         histogram(Data, 100)
%         xline(P_low)
%         xline(P_high)
%         title(num2str(N))
        %     set(gca, 'yscale', 'log')
        
    end
    stay_range = ~remove_range;
    numel(find(stay_range))
    
    Coeffs_out = [Coeffs_out; Coeffs_part(stay_range, :)];
    Density_rel_out = [Density_rel_out; Density_rel_part(stay_range)];
    Humidity_out = [Humidity_out; Humidity_part(stay_range)];
    Orig_category_biot_small_out = [Orig_category_biot_small_out; Category_part(stay_range)];
    Table_type_out = [Table_type_out; Table_type_part(stay_range)];
    
    
end

Coeffs = Coeffs_out;
Density_rel = Density_rel_out;
Humidity = Humidity_out;
Orig_category_biot_small = Orig_category_biot_small_out;
Table_type = Table_type_out;
clearvars Coeffs_out Density_rel_out Humidity_out Orig_category_biot_small_out Table_type_out


Pixel = Coeffs';
Pixel(:, :, 2, 2) = 0;
Pixel = permute(Pixel, [3, 1, 4, 2]);
Pixel(2, :, :, :) = [];
Pixel(:, :, 2, :) = [];


clearvars Coeffs
clearvars range P_low P_high P_value N Data Part_cat current_cat_N current_cat
clearvars Coeffs_part Density_rel_part Humidity_part Category_part Table_type_part
clearvars stay_range remove_range Cats_unique ans

%% 4444
clc

Density_rel_cat = categorical("");

range = Density_rel == 0;
Density_rel_cat(range) = categorical("zero");

range = Density_rel > 0 & Density_rel <= 0.125;
Density_rel_cat(range) = categorical("low");

range = Density_rel > 0.125;
Density_rel_cat(range) = categorical("high");

Density_rel_cat = Density_rel_cat';


%%
clc

% range = Orig_category_biot_small == "Лиственный лес";
% range = Orig_category_biot_small == "Хвойный лес";
% range = Orig_category_biot_small == "Молодняк";

% range = Orig_category_biot_small == "Болото";
% range = Orig_category_biot_small == "Вырубка";
% range = Orig_category_biot_small == "Лес";
% range = Orig_category_biot_small == "Поля";
% range = Orig_category_biot_small == "Водный объект";
range = Orig_category_biot_small == "Антропоген";


Coeffs_part = Coeffs(range, :);

P_value = 5;


for N = 1:size(Coeffs_part, 2)
    Data = Coeffs_part(:, N);

    figure
    hold on
    histogram(Data, 100)
    title(num2str(N))
    set(gca, 'yscale', 'log')
    
end



clearvars range P_low P_high P_value N Data Part_cat current_cat_N current_cat range Coeffs_part








