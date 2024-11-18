function angle_list = get_planar_angular_size(r_list, epsilonc_list, chic_list, patch_size, pixel_size)

[xc_list, yc_list,zc_list] = angles2projective(r_list,epsilonc_list,zeros(size(chic_list)));
[xr, yr] = img2hom([1 patch_size],[1 patch_size], [1 patch_size],[1 patch_size],pixel_size);
xr = (xr(2)-xr(1))/2;
[rr_list, epsilonr_list, chir_list] = projective2angles(xc_list+xr,yc_list, -2*r_list);
angle_list = 2*abs(epsilonr_list-epsilonc_list);