function [train_data, test_data, train_label, test_label] = EMG_dataslctn(hold_out,class)

testdir='G:\emg_analysis\Data';
folders=dir(testdir);
nfolder=length(folders);
matfiles = {};
c1=1;
for i=3:nfolder
    testdir1(i-2,:)=fullfile(testdir,folders(i).name);
    matfiles{i-2}=dir(fullfile(testdir1((i-2),:),'*.csv'));
    dirlengths=length(matfiles{i-2});
    for j=1:dirlengths
        data{c1}=csvread(fullfile(testdir1((i-2),:),matfiles{i-2}(j).name)); %6=repeatations per subject and class
        label{c1}=matfiles{i-2}(j).name(1:3);
        c1 = c1+1;
    end
end

[Train_ind, Test_ind] = crossvalind('HoldOut', label, hold_out);
[~,~,class_ind] = unique(label);
c=1;d=1;
for i=1:length(data)
    if (Train_ind(i))
        train_data{c} = data{i};%[cwt(data{i}(:,1),1:16,'db2')',cwt(data{i}(:,2),1:16,'db2')'];
        %for k=1:length(class)
        %    if isequal(label{i},class{k})
        %train_label{c} = class_ind(i);
        %    end
        %end
        train_label{c} = label{i};
        c=c+1;
    else
        test_data{d} = data{i};%[cwt(data{i}(:,1),1:16,'db2')',cwt(data{i}(:,2),1:16,'db2')'];
        %for k=1:length(class)
        %    if isequal(label{i},class{k})
        %test_label{d} = class_ind(i);
        %    end
        %end
        test_label{d} = label{i};
        d=d+1;
    end
end

end