function[labelBW]=labelRegions(binary_skin)
[m,n] = size(binary_skin); 
filledBW=zeros(m,n);
filledBW = imfill(binary_skin,'holes');
figure;imshow(filledBW);
title('Image after filling holes');
%Apply Erosion
%strel Create morphological structuring element strel(shape,parameter)
se2 = strel('disk',2);
%check by taking value to be 10
%strel(disk,radius)
erodedBW=zeros(m,n);
erodedBW = imerode(filledBW,se2);
figure;imshow(erodedBW)
title('Image After Erosion')
%Apply Dilation
se1 = strel('disk',8); 
dilateBW=zeros(m,n);
dilateBW=imdilate(erodedBW,se1);
%multiply eroded image with skin segmented image to retain holes
dilateBW = immultiply(dilateBW,binary_skin);
%after dilation is done , and now multiplying with binary_color will make
%image appear with features like mouth , node , eyes etc.
figure;imshow(dilateBW)
title('Image After Dilation')
%Label skin regions
labelBW=zeros(m,n);
[labelBW,num] = bwlabel(dilateBW,8);
%Color the labeled regions -background is black
color_regions=zeros(m,n);
color_regions= label2rgb(labelBW, 'hsv', 'black', 'shuffle');
%show colored labeled regions of image
%figure,imshow(color_regions)
%title({'Labeled Regions';['(',num2str(num),' regions)']})
end