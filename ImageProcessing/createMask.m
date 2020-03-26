function [mask] = createMask(imageMask, outerErosion, innerErosion, imageThreshold)
%% Create the mask

imageMask = imageMask > imageThreshold;
mask.noErosion = imageMask;
imshow(mask.noErosion);

%outerErosion Image
se = strel('disk',outerErosion);        
mask.outer = imerode(mask.noErosion,se);
figure, imshow(mask.outer);

%innerErosion Image
se = strel('disk',innerErosion);        
mask.inner = imerode(mask.outer,se);
figure, imshow(mask.inner);

%get basic properties of the mask
maskProperties = regionprops(mask.inner,'Area','Centroid');
mask.area = maskProperties.Area;
mask.centroid = maskProperties.Centroid;

%calculate radius r=sqrt(area/pi)
mask.radius = sqrt(mask.area/pi);

end
