function[likely_skin]=Likelyhood(filename,rmean,bmean,rbcov)
img = imread(filename);
% convert RGB to YCrCb color space
imycbcr = rgb2ycbcr(img);
[m,n,l] = size(img);
%create a 2D matrix with same dimension of image
likely_skin = zeros(m,n);
for i = 1:m
   for j = 1:n
      %get crominance values for each pixel
      cr = double(imycbcr(i,j,3)); % cr is the third column 
      cb = double(imycbcr(i,j,2));%cb is the second column
      %compute the likelyhood of each pixel
      x = [(cr-rmean);(cb-bmean)];
      likely_skin(i,j) = [power(2*pi*power(det(rbcov),0.5),-1)]*exp(-0.5* x'*inv(rbcov)* x);
   end
end
%pass thru low pass filter
lpf= 1/9*ones(3);
likely_skin = filter2(lpf,likely_skin);
%normalize the likelyhood values with maximum value
likely_skin = likely_skin./max(max(likely_skin));

%figure,imshow(likely_skin);
end