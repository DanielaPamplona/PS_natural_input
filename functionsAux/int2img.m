function [u,v] = int2img(x1, y1,x1Data, y1Data,pixel_size)
%transform intrinsic coordinates into the image plan 
%x1Data and y1Data are the image minimum  and maximum intrinsic coordinates.  
% pixel_size:size (in mm) of a pixel (if a camera, usual sensor array size is 45mmx34mm) (pixel size = (number of pixels per row)/(horizontal sensor size)) (in our case the images are square, and the pixels as well)
[x,y] = int2hom(x1,y1);
[xData,yData]=int2hom(x1Data, y1Data);
[u,v] = hom2img(x,y,xData, yData, pixel_size);
