
Lin = Density_rel(Density_rel ~= 0);
Log = log10(Density_rel(Density_rel ~= 0));

figure
histogram(Lin)
figure
histogram(Log)



%%
clc

prctile(Lin, 50)
10^prctile(Log, 50)













