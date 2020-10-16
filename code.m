clear;
e=cd;f=1;
e1=dir(e);
for t=1:60
    f=1;
    b=e1(t+2);
    name=b.name;
    fil=csvread(name);
    fil_c1=fil(:,1);fil_c2=fil(:,2);
for t1=0:1250:(20000-2500)
    win_S1=fil_c1((t1+1):(t1+2500));
    win_S2=fil_c2((t1+1):(t1+2500));
    cwt_1=cwt(win_S1,1:16,'db2');
    cwt_2=cwt(win_S2,1:16,'db2'); 
    cwt_S101{t,f}=abs(double(cwt_1));cwt_S102{t,f}=abs(double(cwt_2));
    f=f+1;
end
end
save cwt_S101 cwt_S101;save cwt_S102 cwt_S102;
% save cwt_S61
% save cwt_S62