
%% Get data
clc
load('DEF_May_Dens.mat');


Where_is_nan = isnan(Pixel);
[row, col] =find(Where_is_nan);
row = unique(row);

Pixel(row, :) = [];
Density_rel(row, :) = [];

clearvars col row Where_is_nan

%% Make 4D vector
Pixel = permute(Pixel, [2, 1]);
Pixel(:, :, 2, 2) = 0;
Pixel = permute(Pixel, [3, 1, 4, 2]);
Pixel(2, :, :, :) = [];
Pixel(:, :, 2, :) = [];



%% Create Layers for Net

Layers = [
    imageInputLayer([1 9 1],"Name","imageinput","Normalization","none")
    
    fullyConnectedLayer(256,"Name","fc1_1")
    leakyReluLayer(0.01,"Name","leakyrelu_1")
    
    fullyConnectedLayer(512,"Name","fc1_2")
    leakyReluLayer(0.01,"Name","leakyrelu_2")
    
    fullyConnectedLayer(1024,"Name","fc1_3")
    leakyReluLayer(0.01,"Name","leakyrelu_3")
    
    fullyConnectedLayer(256,"Name","fc2")
    reluLayer("Name","relu")
    
    fullyConnectedLayer(1,"Name","fc")
    leakyReluLayer(0.01,"Name","leakyrelu")
    
    regressionLayer("Name","regressionoutput")];


%% Prepare training data

Size = size(Pixel, 4);
Indexes = randperm(Size);

Pixel_Shuffle = Pixel(:, :, :, Indexes);
Density_rel_Shuffle = Density_rel(Indexes, :);


X_train = Pixel_Shuffle(:, :, :, 2501:end);
Y_train = Density_rel_Shuffle(2501:end);

X_Validation = Pixel_Shuffle(:, :, :, 1:2500);
Y_Validation = Density_rel_Shuffle(1:2500);


clearvars Pixel_Shuffle Density_rel_Shuffle Size Indexes


%% Train network

addpath('../')

clc

miniBatchSize  = 500;
validationFrequency = 200;
Pptions = trainingOptions('adam', ...
    'MiniBatchSize', miniBatchSize, ...
    'MaxEpochs', 5000, ...
    'InitialLearnRate', 1e-2, ...
    'LearnRateSchedule', 'piecewise', ...
    'LearnRateDropFactor', 0.98, ...
    'LearnRateDropPeriod', 3, ...
    'Shuffle', 'every-epoch', ...
    'ValidationData', {X_Validation, Y_Validation}, ...
    'ValidationFrequency', validationFrequency, ...
    'Plots', 'training-progress', ...
    'Verbose', false, ...
    'ExecutionEnvironment', 'auto', ...
    'OutputFcn', @(x)makeLogVertAx(x, 2));


Dens_Net_01 = trainNetwork(X_train, Y_train, Layers, Pptions);

clearvars miniBatchSize Pptions validationFrequency

%% clear training data

clearvars X_train Y_train X_Validation Y_Validation



%% check simple

clc
N = 1200;

Value = predict(Dens_Net_01, Pixel(1,:,1,N));
Value_true = Density_rel(N);

disp([num2str(N) ': ' num2str(Value_true) ' -> ' num2str(Value) newline]);

clearvars Value Value_true N

%% check all

Values = predict(Dens_Net_01, Pixel(1,:,1,:));



% clearvars Values

plot(Density_rel, Values, 'x');
xlim([0 1])
ylim([0 1])



%% Image load

clc

filename = '../Input_images/Allarea_May_MLTch_184_186_3587Pseudo.tif';
disp([filename ' ...opening...'])

Tiff_obj = Tiff(filename);

Image_Data = read(Tiff_obj);

disp('file ready');

%% Look at image
clc
disp([filename ' ...start imaging...'])

imagesc(Image_Data(:,:,3));
% set(gca,'ColorScale','log')
caxis([200 1000])
axis equal
colormap gray

disp('image ready');


%% Get Image part

% Image_part = Image_Data(8657:9456, 9787:10586, :);
Image_part = Image_Data(8097:8467, 9935:10305, :);

figure
imagesc(Image_part(:,:,3));
% set(gca,'ColorScale','log')
caxis([200 1000])
axis equal
colormap gray



%% Image part reshape and PREDICT
clc

Reshape_size = [size(Image_part,1)*size(Image_part,2), size(Image_part,3)];
Initial_size = [size(Image_part, 1), size(Image_part, 2)];

Image_part_line = reshape(Image_part, Reshape_size);

Line_4D = Image_part_line';
Line_4D(:, :, 2, 2) = 0;
Line_4D = permute(Line_4D, [3, 1, 4, 2]);
Line_4D(2, :, :, :) = [];
Line_4D(:, :, 2, :) = [];

tic;
Values_out = predict(Dens_Net_01, Line_4D);
time = toc;
disp(['Elapsed time: ' num2str(time) ' s'])

Image_result = reshape(Values_out, Initial_size);

%% image chop

Image_result(Image_result<0) = 0;
Image_result(Image_result>1) = 1;


%% Create image
clc

Image_R = zeros(size(Image_result,1), size(Image_result,2));
Image_G = zeros(size(Image_result,1), size(Image_result,2));
Image_B = zeros(size(Image_result,1), size(Image_result,2));

Trig_value = mean(Image_result, 'all')/2;

Image_R = Image_result<Trig_value;
Image_G = Image_result>=Trig_value;
Image_B = 0;


Image_RGB = [];
Image_RGB(:,:,1) = Image_R;
Image_RGB(:,:,2) = Image_G;
Image_RGB(:,:,3) = Image_B;

clearvars Image_R Image_G Image_B

%% Look at result

figure
imshow(Image_RGB)
axis equal

figure
imshow( 3*Image_part(:,:,3)./max(Image_part(:,:,3),[],'all') )
axis equal
























