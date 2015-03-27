function [cr, cb] = get_crcb(filename)
im= imread(filename);
% convert RGB to YCbCr
%ycbcrmap = rgb2ycbcr(map) converts the RGB values in map to the YCbCr color space. 
%map must be an M-by-3 array. ycbcrmap is an M-by-3 matrix that contains the YCbCr luminance (Y) and chrominance (Cb and Cr) color values as columns. 
%Each row in ycbcfmap represents the equivalent color to the corresponding row in the RGB colormap, map.

imycc = rgb2ycbcr(im);
% low pass filter matrix
lpf = 1/9 * ones(3); %lpf is a low pass filter

% take Cr and Cb channels
cr = imycc(:,:,3); %cr is the third column
cb = imycc(:,:,2); %%cr is the second column

% pass thru low pass filter
cr = filter2(lpf, cr);
cb = filter2(lpf, cb);
%concatenate all rows
cr = reshape(cr, 1, prod(size(cr)));
cb = reshape(cb, 1, prod(size(cb)));
end