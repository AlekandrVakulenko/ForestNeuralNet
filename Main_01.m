
clc
addpath("_include")

disp(['Opening files' newline])

filename = "E:\_OneDrive\OneDrive\_MATLAB\MAP_neural\XLSX Input 2\TrainDEFsum.xlsx";
comment = 'DEF';

[Satellite_DEF, ...
 Orig_category_biot_DEF, ...
 Humidity_DEF, ...
 Density_rel_DEF, ...
 Months_DEF, ...
 Table_type_DEF] = open_tabel(filename, comment);

clearvars filename comment


filename = "E:\_OneDrive\OneDrive\_MATLAB\MAP_neural\XLSX Input 2\TrainHIPsum.xlsx";
comment = 'HIP';

[Satellite_HIP, ...
 Orig_category_biot_HIP, ...
 Humidity_HIP, ...
 Density_rel_HIP, ...
 Months_HIP, ...
 Table_type_HIP] = open_tabel(filename, comment);

clearvars filename comment


disp(['All files data ready' newline])


%% Tables concat

Satellite = [Satellite_DEF; Satellite_HIP];
clearvars Satellite_DEF Satellite_HIP

Orig_category_biot = [Orig_category_biot_DEF; Orig_category_biot_HIP];
clearvars Orig_category_biot_DEF Orig_category_biot_HIP

Humidity = [Humidity_DEF; Humidity_HIP];
clearvars Humidity_DEF Humidity_HIP

Density_rel = [Density_rel_DEF; Density_rel_HIP];
clearvars Density_rel_DEF Density_rel_HIP

Table_type = [Table_type_DEF; Table_type_HIP];
clearvars Table_type_DEF Table_type_HIP

Months = Months_HIP;
clearvars Months_DEF Months_HIP

% clearvars Months

%% Delete repeats
clc

disp('1) Data concatenation');
Satellite_line = [Satellite(:,:,1), Satellite(:,:,1), Satellite(:,:,1)];
Satellite_line(:, end+1) = double(Humidity);
Satellite_line(:, end+1) = double(Orig_category_biot);
Satellite_line(:, end+1) = Density_rel;


disp('2) Hash-sum computing ...');
Hash = string(zeros(size(Satellite_line, 1), 1));
tic
for i = 1:size(Satellite_line, 1)
    Hash(i) = DataHash(Satellite_line(i, :), 'HEX', 'MD5');
end
time = toc;
disp(['Passed time: ' num2str(round(time)) ' s']);

clearvars Satellite_line

%
range = false(numel(Hash), 1);

time_predict = numel(Hash)*120/70000;
disp('3) Comparison of repeated data');
disp(['Time prediction: ' num2str(round(time_predict)) ' s']);
disp('processing...');

tic
for i = 1:numel(Hash)-1
    range(i+1:end) = range(i+1:end) | (Hash(i) == Hash(i+1:end));
end
time = toc;
disp(['Passed time: ' num2str(round(time)) ' s']);

clearvars i A time_predict time Hash

%
disp('4) Erasing of repeated data');
Satellite(range, :, :) = [];
Orig_category_biot(range) = [];
Humidity(range) = [];
Density_rel(range) = [];
Table_type(range) = [];

clearvars range

disp('READY');


%FIXME: add NaN find

%FIMXE: remove TITLE cats like "Orig_category_biot"




%% Delete repeats VERSION 2
clc

disp('1) Data concatenation');
Satellite_line = [Satellite(:,:,1), Satellite(:,:,1), Satellite(:,:,1)];
Satellite_line(:, end+1) = double(Humidity);
Satellite_line(:, end+1) = double(Orig_category_biot);
Satellite_line(:, end+1) = Density_rel;


%
range = false(size(Satellite_line,1), 1);

time_predict = size(Satellite_line,1)*120/70000*2.66;
disp('3) Comparison of repeated data');
disp(['Time prediction: ' num2str(round(time_predict)) ' s']);
disp('processing...');

tic
for i = 1:size(Satellite_line,1)-1
    cond = sum(Satellite_line(i,:) == Satellite_line(i+1:end, :), 2) == size(Satellite_line, 2);
    range(i+1:end) = range(i+1:end) | cond;
end
time = toc;
disp(['Passed time: ' num2str(round(time)) ' s']);

clearvars i A time_predict time Hash

%
disp('4) Erasing of repeated data');
Satellite(range, :, :) = [];
Orig_category_biot(range) = [];
Humidity(range) = [];
Density_rel(range) = [];
Table_type(range) = [];

clearvars range

disp('READY');

clearvars Satellite_line

%FIXME: add NaN find

%FIMXE: remove TITLE cats like "Orig_category_biot"












