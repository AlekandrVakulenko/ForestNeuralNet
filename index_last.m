clc

[~, hostname] = system('hostname');
hostname = strtrim(hostname);


switch hostname
    case 'MainHomePC'
        folder = 'E:\_OneDrive\OneDrive\';
end


cd([folder '_MATLAB\MAP_neural']);

edit([folder '_MATLAB\MAP_neural\Main_01.m'])
edit([folder '_MATLAB\MAP_neural\Main_02.m'])
edit([folder '_MATLAB\MAP_neural\Main_03.m'])
edit([folder '_MATLAB\MAP_neural\Main_04_fullmap.m'])
edit([folder '_MATLAB\MAP_neural\Try_to_save.m'])
edit([folder '_MATLAB\MAP_neural\save_big_map.m'])

clearvars