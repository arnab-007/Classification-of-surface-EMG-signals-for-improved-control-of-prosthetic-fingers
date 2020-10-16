function [label, label_test] = getlabel(holdout)
label = [];
label_test = [];
for j=1:10
    label = [label ones(1,round(holdout*6))*j];
    label_test = [label_test ones(1,round((1-holdout)*6))*j];
end

label=[label label label label label label label label];
label= label';

label_test=[label_test label_test label_test label_test label_test label_test label_test label_test];
label_test= label_test';