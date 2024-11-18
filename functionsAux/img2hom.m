function [x,y] = img2hom(u, v,uData, vData,pixel_size)
%transfor coordinates in the image plan to homogeneous
%uData and vData are the image minimum  and maximum pixel coordinates. U 
%corresponds to rows and v to columns. By default uData(1) and vData(1) 
%should be 1 and uData(2) and vData(2) should be the image_size 
% pixel_size:size (in mm) of a pixel (if a camera, usual sensor array size is 45mmx34mm) (pixel size = (number of pixels per row)/(horizontal sensor size)) (in our case the images are square, and the pixels as well)



y = pixel_size*(-u+(uData(2)+uData(1))/2);

x = pixel_size*(v-(vData(2)+vData(1))/2);
