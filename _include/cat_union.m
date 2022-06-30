


function out_cat = cat_union(in_cat, rep_list, profile_N)

out_cat = in_cat;

if profile_N ~= 0
    Replace_from = rep_list{1};
    Replace_to = rep_list{1+profile_N};
    
    for i = 1:numel(Replace_from)
        Range = out_cat == Replace_from(i);
        out_cat(Range) = Replace_to(i);
        out_cat = removecats(out_cat, string(Replace_from(i)));
    end
end


end





