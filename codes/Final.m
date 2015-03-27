function [  ] = Final( input_file,ang,leng)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
X=imread(input_file); 




I2=rgb2gray(X);
h = fspecial('motion',leng,ang);
I=conv2(double(I2),double(h));
THETA=Angle(I)
%THETA=120
 LEN1  = Estlength( I, THETA)
%length =50 ;
length=LEN1%the length of the motion blur
theta =THETA; %the angle of the motion blur

PSF = fspecial('motion',length,theta);                           % creates the Point Spred F


figure;imshow(I,[]);

reg1 = deconvreg(I,PSF);                                    % regularized filter
figure; imshow(reg1,[]) ;                                         %displays deblurred image

L2 = wiener2(reg1,[3 3],.1);
figure;imshow(L2,[]); 



 cmap = colormap(summer);
 
 res=grs2rgb(uint8(L2),cmap);
 
 imwrite(res,'intermediate.jpg','jpg');
 res=grs2rgb(uint8(I),cmap);
 imwrite(res,'myinput.jpg','jpg');

% faceDetection('myinput.jpg')
 faceDetection('intermediate.jpg')
 
end

