clear
load('cwt_S62.mat');
for z1=1:60
    for z2=1:15
        x=cwt_S62{z1,z2};        
x1=abs(x);
x2=double(x1);
x3=x2(:);
sum_by_max=0;
sum=0;
AA=0;
sum1=0;
sum2=0;
sum3=0;
sum4=0;
sum5=0;
sum6=0;
sum7=0;
[s t]=size(x);
m=mean(x3);
v=var(x3);
sd=std(x3);
cv=cov(x3);
x4=sort(x3);
med=median(x4);
maximum=max(x3);
for i=1:s
    for j=1:t
      sum_by_max = sum_by_max + (-x2(i,j)*log(x2(i,j)));
    end
end
sumd=0;
sumn=0;
%for k=1:s
    %for l=1:t
       % sumd= sumd+ i*j*abs(x2(i,j));
       % sumn = sumn+ abs(x2(i,j));
        %A2= sumd/sumn;
    %end
%end
sum1d=0;
% for e=1:s
%     for f=1:t
%     sum1d= sum1d + (e^2*f^2*abs(x2(e,f)));
%     A3=(sum1d/sumn)*(1/2);
%     end
% end
sum2d=0;
for g=i:s
    for h=i:t
     sum2d=sum2d+abs(x2(i,j));
     AA= (sum2d/maximum);
    end
end
sum_by_max=0;
for i=1:s
    for j=1:t
        sum_by_max=(sum_by_max+ abs(x2(i,j)));
        Y=(sum_by_max/maximum);
    end
end
speak=0;
for i=1:150
    if (x3(i,1)== maximum)
        speak=i;
    end
end
sum_energy=0;
    for i=1:s
        for j=1:t
            sum_energy= (sum_energy+ double((x2(i,j))*(x2(i,j))));
        end 
    end    
%    real_value = abs(real(x(1,1)));
%    img=abs(imag(x(1,1)));
   for i=1:s
    for j=1:t
      sum = sum + ((x2(i,j)- m).^3);
    end
end
c3=sum/(s*t);
for i=1:s
    for j=1:t
       sum1 = sum1 + ((x2(i,j)- m).^4);
    end
end
c4=sum1/(s*t);
for i=1:s
    for j=1:t
       sum2 = sum2 + ((x2(i,j)- m).^5);
    end
end
c5=sum2/(s*t);
for i=1:s
    for j=1:t
       sum3 = sum3 + ((x2(i,j)- m).^6);
    end
end
c6=sum3/(s*t);
for i=1:s
    for j=1:t
      sum4 = sum4 + (x2(i,j).^2);
    end
end
r2=sum4/(s*t);
for i=1:s
    for j=1:t
      sum5 = sum5 + (x2(i,j).^3);
    end
end
r3=sum5/(s*t);
for i=1:s
    for j=1:t
      sum6 = sum6 + (x2(i,j).^4);
    end
end
r4=sum6/(s*t);
for i=1:s
    for j=1:t
      sum7 = sum7 + (x2(i,j).^5);
    end
end
r5=sum7/(s*t);
r6=sum1*s*t/sd;
r7=sum2*s*t/cv;
r8=sum3*s*t/v;
r9=cv*sd/v;
r10=sum5*t/sd;
r11=m*cv/sd;
r12=sum7*s/t;
sk1=c3/(sd.^3);
sk2=(m-maximum)/sd;
sk3=(3*(m-med))/sd;
sk4=(3*(m-med))/(cv.^2);
b2=c4/(sd.^4);
y =[AA cv m maximum med sd v Y speak sum_energy  r12 r11 r10 r9 r8 r7 r6 r5 sk1 sk2 sk3 sk4 r4 r3 r2 c6 c5 c4 c3];
feat62{z1,z2}=y;
    end
end
save feat62 feat62