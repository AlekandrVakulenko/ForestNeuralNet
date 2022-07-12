
% Target_net = Forest_net_01;
% Target_net = Density_net_all_01;
% Target_net = Density_net_all_02;
% Target_net = Density_net_HIP_01;
Target_net = Density_net_DEF_01;

Image_Data_output = categorical(-1*ones(size(Image_Data, [1 2])));

%%
clc

tic
Rows_count = size(Image_Data, 1);
for Row = 1:Rows_count
    disp(['Row: ' num2str(Row) '/' num2str(Rows_count)])
    
    Image_Row = squeeze(Image_Data(Row, :, :));
    
    Image_Row_sum = sum(Image_Row, 2);
    
    Classify_range = Image_Row_sum ~= 0;
    
    if ~isempty(find(Classify_range))
        Image_Row_non_zero = Image_Row(Classify_range, :);
        
        Output_line = categorical(-1*ones(size(Image_Row_sum)));
        
        Line_4D = Image_Row_non_zero';
        Line_4D(:, :, 2, 2) = 0;
        Line_4D = permute(Line_4D, [3, 1, 4, 2]);
        Line_4D(2, :, :, :) = [];
        Line_4D(:, :, 2, :) = [];
        % size(Line_4D)
         
        [Label_out, ~] = classify(Target_net, Line_4D);
        
        Output_line(Classify_range) = Label_out;
        
        Image_Data_output(Row, :) = Output_line;
    end
end
time = toc;
disp([newline 'Full time: ' num2str(time/60) ' m' newline])

%%

clearvars Reshape_size Initial_size Target_net Line_4D Label_out Image_part_line Image_Row
clearvars Image_Row_non_zero Classify_range Image_Row_sum Image_Row



%%

imagesc(double(Image_Data_output))
axis equal

%%
clc


Image_Categorical = Image_Data_output;

Unique_cats = unique(Image_Categorical)

%%

clc

Category = "";
Color = [];

% Category(1) = "Вырубка";
% Color(1, :) = [138 119 14]/255;
% 
% Category(2) = "Болото";
% Color(2, :) = [120 20 30]/255;
% 
% Category(3) = "Молодняк";
% Color(3, :) = [105 255 35]/255;
% 
% Category(4) = "Поля";
% Color(4, :) = [200 200 0]/255;
% 
% Category(5) = "Водный объект";
% Color(5, :) = [13 105 224]/255;
% 
% Category(6) = "Антропоген";
% Color(6, :) = [130 130 130]/255;
% 
% Category(7) = "Лиственный лес";
% Color(7, :) = [55 200 10]/255;
% 
% Category(8) = "Хвойный лес";
% Color(8, :) = [34 70 0]/255;
% 
% Category(9) = "-1";
% Color(9, :) = [0 0 0]/255;



Category(1) = "zero";
Color(1, :) = [20 20 20]/255;

Category(2) = "low";
Color(2, :) = [200 200 20]/255;

Category(3) = "high";
Color(3, :) = [30 220 30]/255;

Category(4) = "-1";
Color(4, :) = [0 0 0]/255;

Image_R = zeros(size(Image_Categorical,1), size(Image_Categorical,2));
Image_G = zeros(size(Image_Categorical,1), size(Image_Categorical,2));
Image_B = zeros(size(Image_Categorical,1), size(Image_Categorical,2));

for i = 1:numel(Category)
    i
    Range = Image_Categorical == Category(i);
    Image_R(Range) = Color(i, 1);
    Image_G(Range) = Color(i, 2);
    Image_B(Range) = Color(i, 3);
end

Image_RGB = [];
Image_RGB(:,:,1) = Image_R;
Image_RGB(:,:,2) = Image_G;
Image_RGB(:,:,3) = Image_B;

clearvars Image_R Image_G Image_B Range Image_Categorical

%%
figure
imshow(Image_RGB)
% imshow(Image_RGB_conv)
axis equal

% figure
% imshow( 3*Image_part(:,:,3)./max(Image_part(:,:,3),[],'all') )
% axis equal



figure
for i = 1:numel(Category)
    
text(0.1, 0.0 + 0.05*i, Category(i), 'color', Color(i, :))

end



%%

% Image_part_conv = Image_part;

N = 3;

Kernel = ones(N)/N^2;
Image_RGB_conv = [];
Image_RGB_conv(:,:,1) = conv2(Image_RGB(:,:,1), Kernel);
Image_RGB_conv(:,:,2) = conv2(Image_RGB(:,:,2), Kernel);
Image_RGB_conv(:,:,3) = conv2(Image_RGB(:,:,3), Kernel);





















