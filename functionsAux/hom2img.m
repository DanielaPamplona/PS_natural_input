function [u,v] = hom2img(x, y,xData, yData,pixel_size)


u = 1/pixel_size*(-y+yData(1))+0.5;
v = 1/pixel_size*(x-xData(1))+0.5;
