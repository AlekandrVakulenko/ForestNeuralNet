

%% 111

clc
folder_input = 'Input_images/';
folder_output = 'Input_images/output/';
filename_input = 'All_area_April_MLTch__184_185_20210411_20210416_3857Pseudo.TIF';
filename_output = 'All_area_April_OUT.TIF';

Tiff_obj_input = Tiff([folder_input filename_input]);
Image_Data_input = read(Tiff_obj_input);
close(Tiff_obj_input)
disp('ready')


%% 222 copy

status = copyfile([folder_input filename_input], [folder_output filename_output]);
disp('ready 2')

Tiff_obj_output = Tiff([folder_output filename_output], 'r+');
% Image_Data_input = read(Tiff_obj_input);

%% 333

Image_Data_output = Image_Data_input;
disp('ready 3')

%% 444
Size = size(Image_Data_output, [1 2]);

Image_Data_output(:,:,1) = 1;
Image_Data_output(:,:,2) = rand(Size)*1000;
Image_Data_output(:,:,3) = rand(Size)*0.01;
Image_Data_output(:,:,4) = 4;
Image_Data_output(:,:,5) = 5;
Image_Data_output(:,:,6) = 6;
Image_Data_output(:,:,7) = 7;
Image_Data_output(:,:,8) = Image_Data_output(:,:,8);
Image_Data_output(:,:,9) = Image_Data_output(:,:,9);


%%
setTag(Tiff_obj_output, 'SamplesPerPixel', 1)

%% 555
clc

write(Tiff_obj_output, Image_Data_output);
disp('ready 4')


%% 666

close(Tiff_obj_output)
disp('ready 5')





%%
getTag(Tiff_obj_input, 'SamplesPerPixel')



%%
 Tiff_obj_output.getTagNames 


%%



























