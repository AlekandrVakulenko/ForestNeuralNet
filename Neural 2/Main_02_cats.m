
%% Get data
clc
load('DEF_May_Dens.mat');


Where_is_nan = isnan(Pixel);
[row, col] =find(Where_is_nan);
row = unique(row);

Pixel(row, :) = [];
Density_rel(row, :) = [];

Density_rel_round = round(Density_rel*4)/4;

Density_rel_cat = categorical(Density_rel_round);


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
    
    fullyConnectedLayer(300,"Name","fc_1")
    leakyReluLayer(0.01,"Name","leakyrelu_1")
    
    fullyConnectedLayer(600,"Name","fc_2")
    leakyReluLayer(0.01,"Name","leakyrelu_2")
    
    fullyConnectedLayer(1124,"Name","fc_3")
    leakyReluLayer(0.01,"Name","leakyrelu_3")
    
    fullyConnectedLayer(280,"Name","fc_4")
    reluLayer("Name","relu_4")
    
    fullyConnectedLayer(5,"Name","fc_5")
    
    softmaxLayer("Name","softmax")
    classificationLayer("Name","classoutput")];


%% Prepare training data

Size = size(Pixel, 4);
Indexes = randperm(Size);

Pixel_Shuffle = Pixel(:, :, :, Indexes);
Density_rel_cat_Shuffle = Density_rel_cat(Indexes, :);


X_train = Pixel_Shuffle(:, :, :, 2501:end);
Y_train = Density_rel_cat_Shuffle(2501:end);

X_Validation = Pixel_Shuffle(:, :, :, 1:2500);
Y_Validation = Density_rel_cat_Shuffle(1:2500);


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
    'OutputFcn', @(x)makeLogVertAx(x, 1));


Dens_Net_01 = trainNetwork(X_train, Y_train, Layers, Pptions);

clearvars miniBatchSize Pptions validationFrequency

%% clear training data

clearvars X_train Y_train X_Validation Y_Validation



%% check simple

clc
N = 6820;

Value_out = classify(Dens_Net_01, Pixel(1,:,1,N));
Value_out = double(string(Value_out));

Value_true = Density_rel_cat(N);
Value_true = double(string(Value_true));

disp([num2str(N) ': ' num2str(Value_true) ' -> ' num2str(Value_out) newline]);

clearvars Value Value_true N

%% check all

Values = classify(Dens_Net_01, Pixel(1,:,1,:));
Values = double(string(Values));

Value_true = Density_rel_cat(:);
Value_true = double(string(Value_true));

Cols = (Values*4+1);
Rows = (Value_true*4+1);

Mat = error_table(Rows, Cols)

imagesc((Mat))
colormap gray

% clearvars Values

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
Values_out = classify(Dens_Net_01, Line_4D);
time = toc;
disp(['Elapsed time: ' num2str(time) ' s'])

Values_out = double(string(Values_out));

Image_result = reshape(Values_out, Initial_size);


%% Create image
clc

Category(1) = 0;
Color(1, :) = [160 0 0]/255;

Category(2) = 0.25;
Color(2, :) = [225 225 0]/255;

Category(3) = 0.5;
Color(3, :) = [100 200 0]/255;

Category(4) = 0.75;
Color(4, :) = [0 255 0]/255;

Category(5) = 1;
Color(5, :) = [0 255 0]/255;



Image_R = zeros(size(Image_result,1), size(Image_result,2));
Image_G = zeros(size(Image_result,1), size(Image_result,2));
Image_B = zeros(size(Image_result,1), size(Image_result,2));

for i = 1:numel(Category)
    Range = Image_result == Category(i);
    numel(find(Range))
    Image_R(Range) = Color(i, 1);
    Image_G(Range) = Color(i, 2);
    Image_B(Range) = Color(i, 3);
end

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


figure
for i = 1:numel(Category)
    
text(0.1, 0.0 + 0.1*i, num2str(Category(i)), 'color', Color(i, :))

end



%% Image filtering

Kernel = ones(3);
Kernel = Kernel/sum(Kernel,'all');

Image_result_filt = conv2(Image_result, Kernel, 'same');

Image_result_filt = round(Image_result_filt*4)/4;

Image_R = zeros(size(Image_result_filt,1), size(Image_result_filt,2));
Image_G = zeros(size(Image_result_filt,1), size(Image_result_filt,2));
Image_B = zeros(size(Image_result_filt,1), size(Image_result_filt,2));

for i = 1:numel(Category)
    Range = Image_result_filt == Category(i);
    numel(find(Range))
    Image_R(Range) = Color(i, 1);
    Image_G(Range) = Color(i, 2);
    Image_B(Range) = Color(i, 3);
end

Image_RGB = [];
Image_RGB(:,:,1) = Image_R;
Image_RGB(:,:,2) = Image_G;
Image_RGB(:,:,3) = Image_B;

clearvars Image_R Image_G Image_B













