
clc

Month = 5;

if Month == 4
    filename = 'Input_images/All_area_April_MLTch__184_185_20210411_20210416_3857Pseudo.TIF';
end
if Month == 5
    filename = 'Input_images/Allarea_May_MLTch_184_186_3587Pseudo.tif';
end
disp([filename ' ...opening...'])

Tiff_obj = Tiff(filename);

Image_Data = read(Tiff_obj);

disp('file ready');

%%
clc
disp([filename ' ...start imaging...'])

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
    Image_part = Image_Data(2811:3560, 6879:7628, :);
end

figure
imagesc(Image_part(:,:,3));
% set(gca,'ColorScale','log')
caxis([100 1000])
axis equal
colormap gray


%% Image part reshape and CLASSIFY
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
[Label_out, ~] = classify(Forest_net_01, Line_4D);
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


Category(1) = "Вырубка";
Color(1, :) = [138 119 14]/255;

Category(2) = "Болото";
Color(2, :) = [35 56 30]/255;

Category(3) = "Лес_лист";
Color(3, :) = [55 255 15]/255;

Category(4) = "Лес_иголки";
Color(4, :) = [68 143 3]/255;

Category(5) = "Поля";
Color(5, :) = [200 200 0]/255;

Category(6) = "Что-то еще";
Color(6, :) = [0 0 0]/255;

Category(7) = "Вода";
Color(7, :) = [13 105 224]/255;

Category(8) = "Антропоген";
Color(8, :) = [130 130 130]/255;

Category(9) = "Похерено";
Color(9, :) = [180 0 0]/255;

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
axis equal

figure
imshow( 3*Image_part(:,:,3)./max(Image_part(:,:,3),[],'all') )
axis equal



figure
for i = 1:numel(Category)
    
text(0.1, 0.0 + 0.1*i, Category(i), 'color', Color(i, :))

end





















