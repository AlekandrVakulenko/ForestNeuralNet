function [Pixel, Orig_category_biot_small, Density_rel, Humidity, Table_type] = ...
    histogram_cut(Pixel, Orig_category_biot_small, Density_rel, Humidity, Table_type, P_value)

clc
clearvars Orig_category_biot
Coeffs_out = [];
Density_rel_out = [];
Humidity_out = [];
Orig_category_biot_small_out = [];
Table_type_out = [];

Cats_unique = unique(Orig_category_biot_small);
Coeffs = squeeze(Pixel)';

clearvars Pixel

for current_cat_N = 1:numel(Cats_unique)
    current_cat = Cats_unique(current_cat_N);
    
    range = Orig_category_biot_small == current_cat;
    
    Coeffs_part = Coeffs(range, :);
    Density_rel_part = Density_rel(range);
    Humidity_part = Humidity(range);
    Category_part = Orig_category_biot_small(range);
    Table_type_part = Table_type(range);
    
%     P_value = 5;
    
    for N = 1:size(Coeffs_part, 2)
        Data = Coeffs_part(:, N);
        
        P_low = prctile(Data, P_value);
        P_high = prctile(Data, 100-P_value);
        
        if N == 1
            remove_range = (Data < P_low | Data > P_high);
        else
            remove_range = remove_range | (Data < P_low | Data > P_high);
        end
        %     Data(~stay_range) = [];
    end
    stay_range = ~remove_range;
    numel(find(stay_range));
    
    Coeffs_out = [Coeffs_out; Coeffs_part(stay_range, :)];
    Density_rel_out = [Density_rel_out; Density_rel_part(stay_range)];
    Humidity_out = [Humidity_out; Humidity_part(stay_range)];
    Orig_category_biot_small_out = [Orig_category_biot_small_out; Category_part(stay_range)];
    Table_type_out = [Table_type_out; Table_type_part(stay_range)];
end

Coeffs = Coeffs_out;
Density_rel = Density_rel_out;
Humidity = Humidity_out;
Orig_category_biot_small = Orig_category_biot_small_out;
Table_type = Table_type_out;
clearvars Coeffs_out Density_rel_out Humidity_out Orig_category_biot_small_out Table_type_out

Pixel = Coeffs';
Pixel(:, :, 2, 2) = 0;
Pixel = permute(Pixel, [3, 1, 4, 2]);
Pixel(2, :, :, :) = [];
Pixel(:, :, 2, :) = [];

clearvars Coeffs
clearvars range P_low P_high P_value N Data Part_cat current_cat_N current_cat
clearvars Coeffs_part Density_rel_part Humidity_part Category_part Table_type_part
clearvars stay_range remove_range Cats_unique ans


end