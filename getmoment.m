function feat = getmoment(x,win_size,win_inc,order)
st = 1;
en = win_size;

datasize = size(x,1);
Nsignals = size(x,2);
numwin = floor((datasize - win_size)/win_inc)+1;

for i = 1:numwin
    feat(i,:) = moment(x(st:en,:),order);
     
    st = st + win_inc;
    en = en + win_inc;
end
