% This function transforms a patch that was projected into plane into one that was projected into a sphere
% in order to cut a rectangular patch on the spherical image, the input should not be the patch to project, but one with a small frame around, that we call planar_sample_frame
% planar_sample_frame_size: size of the sample in pixels
% uc_in, vc_in: pixel coordinates of the center of the patch
% img_size: image size in pixels where the patch was taken from
% pixel_size:size (in mm) of a pixel (if a camera, usual sensor array size is 45mmx34mm) (pixel size = (number of pixels per row)/(horizontal sensor size)) (in our case the images are square, and the pixels as well)
% r: radius of the sphere, under our model equal to half of the focal length
% epsilon: eccentric angle
% chi: polar angle
% interpolation_method: interpolation of the projection, usually bicubic 
% spherical_sample_frame: projected planar sample frame
% uc_out,vc_out pixel coordinates of the center of the input patch, uc_in, vc_in
function [spherical_sample_frame,uc_out, vc_out] = planar2sphere_composite(planar_sample_frame,planar_sample_frame_size, uc_in, vc_in, img_size,pixel_size,r,epsilon,chi,interpolation_method)

uimg_input = [1 img_size(1)];
vimg_input = [1 img_size(2)];
uData_frame_input = [round(uc_in-planar_sample_frame_size/2) roundd(uc_in+planar_sample_frame_size/2)];
vData_frame_input = [round(vc_in-planar_sample_frame_size/2) roundd(vc_in+planar_sample_frame_size/2)];
[x1Data_frame_input, y1Data_frame_input] = img2int(uData_frame_input, vData_frame_input, uimg_input, vimg_input, pixel_size);
[xc, yc] = img2hom(uc_in, vc_in, uimg_input, vimg_input, pixel_size);
options = [r epsilon chi];
tf_projective2sphere = maketform('custom', 2, 3,@projective2sphere_form, @sphere2projective_form, options);
tf_stereographic_proj_center = maketform('custom', 3, 3,@stereographic_proj_center_form, @inv_stereographic_proj_center_form, options);
tf_rot_plan = maketform('custom', 3, 2,@rot_plan_form, @inv_rot_plan_form, options);
tf = maketform('composite', [tf_rot_plan,tf_stereographic_proj_center,tf_projective2sphere]);
[x1s, y1s] = hom2int(xc,yc);
[x1s_out,y1s_out] = tformfwd(tf,x1s,y1s);
[spherical_sample_frame,x1Data_output,y1Data_output] = imtransform(planar_sample_frame, tf,interpolation_method,'UData', x1Data_frame_input, 'VData',y1Data_frame_input,'XYScale',pixel_size);
[uc_out, vc_out] = int2img(x1s_out, y1s_out,x1Data_output, y1Data_output,pixel_size);

