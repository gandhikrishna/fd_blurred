function [  ] = faced( fname )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
FDetect = vision.CascadeObjectDetector;

%Read the input image
I = imread(fname);

%Returns Bounding Box values based on number of objects
BB = step(FDetect,I);

figure,
imshow(I); hold on
for i = 1:size(BB,1)
    rectangle('Position',BB(i,:),'LineWidth',5,'LineStyle','-','EdgeColor','r');
end
title('Face Detection');
hold off;


end

