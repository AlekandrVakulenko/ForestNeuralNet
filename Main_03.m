
clc

Month = 4;

if Month == 4
    filename = 'Input_images/All_area_April_MLTch__184_185_20210411_20210416_3857Pseudo.TIF';
%     filename = 'Input_images/output/All_area_April_OUT.TIF';
end
if Month == 5
    filename = 'Input_images/Allarea_May_MLTch_184_186_3587Pseudo.tif';
end
if Month == 6
    filename = 'Input_images/Allarea_MLTch_June_183_184_185_3587Pseudo.tif';
end


disp(['Opening:' newline filename])

Tiff_obj = Tiff(filename);

Image_Data = read(Tiff_obj);

disp('file ready');

%%
clc
disp(['Start imaging:' newline filename ])

imagesc(Image_Data(:,:,3));
% set(gca,'ColorScale','log')
caxis([100 1000])
axis equal
colormap gray

disp('image ready');


%% Get Image part

if Month == 5
%     Image_part = Image_Data(8097:8467, 9935:10305, :);
    Image_part = Image_Data(8034:8754, 9786:10506, :);
end
if Month == 4
%     Image_part = Image_Data(2811:3560, 6879:7628, :);
    Image_part = Image_Data(2611:3760, 6300:7828, :);
%       Image_part = Image_Data(9156:9880, 5495:6149, :);
end
if Month == 6
%     Image_part = Image_Data(2811:3560, 6879:7628, :);
    Image_part = Image_Data(2611:3760, 5800:7228, :);
%       Image_part = Image_Data(9156:9880, 5495:6149, :);
end

figure
imagesc(Image_part(:,:,3));
% set(gca,'ColorScale','log')
caxis([100 1000])
axis equal
colormap gray


%% Image part reshape and CLASSIFY
clc
Target_net = Humidity_net_V3_02;
% Target_net = Forest_net_V3_02;
% Target_net = Density_net_DEF_V3_01;
% Target_net = Density_net_HIP_V3_01;

Reshape_size = [size(Image_part,1)*size(Image_part,2), size(Image_part,3)];
Initial_size = [size(Image_part, 1), size(Image_part, 2)];

Image_part_line = reshape(Image_part, Reshape_size);

Line_4D = Image_part_line';
Line_4D(:, :, 2, 2) = 0;
Line_4D = permute(Line_4D, [3, 1, 4, 2]);
Line_4D(2, :, :, :) = [];
Line_4D(:, :, 2, :) = [];

disp(['Start classifying:' newline filename ]);
tic;
[Label_out, ~] = classify(Target_net, Line_4D);
time = toc;
disp(['Elapsed time: ' num2str(time) ' s'])

Image_result = reshape(Label_out, Initial_size);



%%
clc

Unique_cats = unique(Image_result)


%%
clc

Category = "";
Color = [];


% Category(2) = "Болото";
% Color(2, :) = [120 20 30]/255;
% 
% Category(1) = "Вырубка";
% Color(1, :) = [138 119 14]/255;
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
% Category(7) = "Сухой или свежий сосняк";
% Color(7, :) = [55 200 10]/255;
% 
% Category(8) = "Увлажненный сосняк";
% Color(8, :) = [34 70 0]/255;
% 
% Category(9) = "Сухой или свежий лиственный лес";
% Color(9, :) = [55 200 10]/255;
% 
% Category(10) = "Увлажненный лиственный лес";
% Color(10, :) = [55 200 10]/255;
% 
% Category(11) = "Сухой или свежий ельник";
% Color(11, :) = [34 70 0]/255;
% 
% Category(12) = "Увлажненный ельник";
% Color(12, :) = [34 70 0]/255;



Category(1) = "-";
Color(1, :) = [0 0 0]/255;

Category(1) = "Недостаточное увлажнение";
Color(1, :) = [20 20 20]/255;

Category(2) = "Умеренное увлажнение";
Color(2, :) = [120 120 40]/255;

Category(3) = "Избыточное увлажнение";
Color(3, :) = [30 220 30]/255;



% Category(1) = "zero";
% Color(1, :) = [20 20 20]/255;
% 
% Category(2) = "low";
% Color(2, :) = [100 100 20]/255;
% 
% Category(3) = "high";
% Color(3, :) = [30 220 30]/255;


Image_R = zeros(size(Image_result,1), size(Image_result,2));
Image_G = zeros(size(Image_result,1), size(Image_result,2));
Image_B = zeros(size(Image_result,1), size(Image_result,2));

for i = 1:numel(Category)
    Range = Image_result == Category(i);
    Image_R(Range) = Color(i, 1);
    Image_G(Range) = Color(i, 2);
    Image_B(Range) = Color(i, 3);
end

Image_RGB = [];
Image_RGB(:,:,1) = Image_R;
Image_RGB(:,:,2) = Image_G;
Image_RGB(:,:,3) = Image_B;

clearvars Image_R Image_G Image_B

%%
figure
imshow(Image_RGB)
% imshow(Image_RGB_conv)
axis equal

figure
imshow( 3*Image_part(:,:,3)./max(Image_part(:,:,3),[],'all') )
axis equal



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


















