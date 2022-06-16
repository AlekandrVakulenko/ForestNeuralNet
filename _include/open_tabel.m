

function [Satellite, Orig_category_biot, Humidity, Density_rel, Months, Table_type] = open_tabel(filename, comment)
disp(['Opening <' char(filename) '>'])

comment = string(comment);

opts = spreadsheetImportOptions("NumVariables", 72);

% Specify sheet and range
opts.Sheet = "Лист1";
opts.DataRange = "A:BT";

% Specify column names and types
opts.VariableNames = ["Var1", "Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var8", "Var9", "Var10", "Var11", "Var12", "Var13", "Var14", "Var15", "Var16", "Var17", "Var18", "Var19", "Var20", "Var21", "Var22", "Orig_category_biot", "Var24", "Var25", "Var26", "Var27", "Var28", "Var29", "Var30", "Var31", "Var32", "Var33", "Var34", "Var35", "Var36", "Var37", "Wet", "Var39", "Var40", "Var41", "Var42", "Var43", "Plot_otnos", "Var45", "ch_3_1", "ch_3_2", "ch_3_3", "ch_3_4", "ch_3_5", "ch_3_6", "ch_3_7", "ch_3_8", "ch_3_9", "ch_4_1", "ch_4_2", "ch_4_3", "ch_4_4", "ch_4_5", "ch_4_6", "ch_4_7", "ch_4_8", "ch_4_9", "ch_5_1", "ch_5_2", "ch_5_3", "ch_5_4", "ch_5_5", "ch_5_6", "ch_5_7", "ch_5_8", "ch_5_9"];
opts.SelectedVariableNames = ["Orig_category_biot", "Wet", "Plot_otnos", "ch_3_1", "ch_3_2", "ch_3_3", "ch_3_4", "ch_3_5", "ch_3_6", "ch_3_7", "ch_3_8", "ch_3_9", "ch_4_1", "ch_4_2", "ch_4_3", "ch_4_4", "ch_4_5", "ch_4_6", "ch_4_7", "ch_4_8", "ch_4_9", "ch_5_1", "ch_5_2", "ch_5_3", "ch_5_4", "ch_5_5", "ch_5_6", "ch_5_7", "ch_5_8", "ch_5_9"];
opts.VariableTypes = ["char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "categorical", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "char", "categorical", "char", "char", "char", "char", "char", "double", "char", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% Specify variable properties
opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var8", "Var9", "Var10", "Var11", "Var12", "Var13", "Var14", "Var15", "Var16", "Var17", "Var18", "Var19", "Var20", "Var21", "Var22", "Var24", "Var25", "Var26", "Var27", "Var28", "Var29", "Var30", "Var31", "Var32", "Var33", "Var34", "Var35", "Var36", "Var37", "Var39", "Var40", "Var41", "Var42", "Var43", "Var45"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var8", "Var9", "Var10", "Var11", "Var12", "Var13", "Var14", "Var15", "Var16", "Var17", "Var18", "Var19", "Var20", "Var21", "Var22", "Orig_category_biot", "Var24", "Var25", "Var26", "Var27", "Var28", "Var29", "Var30", "Var31", "Var32", "Var33", "Var34", "Var35", "Var36", "Var37", "Wet", "Var39", "Var40", "Var41", "Var42", "Var43", "Var45"], "EmptyFieldRule", "auto");

% Import the data
tbl = readtable(filename, opts, "UseExcel", false);



Orig_category_biot = tbl.Orig_category_biot;
Humidity = tbl.Wet;
Density_rel = tbl.Plot_otnos;

Months = [3, 4, 5];

Satellite(:,1,1) = tbl.ch_3_1;
Satellite(:,2,1) = tbl.ch_3_2;
Satellite(:,3,1) = tbl.ch_3_3;
Satellite(:,4,1) = tbl.ch_3_4;
Satellite(:,5,1) = tbl.ch_3_5;
Satellite(:,6,1) = tbl.ch_3_6;
Satellite(:,7,1) = tbl.ch_3_7;
Satellite(:,8,1) = tbl.ch_3_8;
Satellite(:,9,1) = tbl.ch_3_9;

Satellite(:,1,2) = tbl.ch_4_1;
Satellite(:,2,2) = tbl.ch_4_2;
Satellite(:,3,2) = tbl.ch_4_3;
Satellite(:,4,2) = tbl.ch_4_4;
Satellite(:,5,2) = tbl.ch_4_5;
Satellite(:,6,2) = tbl.ch_4_6;
Satellite(:,7,2) = tbl.ch_4_7;
Satellite(:,8,2) = tbl.ch_4_8;
Satellite(:,9,2) = tbl.ch_4_9;

Satellite(:,1,3) = tbl.ch_5_1;
Satellite(:,2,3) = tbl.ch_5_2;
Satellite(:,3,3) = tbl.ch_5_3;
Satellite(:,4,3) = tbl.ch_5_4;
Satellite(:,5,3) = tbl.ch_5_5;
Satellite(:,6,3) = tbl.ch_5_6;
Satellite(:,7,3) = tbl.ch_5_7;
Satellite(:,8,3) = tbl.ch_5_8;
Satellite(:,9,3) = tbl.ch_5_9;

Table_type(1:size(Satellite,1), 1) = comment;


Satellite(1,:,:) = [];
Orig_category_biot(1,:) = [];
Humidity(1,:) = [];
Density_rel(1,:) = [];
Table_type(1,:) = [];


clear opts tbl filename comment
disp(['data ready' newline])
end


