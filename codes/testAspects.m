function [aspectBW]=testAspects(eulerBW)
 [m,n]=size(eulerBW);
%fill holes in image
filledBW = imfill(eulerBW,'holes');
%Apply Dilation
se1 = strel('disk',2); 
growBW=zeros(m,n);
growBW=imdilate(filledBW,se1);
%label as binary
[labels,num] = bwlabel(growBW,8);
[aspect_ratio]=getAspects(eulerBW);
%aspect_ratio will contain ratio of major axis length and minor axis length of aech region since we are treating each region as eclippse 
%fprintf('%f\n',aspect_ratio);
% %take regions which has aspect ratio within range
region_index = find(aspect_ratio<=3.5 & aspect_ratio>=1);
aspectBW=zeros(m,n);

%make new binary image only with regions which pass euler test
for i=1:length(region_index)
    % Compute the coordinates for this region.
    [x,y] = find(bwlabel(filledBW) == region_index(i));
    % Get an image that only has this region, the rest is black 
    bwsegment = bwselect(filledBW,y,x,8);
   %bwselect returns the regions containing pixrls x and y.
   %BW2 = bwselect(BW,c,r,n) returns a binary image containing the objects that overlap the pixel (r,c). 
   %r and c can be scalars or equal-length vectors. If r and c are vectors, BW2 contains the sets of objects overlapping with any of the pixels (r(k),c(k)). 
   %n can have a value of either 4 or 8 (the default), where 4 specifies 4-connected objects and 8 specifies 8-connected objects. 
   %Objects are connected sets of on pixels (i.e., pixels having a value of 1). 
   aspectBW=aspectBW+bwsegment;
end
%subplot(3,3,7);
%figure,imshow(aspectBW)
%title({'After Aspect Ratio Test';['(',num2str(length(region_index)),' regions)']});
end