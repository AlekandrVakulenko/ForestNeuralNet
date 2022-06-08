

function Mat = error_table(ro, co)

Mat = zeros(5);

% ro = [1, 1, 3];
% co = [1, 1, 2];

for i = 1:numel(ro)
    Mat(ro(i), co(i)) = Mat(ro(i), co(i)) + 1;
end


% clearvars Mat ro co

end
