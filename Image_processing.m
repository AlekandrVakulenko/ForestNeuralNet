
clc

filename = 'Input_images/Allarea_May_MLTch_184_186_3587Pseudo.tif';
disp([filename ' ...opening...'])

Tiff_obj = Tiff(filename);

Image_Data = read(Tiff_obj);

disp('file ready');

%%
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


%% Image part reshape (TESTING)
clc

Image_test = [];
Image_test(:,:,1) = [111,121,131; 211, 221, 231; 311, 321,331];
Image_test(:,:,2) = [112,122,132; 212, 222, 232; 312, 322,332];
Image_test(:,:,3) = [113,123,133; 213, 223, 233; 313, 323,333];
Image_test(:,:,4) = [114,124,134; 214, 224, 234; 314, 324,334];

Reshape_size = [size(Image_test,1)*size(Image_test,2), size(Image_test,3)];
Initial_size = [size(Image_test)];

Image_part_line = reshape(Image_test, Reshape_size);
Image_result = reshape(Image_part_line, Initial_size);


Line_4D = Image_part_line';
Line_4D(:, :, 2, 2) = 0;
Line_4D = permute(Line_4D, [3, 1, 4, 2]);
Line_4D(2, :, :, :) = [];
Line_4D(:, :, 2, :) = [];

Image_result
Image_part_line
Line_4D

clearvars Image_test Reshape_size Initial_size Image_part_line Image_result Line_4D


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
[Label_out, ~] = classify(BGnet_06_may, Line_4D);
time = toc;
disp(['Elapsed time: ' num2str(time) ' s'])

Image_result = reshape(Label_out, Initial_size);



%% some testing
clc

Line_4D(:, :, :, 1:4)
Image_part(1:2, 1, :)

%%
clc

Unique_cats = unique(Image_result)
% unique(double(Image_result))

Replace_list.from(1) = "3.2_Вырубка <5 лет";
Replace_list.to(1)   = "Вырубка";

Replace_list.from(2) = "3.3_Вырубка 5-10 лет";
Replace_list.to(2)   = "Вырубка";

Replace_list.from(3) = "3.4_Вырубка 10-20 лет";
Replace_list.to(3)   = "Вырубка";

Replace_list.from(4) = "3.1_Свежая вырубка";
Replace_list.to(4)   = "Вырубка";

Replace_list.from(5) = "1_Верховое болото";
Replace_list.to(5)   = "Болото";

Replace_list.from(6) = "2_Переходное болото";
Replace_list.to(6)   = "Болото";

Replace_list.from(7) = "5.1_Гарь";
Replace_list.to(7)   = "Похерено";

Replace_list.from(8) = "5.2_Погибшее насаждение";
Replace_list.to(8)   = "Похерено";

Replace_list.from(9) = "7_ЛЭП/Газопровод";
Replace_list.to(9)   = "ЛЭП/Газопровод";

Replace_list.from(10) = "4_Нелесохозяйственные молодняки";
Replace_list.to(10)   = "Че-то странное";

Replace_list.from(11) = "6.2_Редина";
Replace_list.to(11)   = "Че-то странное";

Replace_list.from(12) = "6.3_Пойменный лес";
Replace_list.to(12)   = "Лес";

Replace_list.from(13) = "8.1_Поля";
Replace_list.to(13)   = "Поля";

Replace_list.from(14) = "6.1_Лес_березняк";
Replace_list.to(14)   = "Березы";

Replace_list.from(15) = "6.1_Лес_ельник";
Replace_list.to(15)   = "Елки";

Replace_list.from(16) = "6.1_Лес_осинник";
Replace_list.to(16)   = "Лес";

Replace_list.from(17) = "6.1_Лес_сероольшанник";
Replace_list.to(17)   = "Лес";

Replace_list.from(18) = "6.1_Лес_сосняк";
Replace_list.to(18)   = "Сосны";

Replace_list.from(19) = "6.1_Лес_черноольшанник";
Replace_list.to(19)   = "Лес";

% Replace_list.from(1) = "Че-то странное";
% Replace_list.to(1)   = "Лес";
% 
% Replace_list.from(2) = "Похерено";
% Replace_list.to(2)   = "Лес";
% 
% Replace_list.from(3) = "Березы";
% Replace_list.to(3)   = "Лес";
% 
% Replace_list.from(4) = "Елки";
% Replace_list.to(4)   = "Лес";
% 
% Replace_list.from(5) = "Сосны";
% Replace_list.to(5)   = "Лес";

for i = 1:numel(Replace_list.from)
    Range = Image_result == Replace_list.from(i);
    Image_result(Range) = Replace_list.to(i);
    Image_result = removecats(Image_result, Replace_list.from(i));
end

Unique_cats = unique(Image_result)

%%
clc

Category = "";
Color = [];

% Category(1) = "Вырубка";
% Color(1, :) = [90 70 10]/255;
% 
% Category(2) = "Болото";
% Color(2, :) = [20 50 35]/255;
% 
% Category(3) = "Похерено";
% Color(3, :) = [0 0 0]/255;
% 
% Category(4) = "ЛЭП/Газопровод";
% Color(4, :) = [255 20 160]/255;
% 
% Category(5) = "Че-то странное";
% Color(5, :) = [220 175 201]/255;
% 
% Category(6) = "Лес";
% Color(6, :) = [10 255 40]/255;
% 
% Category(7) = "Поля";
% Color(7, :) = [240 228 5]/255;
% 
% Category(8) = "Березы";
% Color(8, :) = [22 219 196]/255;
% 
% Category(9) = "Елки";
% Color(9, :) = [14 82 13]/255;
% 
% Category(10) = "Сосны";
% Color(10, :) = [112 153 64]/255;


Category(1) = "Вырубка";
Color(1, :) = [90 70 10]/255;

Category(2) = "Болото";
Color(2, :) = [20 50 35]/255;

Category(4) = "ЛЭП/Газопровод";
Color(4, :) = [255 20 160]/255;

Category(6) = "Лес";
Color(6, :) = [10 255 40]/255;

Category(7) = "Поля";
Color(7, :) = [240 228 5]/255;



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





















