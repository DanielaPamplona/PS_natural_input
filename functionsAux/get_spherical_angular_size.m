function angle_list = get_spherical_angular_size(r_list, epsilonc_list, chic_list, patch_size, pixel_size)
%returns the angle size of a patch
% r, epsilon, chi center positions of the patch in angular coordinates,
% patch_size patch size
% % pixel_size:size (in mm) of a pixel (if a camera, usual sensor array size is 45mmx34mm) (pixel size = (number of pixels per row)/(horizontal sensor size)) (in our case the images are square, and the pixels as well)
[xc_list,yc_list,zc_list] = angles2sphere(r_list,epsilonc_list,zeros(size(chic_list)));
[x1c_list,y1c_list] = hom2int(xc_list,yc_list);
[x1r,y1r] = img2int([1 patch_size],[1 patch_size],[1 patch_size],[1 patch_size],pixel_size);
x1r = (x1r(2)-x1r(1))/2;
epsilonr_list = zeros(size(epsilonc_list));
for i = 1:size(epsilonc_list,1)
    for j = 1:size(epsilonc_list,2)
        r = r_list(i,j);
        epsilonc = epsilonc_list(i,j);
        chic = 0;
        x1c = x1c_list(i,j);
        y1c = y1c_list(i,j);
        options = [r epsilonc chic];
        tf = maketform('custom', 2, 2,@project_img_coord_tan_plane_form, @inv_project_img_coord_tan_plane_form, options);
        [x1r_out,y1r_out] = tforminv(tf,x1c+x1r,y1c);
        [xr_out, yr_out] = int2hom(x1r_out,y1r_out);
        [r, epsilonr, chir] = projective2angles(xr_out, yr_out,-2*r);
        epsilonr_list(i,j) = epsilonr;
    end
end
angle_list = 2*abs(epsilonr_list-epsilonc_list);
