

%% 111

clc
folder_input = 'Input_images/';
folder_output = 'Input_images/output/';
filename_input = 'All_area_April_MLTch__184_185_20210411_20210416_3857Pseudo.TIF';
filename_output = 'All_area_April_OUT.TIF';

Tiff_obj_input = Tiff([folder_input filename_input]);
Tiff_obj_output = Tiff([folder_output filename_output], 'r+');
Image_file_Data = read(Tiff_obj_input);
close(Tiff_obj_input)
disp('ready 1')

clearvars folder_input filename_input Tiff_obj_input

%% 222

Image_file_Data(:,:,1) = single(Image_Data_biot);
Image_file_Data(:,:,2) = single(Image_Data_dens_all_01);
Image_file_Data(:,:,3) = single(Image_Data_dens_all_02);
Image_file_Data(:,:,4) = single(Image_Data_dens_DEF_01);
Image_file_Data(:,:,5) = single(Image_Data_dens_HIP_01);
Image_file_Data(:,:,6) = 6;
Image_file_Data(:,:,7) = 7;
Image_file_Data(:,:,8) = 8;
Image_file_Data(:,:,9) = 9;

disp('ready 3')
%% 333
clc

write(Tiff_obj_output, Image_file_Data);
disp('ready 4')

close(Tiff_obj_output)
disp('ready 5')









%%

clc

Cats = categories(Image_Data_dens)

ans = Image_Data_dens(6000, :);

range = ans == "Болото";

ans = ans(range);

% single(ans(1))

Cats(:, 2) = Cats(:, 1);
for i = 1:size(Cats, 1)
    Cats{i, 1} = i;    
end

Cats




