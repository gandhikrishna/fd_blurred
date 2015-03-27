function faceDetection(inputfile)
[rmean,bmean,rbcov]=Model(); %Generates model from skin colors
%match skin
[likely_skin]=Likelyhood(inputfile,rmean,bmean,rbcov);
%getting nearest skin color in 2d matrix
[skinBW] = im2bw(likely_skin); %binary image
imshow(skinBW);
title('binary image');
%BW5 = imfill(skinBW,'holes');
%figure,imshow(BW5);
[erodedBW]=labelRegions(skinBW); %apply erosion,dilations techniques for filling the holoes etc and label the regions

%To get those regions which mark aspect ratio similar to that of human face
%(aspect ratio >=1 and aspect ratio <=3.5))
[aspectBW]=testAspects(erodedBW);
%remove small areas
area=bwareaopen(aspectBW,300);
%BW2 = bwareaopen(BW, P) removes from a binary image all connected components (objects) 
%that have fewer than P pixels, producing another binary image, BW2.
%figure,imshow(area, [0 1]);
%title('Image after removing small areas');
%check ellipse
props = regionprops(area, 'eccentricity');
idx = ( [props.Eccentricity] >0.2);
large = ismember(area,find(idx)); 
%imshow(large, [0 1]);

[K,P]=bwlabel(large,8);
%L = bwlabel(BW, n) returns a matrix L, of the same size as BW, containing labels for the connected objects in BW
%P contaiins number of connected components ( here number of valid regions)

%compute centroid of each region and plot on original image
%s  = regionprops(logical(large), 'centroid');

l = regionprops(logical(large), 'BoundingBox');

%centroids = cat(1, s.Centroid);

figure;imshow(imread(inputfile));
if(P>0)
hold on
title('Original Image with bounding boxes');
%fprintf(1,'Blob # x1 x2 y1 y2\n');
for k = 1 : P % Loop through all blobs.
% Find the mean of each blob. (R2008a has a better way where you can pass the original image
% directly into regionprops. The way below works for all versionsincluding earlier versions.)
thisBlobsBox = l(k).BoundingBox; % Get list of pixels in current blob.
x1 = thisBlobsBox(1);
y1 = thisBlobsBox(2);
x2 = x1 + thisBlobsBox(3);
y2 = y1 + thisBlobsBox(4);



x = [x1 x2 x2 x1 x1];
y = [y1 y1 y2 y2 y1];
%subplot(3,4,2);
plot(x, y, 'LineWidth', 4);
end
hold off
end
title('Final Image After Face Detection')
clear all
end
