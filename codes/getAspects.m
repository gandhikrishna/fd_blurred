function [ratiolist] = getAspects(inputBW)
%Consider ech region as ecclipse and then find major and minor axes length
%of each region.

%compute length of major axis (of ellipse)for each region
major = regionprops(inputBW,'MajorAxisLength');
major_length=cat(1,major.MajorAxisLength);

%compute length of minor axis (of ellipse)for each region
minor = regionprops(inputBW,'MinorAxisLength');
minor_length=cat(1,minor.MinorAxisLength);
%compute aspect ratio
%if (minor_length>10)
ratiolist=major_length./minor_length;

%else 
 %   ratiolist=7;
%end
end
