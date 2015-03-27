function [ THETA ] = Angle( ifbl)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
ifbl = medfilt2(abs(ifbl)); %median filter
ff=fft2(ifbl);
lgifbl = log(1+abs(double(ff))); %LOG TRansform
lgpow = abs(lgifbl).^2;
lgcep = ifft2(lgpow);
BW = edge(lgcep); %Edge Image
BW = ifftshift(BW);
H = hough(BW); %Hough Transform
for i=1:90
    for j=1:size(H, 1)
        temp = H(j, i);
        H(j, i) = H(j, 90+i);
        H(j, 90+i) = temp;
    end
end
maxi = max(max(H));
mini = min(min(H));
sizeofH = size(H);
thresh=(maxi - mini)/2;
%Converting to binary
for i=1:sizeofH(2),
    for j=1:sizeofH(1),
        if H(j, i)>=thresh
            H(j, i) = 1;
        else
            H(j, i) = 0;
        end
    end
end
sizeofH = size(H);
%Finding the sum of all columns
for i=1:sizeofH(2),
    %Initialising to zero
    ColsofH(i) = 0;
    for j=1:sizeofH(1),
        ColsofH(i) = ColsofH(i) + H(j, i);
    end
end
[maximum, THETA] = max(ColsofH);
end

