function Replace_cells = load_replace_cells(filename)

%% Set up the Import Options and import the data
opts = spreadsheetImportOptions("NumVariables", 6);

% Specify sheet and range
opts.Sheet = "Лист1";
opts.DataRange = "A2:F51";

% Specify column names and types
opts.VariableNames = ["Origin", "Cat1", "Cat2", "Cat3", "Cat4", "Cat5"];
opts.VariableTypes = ["categorical", "categorical", "categorical", "categorical", "categorical", "categorical"];

% Specify variable properties
opts = setvaropts(opts, ["Origin", "Cat1", "Cat2", "Cat3", "Cat4", "Cat5"], "EmptyFieldRule", "auto");

% Import the data
tbl = readtable(filename, opts, "UseExcel", false);

%% Convert to output type
Origin = tbl.Origin;
Cat1 = tbl.Cat1;
Cat2 = tbl.Cat2;
Cat3 = tbl.Cat3;
Cat4 = tbl.Cat4;
Cat5 = tbl.Cat5;


Replace_cells{1} = Origin;
Replace_cells{2} = Cat1;
Replace_cells{3} = Cat2;
Replace_cells{4} = Cat3;
Replace_cells{5} = Cat4;
Replace_cells{6} = Cat5;

%% Clear temporary variables
clear opts tbl


end

