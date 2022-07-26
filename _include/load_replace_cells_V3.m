function Replace_cells = load_replace_cells_V3(filename, Profile_name)

dataLines = [2, 51];
opts = spreadsheetImportOptions("NumVariables", 8);
opts.Sheet = "Лист1";
opts.DataRange = "A" + dataLines(1, 1) + ":H" + dataLines(1, 2);
opts.VariableNames = ["Origin", "Cat1", "Cat2", "Cat3", "Cat31", "Cat32", "Cat4", "Cat5"];
opts.VariableTypes = ["string", "categorical", "categorical", "categorical", "categorical", "categorical", "categorical", "categorical"];
opts = setvaropts(opts, "Origin", "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Origin", "Cat1", "Cat2", "Cat3", "Cat31", "Cat32", "Cat4", "Cat5"], "EmptyFieldRule", "auto");

tbl = readtable(filename, opts, "UseExcel", false);

% Convert to output type
Origin = tbl.Origin;
Cat1 = tbl.Cat1;
Cat2 = tbl.Cat2;
Cat3 = tbl.Cat3;
Cat31 = tbl.Cat31;
Cat32 = tbl.Cat32;
Cat4 = tbl.Cat4;
Cat5 = tbl.Cat5;

Replace_cells{1} = Origin;

switch Profile_name
    case "Cat1"
        Replace_cells{2} = Cat1;
    case "Cat2"
        Replace_cells{2} = Cat2;
    case "Cat3"
        Replace_cells{2} = Cat3;
    case "Cat3.1"
        Replace_cells{2} = Cat31;
    case "Cat3.2"
        Replace_cells{2} = Cat32;
    case "Cat4"
        Replace_cells{2} = Cat4;
    case "Cat5"
        Replace_cells{2} = Cat5;
    otherwise
        error("Wrong replace profile name");
end




end