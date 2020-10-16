clear;
hold_out = 2/6;
class = {'HC-','I-I','L-L','M-M','R-R','T-I','T-L','T-M','T-R','T-T'};
%sampling rate: 4000Hz
fs = 4000;
[train_data, test_data, train_label, test_label] = EMG_dataslctn(hold_out,class);
[~,~,label_train] = unique(train_label);
[~,~,label_test] = unique(test_label);

win_size = 20000;%400;%0.5*fs;% 800;
win_inc = win_size; % training data has 50% overlap between windowsz

disp('calculating trainning feature...');
for i =1:length(train_data)
    feature1(i,:) = [getrmsfeat(train_data{i}(:,1),win_size,win_inc)', getrmsfeat(train_data{i}(:,2),win_size,win_inc)'];

    ar_order = 1;
    feature2(i,:) = [getarfeat(train_data{i}(:,1),ar_order,win_size,win_inc)', getarfeat(train_data{i}(:,2),ar_order,win_size,win_inc)'];

    feature3(i,:) = [getmavfeat(train_data{i}(:,1), win_size, win_inc)', getmavfeat(train_data{i}(:,2), win_size, win_inc)'];

    feature4(i,:) = [getwlfeat(train_data{i}(:,1),win_size,win_inc)', getwlfeat(train_data{i}(:,2),win_size,win_inc)'];

    feature5(i,:) = [getiavfeat(train_data{i}(:,1),win_size,win_inc)', getiavfeat(train_data{i}(:,2),win_size,win_inc)'];

    feature6(i,:) = [getsscfeat(train_data{i}(:,1),0,win_size,win_inc)', getsscfeat(train_data{i}(:,2),0, win_size,win_inc)'];

    feature7(i,:) = [getzcfeat(train_data{i}(:,1),0,win_size,win_inc)', getzcfeat(train_data{i}(:,2),0,win_size,win_inc)'];

end

%feature5 = getrpemgfeat(data,'sym9'); 
feature1 = norm_feature(feature1,'c');
feature2 = norm_feature(feature2,'c');
feature3 = norm_feature(feature3,'c');
feature4 = norm_feature(feature4,'c');
feature5 = norm_feature(feature5,'c');
feature6 = norm_feature(feature6,'c');
feature7 = norm_feature(feature7,'c');
%}
feature = [feature1 feature2 feature3 feature4 feature5 feature6 feature7];

%feature8(c,:) = [getmoment(data{1,i}{1,j}(:,1),win_size,win_inc,3)', getmoment(data{1,i}{1,j}(:,2),win_size,win_inc)'];

disp('calculating test set feature...');
for i =1:length(test_data)
    feature1_test(i,:) = [getrmsfeat(test_data{i}(:,1),win_size,win_inc)', getrmsfeat(test_data{i}(:,2),win_size,win_inc)'];

    ar_order = 1;
    feature2_test(i,:) = [getarfeat(test_data{i}(:,1),ar_order,win_size,win_inc)', getarfeat(test_data{i}(:,2),ar_order,win_size,win_inc)'];

    feature3_test(i,:) = [getmavfeat(test_data{i}(:,1), win_size, win_inc)', getmavfeat(test_data{i}(:,2), win_size, win_inc)'];

    feature4_test(i,:) = [getwlfeat(test_data{i}(:,1),win_size,win_inc)', getwlfeat(test_data{i}(:,2),win_size,win_inc)'];

    feature5_test(i,:) = [getiavfeat(test_data{i}(:,1),win_size,win_inc)', getiavfeat(test_data{i}(:,2),win_size,win_inc)'];

    feature6_test(i,:) = [getsscfeat(test_data{i}(:,1),0,win_size,win_inc)', getsscfeat(test_data{i}(:,2),0, win_size,win_inc)'];

    feature7_test(i,:) = [getzcfeat(test_data{i}(:,1),0,win_size,win_inc)', getzcfeat(test_data{i}(:,2),0,win_size,win_inc)'];

end

%feature5_test = getrpemgfeat(test_data,'sym9');
%{
feature1_test = norm_feature(feature1_test);
feature2_test = norm_feature(feature2_test);
feature3_test = norm_feature(feature3_test);
feature4_test = norm_feature(feature4_test);
feature5_test = norm_feature(feature5_test);
feature6_test = norm_feature(feature6_test);
feature7_test = norm_feature(feature7_test);
%}
feature_test = [feature1_test feature2_test feature3_test feature4_test feature5_test feature6_test feature7_test];
%
disp('calculating trainning moments...');
c=1;
for i = 1:length(test_data)
for k=1:8
feat_mom_test{k}(c,:)= [getmoment(test_data{i}(:,1),win_size,win_inc,k+2)', getmoment(test_data{i}(:,2),win_size,win_inc,k+2)'];
end
c=c+1;
end
disp('calculating testing momnets...');
c=1;
for i=1:length(train_data)
for k=1:8
feat_mom{k}(c,:)= [getmoment(train_data{i}(:,1),win_size,win_inc,k+2)', getmoment(train_data{i}(:,2),win_size,win_inc,k+2)'];
end
c=c+1;
end

for i=1:8
    feat_mom{i} = norm_feature(feat_mom{i});
    feature = [feature feat_mom{i}];
end

for i=1:8
    feat_mom_test{i} = norm_feature(feat_mom_test{i});
    feature_test = [feature_test feat_mom_test{i}];
end

%[label, label_test] = getlabel(hold_out);
%}

Model=svm.train(feature,label_train,'kernel_function','rbf','rbf_sigma',8);
predict=svm.predict(Model, feature_test);
Accuracy=mean(label_test==predict)*100;