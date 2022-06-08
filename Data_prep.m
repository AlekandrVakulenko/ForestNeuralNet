

load('Data_1_may.mat')


Pixel_pre = [ch1, ch2, ch3, ch4, ch5, ch6, ch7, ch8, ch9];

Where_is_nan = isnan(Pixel_pre);
[row, col] =find(Where_is_nan);
row = unique(row);

Pixel_pre(row, :) = [];
Orig_category_biot(row) = [];

Pixel_pre = permute(Pixel_pre, [2, 1]);

% Pixel(1, :, :) = Pixel_pre;
Pixel_pre_2 = Pixel_pre;
Pixel_pre_2(:, :, 2, 2) = 0;
Pixel_pre_2 = permute(Pixel_pre_2, [3, 1, 4, 2]);
Pixel_pre_2(2, :, :, :) = [];
Pixel_pre_2(:, :, 2, :) = [];

Pixel = Pixel_pre_2;

clearvars ans ch1 ch2 ch3 ch4 ch5 ch6 ch7 ch8 ch9 row col Where_is_nan Pixel_pre Pixel_pre_2
%%


Category_U = unique(Orig_category_biot);
Category_U = removecats(Category_U, {'10_Водный объект', '11_Антропоген'});
Orig_category_biot = removecats(Orig_category_biot, {'10_Водный объект', '11_Антропоген'});


%%

Replace_list.from(1) = "6.1_Лес_березняк-кисличник";
Replace_list.to(1)   = "6.1_Лес_березняк";
Replace_list.from(2) = "6.1_Лес_березняк-приручейный";
Replace_list.to(2)   = "6.1_Лес_березняк";
Replace_list.from(3) = "6.1_Лес_березняк-разнотравный";
Replace_list.to(3)   = "6.1_Лес_березняк";
Replace_list.from(4) = "6.1_Лес_березняк-сфагново-кустарничковый";
Replace_list.to(4)   = "6.1_Лес_березняк";
Replace_list.from(5) = "6.1_Лес_березняк-сфагново-травяный";
Replace_list.to(5)   = "6.1_Лес_березняк";
Replace_list.from(6) = "6.1_Лес_березняк-сфагновый";
Replace_list.to(6)   = "6.1_Лес_березняк";
Replace_list.from(7) = "6.1_Лес_березняк-черничник";
Replace_list.to(7)   = "6.1_Лес_березняк";

Replace_list.from(8) = "6.1_Лес_ельник-брусничник";
Replace_list.to(8)   = "6.1_Лес_ельник";
Replace_list.from(9) = "6.1_Лес_ельник-кисличник";
Replace_list.to(9)   = "6.1_Лес_ельник";
Replace_list.from(10) = "6.1_Лес_ельник-приручейный";
Replace_list.to(10)   = "6.1_Лес_ельник";
Replace_list.from(11) = "6.1_Лес_ельник-разнотравный";
Replace_list.to(11)   = "6.1_Лес_ельник";
Replace_list.from(12) = "6.1_Лес_ельник-сфагново-кустарничковый";
Replace_list.to(12)   = "6.1_Лес_ельник";
Replace_list.from(13) = "6.1_Лес_ельник-сфагново-травяный";
Replace_list.to(13)   = "6.1_Лес_ельник";
Replace_list.from(14) = "6.1_Лес_ельник-сфагновый";
Replace_list.to(14)   = "6.1_Лес_ельник";
Replace_list.from(15) = "6.1_Лес_ельник-черничник";
Replace_list.to(15)   = "6.1_Лес_ельник";

Replace_list.from(16) = "6.1_Лес_осинник-кисличник";
Replace_list.to(16)   = "6.1_Лес_осинник";
Replace_list.from(17) = "6.1_Лес_осинник-разнотравный";
Replace_list.to(17)   = "6.1_Лес_осинник";
Replace_list.from(18) = "6.1_Лес_осинник-черничник";
Replace_list.to(18)   = "6.1_Лес_осинник";

Replace_list.from(19) = "6.1_Лес_сероольшанник-кисличник";
Replace_list.to(19)   = "6.1_Лес_сероольшанник";
Replace_list.from(20) = "6.1_Лес_сероольшанник-разнотравный";
Replace_list.to(20)   = "6.1_Лес_сероольшанник";

Replace_list.from(21) = "6.1_Лес_сосняк-брусничник";
Replace_list.to(21)   = "6.1_Лес_сосняк";
Replace_list.from(22) = "6.1_Лес_сосняк-кисличник";
Replace_list.to(22)   = "6.1_Лес_сосняк";
Replace_list.from(23) = "6.1_Лес_сосняк-сфагново-кустарничковый";
Replace_list.to(23)   = "6.1_Лес_сосняк";
Replace_list.from(24) = "6.1_Лес_сосняк-сфагновый";
Replace_list.to(24)   = "6.1_Лес_сосняк";
Replace_list.from(25) = "6.1_Лес_сосняк-черничник";
Replace_list.to(25)   = "6.1_Лес_сосняк";

Replace_list.from(26) = "6.1_Лес_черноольшанник-приручейный";
Replace_list.to(26)   = "6.1_Лес_черноольшанник";
Replace_list.from(27) = "6.1_Лес_черноольшанник-разнотравный";
Replace_list.to(27)   = "6.1_Лес_черноольшанник";
Replace_list.from(28) = "6.1_Лес_черноольшанник-сфагновый";
Replace_list.to(28)   = "6.1_Лес_черноольшанник";


for i = 1:numel(Replace_list.from)
    
    Range = Orig_category_biot == Replace_list.from(i);
    Orig_category_biot(Range) = Replace_list.to(i);
    
    Orig_category_biot = removecats(Orig_category_biot, Replace_list.from(i));
    
end



%%
clc

%bad
% Layers = [
%     imageInputLayer([1 9 1],"Name","imageinput","Normalization","none")
%     
%     fullyConnectedLayer(64,"Name","fc_1")
%     leakyReluLayer(0.01,"Name","leakyrelu_1")
%     
%     fullyConnectedLayer(64,"Name","fc_2")
%     leakyReluLayer(0.01,"Name","leakyrelu_2")
%     
%     fullyConnectedLayer(64,"Name","fc_3")
%     leakyReluLayer(0.01,"Name","leakyrelu_3")
%     
%     fullyConnectedLayer(128,"Name","fc_4")
%     leakyReluLayer(0.01,"Name","leakyrelu_4")
%     
%     fullyConnectedLayer(64,"Name","fc_5")
%     reluLayer("Name","relu_5")
%     
%     fullyConnectedLayer(64,"Name","fc_6")
%     reluLayer("Name","relu_6")
%     
%     fullyConnectedLayer(32,"Name","fc_7")
%     reluLayer("Name","relu_7")
%     
%     fullyConnectedLayer(19,"Name","fc_8")
%     reluLayer("Name","relu_8")
%     
%     softmaxLayer("Name","softmax")
%     classificationLayer("Name","classoutput")];


%norm
% Layers = [
%     imageInputLayer([1 9 1],"Name","imageinput","Normalization","none")
%     
%     fullyConnectedLayer(64,"Name","fc_1")
%     leakyReluLayer(0.01,"Name","leakyrelu_1")
%     
%     fullyConnectedLayer(128,"Name","fc_2")
%     leakyReluLayer(0.01,"Name","leakyrelu_2")
%     
%     fullyConnectedLayer(256,"Name","fc_3")
%     leakyReluLayer(0.01,"Name","leakyrelu_3")
%     
%     fullyConnectedLayer(512,"Name","fc_4")
%     leakyReluLayer(0.01,"Name","leakyrelu_4")
%     
%     fullyConnectedLayer(256,"Name","fc_5")
%     reluLayer("Name","relu_5")
%     
%     fullyConnectedLayer(128,"Name","fc_6")
%     reluLayer("Name","relu_6")
%     
%     fullyConnectedLayer(64,"Name","fc_7")
%     reluLayer("Name","relu_7")
%     
%     fullyConnectedLayer(19,"Name","fc_8")
%     reluLayer("Name","relu_8")
%     
%     softmaxLayer("Name","softmax")
%     classificationLayer("Name","classoutput")];



Layers = [
    imageInputLayer([1 9 1],"Name","imageinput","Normalization","none")
    
    fullyConnectedLayer(300,"Name","fc_1")
    leakyReluLayer(0.01,"Name","leakyrelu_1")
    
    fullyConnectedLayer(600,"Name","fc_2")
    leakyReluLayer(0.01,"Name","leakyrelu_2")
    
    fullyConnectedLayer(1124,"Name","fc_3")
    leakyReluLayer(0.01,"Name","leakyrelu_3")
    
    fullyConnectedLayer(280,"Name","fc_4")
    reluLayer("Name","relu_4")
    
    fullyConnectedLayer(19,"Name","fc_5")
    
    softmaxLayer("Name","softmax")
    classificationLayer("Name","classoutput")];


%norm
% Layers = [
%     imageInputLayer([1 9 1],"Name","imageinput","Normalization","none")
%     
%     fullyConnectedLayer(256,"Name","fc_1")
%     leakyReluLayer(0.01,"Name","leakyrelu_1")
%     
%     fullyConnectedLayer(512,"Name","fc_2")
%     leakyReluLayer(0.01,"Name","leakyrelu_2")
%     
%     fullyConnectedLayer(1024,"Name","fc_3")
%     leakyReluLayer(0.01,"Name","leakyrelu_3")
%     
%     fullyConnectedLayer(256,"Name","fc_4")
%     reluLayer("Name","relu_4")
%     
%     fullyConnectedLayer(19,"Name","fc_5")
%     
%     softmaxLayer("Name","softmax")
%     classificationLayer("Name","classoutput")];


Classification_Layer = Layers(end);

Classification_Layer.Classes = unique(Orig_category_biot);

Layers(end) = Classification_Layer;


%%
clc

Pixel(1, :, 1, 1:2)






%%




Orig_category_biot


ans = unique(Orig_category_biot)













