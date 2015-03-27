function  LEN1  = Estlength( ifbl, THETA)
%UNTITLED4 S this function goes here
%   Detailed explanation goes here
ifbl = medfilt2(abs(ifbl));
%Converting to fourier domain
fin = fft2(ifbl);
%Performing log transform
lgfin = abs(log(1 + abs(double(fin))));
%lgpow = abs(lgfin);
%Performing inverse fourier transform to get the image in Cepstrum domain
cin = ifft2(lgfin);
%Rotating the image
cinrot = imrotate(cin, -THETA);
%Taking average of all the columns
for i=1:size(cinrot, 2)
    avg(i) = 0;
    for j=1:size(cinrot, 1)
        avg(i) = avg(i) + cinrot(j, i);
    end
    avg(i) = avg(i)/size(cinrot, 1);
end
avgr = real(avg);
%Calculating the blur length using first negative value
index = 0;
for i = 1:round(size(avg,2)),
    if real(avg(i))<0,
        index = i;
        break;
    end
end
%If Zero Crossing found then return it as the blur length
if index~=0,
    LEN1 = index;
else
    %If Zero Crossing not found then find the lowest peak
    %Calculating the blur length using Lowest Peak
    index = 1;
    startval = avg(index);
    for i = 1 : round(size(avg, 2)/2),
        if startval>avg(i),
            startval = avg(i);
            index = i;
        end
    end

    LEN1 = index;
end
end

