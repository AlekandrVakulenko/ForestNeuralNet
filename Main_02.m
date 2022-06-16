
clc
load('MAIN_DATA.mat')
clearvars Density_rel Humidity Table_type

Pixel_pre = Satellite(:, :, 3);

Where_is_nan = isnan(Pixel_pre);
[row, col] =find(Where_is_nan);
row = unique(row);

Pixel_pre(row, :) = [];
Orig_category_biot(row) = [];

Pixel_pre = permute(Pixel_pre, [2, 1]);

% Pixel(1, :, :) = Pixel_pre;
Pixel_pre_2 = Pixel_pre;
Pixel_pre_2(:, :, 2, 2) = 0;
Pixel_pre_2 = permute(Pixel_pre_2, [3, 1, 4, 2]);
Pixel_pre_2(2, :, :, :) = [];
Pixel_pre_2(:, :, 2, :) = [];

Pixel = Pixel_pre_2;

clearvars ans ch1 ch2 ch3 ch4 ch5 ch6 ch7 ch8 ch9 row col Where_is_nan Pixel_pre Pixel_pre_2
clearvars Satellite
%%
clc
Category_U = unique(Orig_category_biot)
categories(Orig_category_biot)
% clearvars Category_U
clearvars ans
%%

Replace_list.from(1) = "6.1_Лес_березняк-кисличник";
Replace_list.to(1)   = "6.1_Лес_березняк";
Replace_list.from(2) = "6.1_Лес_березняк-приручейный";
Replace_list.to(2)   = "6.1_Лес_березняк";
Replace_list.from(3) = "6.1_Лес_березняк-разнотравный";
Replace_list.to(3)   = "6.1_Лес_березняк";
Replace_list.from(4) = "6.1_Лес_березняк-сфагново-кустарничковый";
Replace_list.to(4)   = "6.1_Лес_березняк";
Replace_list.from(5) = "6.1_Лес_березняк-сфагново-травяный";
Replace_list.to(5)   = "6.1_Лес_березняк";
Replace_list.from(6) = "6.1_Лес_березняк-сфагновый";
Replace_list.to(6)   = "6.1_Лес_березняк";
Replace_list.from(7) = "6.1_Лес_березняк-черничник";
Replace_list.to(7)   = "6.1_Лес_березняк";

Replace_list.from(8) = "6.1_Лес_ельник-брусничник";
Replace_list.to(8)   = "6.1_Лес_ельник";
Replace_list.from(9) = "6.1_Лес_ельник-кисличник";
Replace_list.to(9)   = "6.1_Лес_ельник";
Replace_list.from(10) = "6.1_Лес_ельник-приручейный";
Replace_list.to(10)   = "6.1_Лес_ельник";
Replace_list.from(11) = "6.1_Лес_ельник-разнотравный";
Replace_list.to(11)   = "6.1_Лес_ельник";
Replace_list.from(12) = "6.1_Лес_ельник-сфагново-кустарничковый";
Replace_list.to(12)   = "6.1_Лес_ельник";
Replace_list.from(13) = "6.1_Лес_ельник-сфагново-травяный";
Replace_list.to(13)   = "6.1_Лес_ельник";
Replace_list.from(14) = "6.1_Лес_ельник-сфагновый";
Replace_list.to(14)   = "6.1_Лес_ельник";
Replace_list.from(15) = "6.1_Лес_ельник-черничник";
Replace_list.to(15)   = "6.1_Лес_ельник";

Replace_list.from(16) = "6.1_Лес_осинник-кисличник";
Replace_list.to(16)   = "6.1_Лес_осинник";
Replace_list.from(17) = "6.1_Лес_осинник-разнотравный";
Replace_list.to(17)   = "6.1_Лес_осинник";
Replace_list.from(18) = "6.1_Лес_осинник-черничник";
Replace_list.to(18)   = "6.1_Лес_осинник";

Replace_list.from(19) = "6.1_Лес_сероольшанник-кисличник";
Replace_list.to(19)   = "6.1_Лес_сероольшанник";
Replace_list.from(20) = "6.1_Лес_сероольшанник-разнотравный";
Replace_list.to(20)   = "6.1_Лес_сероольшанник";

Replace_list.from(21) = "6.1_Лес_сосняк-брусничник";
Replace_list.to(21)   = "6.1_Лес_сосняк";
Replace_list.from(22) = "6.1_Лес_сосняк-кисличник";
Replace_list.to(22)   = "6.1_Лес_сосняк";
Replace_list.from(23) = "6.1_Лес_сосняк-сфагново-кустарничковый";
Replace_list.to(23)   = "6.1_Лес_сосняк";
Replace_list.from(24) = "6.1_Лес_сосняк-сфагновый";
Replace_list.to(24)   = "6.1_Лес_сосняк";
Replace_list.from(25) = "6.1_Лес_сосняк-черничник";
Replace_list.to(25)   = "6.1_Лес_сосняк";

Replace_list.from(26) = "6.1_Лес_черноольшанник-приручейный";
Replace_list.to(26)   = "6.1_Лес_черноольшанник";
Replace_list.from(27) = "6.1_Лес_черноольшанник-разнотравный";
Replace_list.to(27)   = "6.1_Лес_черноольшанник";
Replace_list.from(28) = "6.1_Лес_черноольшанник-сфагновый";
Replace_list.to(28)   = "6.1_Лес_черноольшанник";

Replace_list.from(29) = "3.1_Свежая вырубка";
Replace_list.to(29)   = "Вырубка";
Replace_list.from(30) = "3.2_Вырубка <5 лет";
Replace_list.to(30)   = "Вырубка";
Replace_list.from(31) = "3.3_Вырубка 5-10 лет";
Replace_list.to(31)   = "Вырубка";
Replace_list.from(32) = "3.4_Вырубка 10-20 лет";
Replace_list.to(32)   = "Вырубка";

Replace_list.from(33) = "1_Верховое болото ";
Replace_list.to(33)   = "Болото";
Replace_list.from(34) = "2_Переходное болото ";
Replace_list.to(34)   = "Вырубка";


Replace_list.from(35) = "6.1_Лес_березняк";
Replace_list.to(35)   = "Лес_лист";
Replace_list.from(36) = "6.1_Лес_осинник";
Replace_list.to(36)   = "Лес_лист";
Replace_list.from(37) = "6.1_Лес_сероольшанник";
Replace_list.to(37)   = "Лес_лист";
Replace_list.from(38) = "6.1_Лес_черноольшанник";
Replace_list.to(38)   = "Лес_лист";

Replace_list.from(39) = "6.1_Лес_ивняк-разнотравный";
Replace_list.to(39)   = "Лес_лист";
Replace_list.from(40) = "6.1_Лес_осинник-сфагновый";
Replace_list.to(40)   = "Лес_лист";
Replace_list.from(41) = "6.1_Лес_широколиственный-разнотравный";
Replace_list.to(41)   = "Лес_лист";

Replace_list.from(42) = "6.1_Лес_сосняк-беломошник";
Replace_list.to(42)   = "Лес_иголки";
Replace_list.from(43) = "6.1_Лес_сосняк-разнотравный";
Replace_list.to(43)   = "Лес_иголки";
Replace_list.from(44) = "6.1_Лес_сосняк-сфагново-травяный";
Replace_list.to(44)   = "Лес_иголки";
Replace_list.from(45) = "6.1_Лес_ельник";
Replace_list.to(45)   = "Лес_иголки";
Replace_list.from(46) = "6.1_Лес_сосняк";
Replace_list.to(46)   = "Лес_иголки";

Replace_list.from(47) = "5.1_Гарь";
Replace_list.to(47)   = "Похерено";
Replace_list.from(48) = "5.2_Погибшее насаждение";
Replace_list.to(48)   = "Похерено";


Replace_list.from(49) = "8.1_Поля";
Replace_list.to(49)   = "Поля";
Replace_list.from(50) = "7_ЛЭП/Газопровод";
Replace_list.to(50)   = "ЛЭП/Газопровод";

Replace_list.from(51) = "4_Нелесохозяйственные молодняки";
Replace_list.to(51)   = "Что-то еще";
Replace_list.from(52) = "6.2_Редина";
Replace_list.to(52)   = "Что-то еще";
Replace_list.from(53) = "6.3_Пойменный лес";
Replace_list.to(53)   = "Что-то еще";
Replace_list.from(54) = "8.2_Пойменные луга";
Replace_list.to(54)   = "Что-то еще";

Replace_list.from(55) = "10_Водный объект";
Replace_list.to(55)   = "Вода";
Replace_list.from(56) = "11_Антропоген";
Replace_list.to(56)   = "Антропоген";

Replace_list.from(57) = "ЛЭП/Газопровод";
Replace_list.to(57)   = "Вырубка";

for i = 1:numel(Replace_list.from)
    
    Range = Orig_category_biot == Replace_list.from(i);
    Orig_category_biot(Range) = Replace_list.to(i);
    
    Orig_category_biot = removecats(Orig_category_biot, Replace_list.from(i));
    
end

Orig_category_biot = removecats(Orig_category_biot, 'Orig_category_biot');

clearvars i Replace_list Range

%%
clc
%FIXME: add classes number by unique()

Layers_1 = [
    imageInputLayer([1 9 1],"Name","imageinput","Normalization","none")
    
    fullyConnectedLayer(256,"Name","fc_1")
    leakyReluLayer(0.01,"Name","leakyrelu_1")
    
    fullyConnectedLayer(512,"Name","fc_2")
    leakyReluLayer(0.01,"Name","leakyrelu_2")
    
    fullyConnectedLayer(1024,"Name","fc_3")
    leakyReluLayer(0.01,"Name","leakyrelu_3")
    
    fullyConnectedLayer(256,"Name","fc_4")
    reluLayer("Name","relu_4")
    
    fullyConnectedLayer(9,"Name","fc_5")
    
    softmaxLayer("Name","softmax")
    classificationLayer("Name","classoutput")];

Layers_2 = [
    imageInputLayer([1 9 1],"Name","imageinput","Normalization","none")
    
    fullyConnectedLayer(400,"Name","fc_1")
    leakyReluLayer(0.01,"Name","leakyrelu_1")
    
    fullyConnectedLayer(700,"Name","fc_2")
    leakyReluLayer(0.01,"Name","leakyrelu_2")
    
    fullyConnectedLayer(1300,"Name","fc_3")
    leakyReluLayer(0.01,"Name","leakyrelu_3")
    
    fullyConnectedLayer(320,"Name","fc_4")
    reluLayer("Name","relu_4")
    
    fullyConnectedLayer(9,"Name","fc_5")
    
    softmaxLayer("Name","softmax")
    classificationLayer("Name","classoutput")];


Layers = Layers_2;

Classification_Layer = Layers(end);
Classification_Layer.Classes = unique(Orig_category_biot);
Layers(end) = Classification_Layer;

clearvars Classification_Layer Layers_1 Layers_2

%%

Size = size(Pixel, 4);
Indexes = randperm(Size);

Pixel_Shuffle = Pixel(:, :, :, Indexes);
Orig_category_biot_Shuffle = Orig_category_biot(Indexes, :);


X_train = Pixel_Shuffle(:, :, :, 2001:end);
Y_train = Orig_category_biot_Shuffle(2001:end);

X_Validation = Pixel_Shuffle(:, :, :, 1:2000);
Y_Validation = Orig_category_biot_Shuffle(1:2000);

clearvars Size Indexes Pixel_Shuffle Orig_category_biot_Shuffle
%%
clc


Pptions = trainingOptions('adam', ...
    'MiniBatchSize', 250, ...
    'MaxEpochs', 5000, ...
    'InitialLearnRate', 1e-2, ...
    'LearnRateSchedule', 'piecewise', ...
    'LearnRateDropFactor', 0.97, ...
    'LearnRateDropPeriod', 3, ...
    'Shuffle', 'every-epoch', ...
    'ValidationData', {X_Validation, Y_Validation}, ...
    'ValidationFrequency', 200, ...
    'Plots', 'training-progress', ...
    'Verbose', false, ...
    'ExecutionEnvironment', 'auto', ...
    'OutputFcn', @(x)makeLogVertAx(x, 1));


Forest_net_01 = trainNetwork(X_train, Y_train, Layers, Pptions);

clearvars Pptions
%%

clearvars X_train Y_train X_Validation Y_Validation

%%
clc
Category_U

%%
clc

% Range = Orig_category_biot == "Вырубка";
% Range = Orig_category_biot == "Лес_лист";
% Range = Orig_category_biot == "Лес_иголки";
% Range = Orig_category_biot == "Похерено";
% Range = Orig_category_biot == "Поля";
% Range = Orig_category_biot == "ЛЭП/Газопровод";
% Range = Orig_category_biot == "Что-то еще";
% Range = Orig_category_biot == "Вода";
Range = Orig_category_biot == "Антропоген";


Indexes = find(Range);

Pixel_part = Pixel(1,:,1,Indexes);

k = 0;
Label = "";
% Label_true = "";
for i = 1:numel(Indexes)

    ind = Indexes(i);
    
[Label_out, ~] = classify(Forest_net_01, Pixel(1,:,1,ind));
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

Accuracy = 1 - size(Label,1) / size(Indexes,1);

disp([newline 'Accuracy:' num2str(round(Accuracy*1000)/10) '%']);













