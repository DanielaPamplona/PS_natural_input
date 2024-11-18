function [r_matrix,epsilon_matrix,chi_matrix] = img2angles(u_matrix,v_matrix,z_matrix,pixel_size,img_size)
%change the coordinates of points in image coordinates to angular
%u_matrix, v_matrix image coordinates
%z_matrix projection plan coordinate = - 2*r
% img_size: image size in pixels where the patch was taken from
% pixel_size:size (in mm) of a pixel (if a camera, usual sensor array size is 45mmx34mm) (pixel size = (number of pixels per row)/(horizontal sensor size)) (in our case the images are square, and the pixels as well)

[x_matrix, y_matrix] = img2hom(u_matrix,v_matrix,[1 img_size(1)],[1 img_size(2)],pixel_size);

[r_matrix, epsilon_matrix, chi_matrix] = projective2angles(x_matrix, y_matrix, z_matrix);
