
% load('for_errors.mat')

% clearvars ans Table_type Months Humidity Density_rel


Original_data = Orig_category_biot_small;
Target_net = Forest_net_V3_03;

Net_output = classify(Target_net, Pixel);


%%
clc

Categories_in = categories(Original_data)
Categories_out = categories(Net_output)

if numel(Categories_in) == numel(Categories_out)
    Categories = Categories_in;
    clearvars Categories_in Categories_out
else
    clearvars Categories_in Categories_out
    error('error 1')
end

Error_mat = zeros(numel(Categories));
for i = 1:numel(Categories)
    clc
    range = Original_data == Categories{i};
    Prediction = Net_output(range);
    
    Row = [];
    for j = 1:numel(Categories)
        range = Prediction == Categories{j};
        Row(j) = numel(find(range))/numel(Prediction);
    end
    Error_mat(i, :) = Row;
end

Error_mat = round(Error_mat*10000)/100;


clearvars range Row Prediction


%%

imagesc(Error_mat)
colormap gray






%%

clc

load('Error_m03.mat')
disp(03)
disp(Error_mat)
trace(Error_mat)/8


load('Error_m04.mat')
disp(04)
disp(Error_mat)
trace(Error_mat)/8

load('Error_m05.mat')
disp(05)
disp(Error_mat)
trace(Error_mat)/8

















