sclc;
clear all;
close all;
addpath('./functionsAux/');
fprintf('Loading windowed image and initializing parameters...\n');
%%interpolation method used in the t-form
interpolation_method = 'bicubic';

%coordinates of the center of the patch in angles
epsilon = 50;
chi = 45;
r = 8.3350;

fov = 120;%field of view covered by the initial image
img_size = [5954, 5954];%initial image size in pixels

epsilon_max = deg2rad(max(fov)/2);
[x_max,y_max] = angles2projective(r, epsilon_max,0);

pixel_size = abs(2*x_max/max(img_size));

sample_size_pixels = 128;

epsilonr = deg2rad(epsilon);
chir =deg2rad(chi);


[uc_in,vc_in] = angles2img(r, epsilonr, chir,pixel_size,img_size); %input pixel coordinates
uc_s = 255; %sample pixel coordinates (relactive to the window)
vc_s = 255; %sample pixel coordinates (relactive to the window)

spherical_sample_size_angles = rad2deg(get_spherical_angular_size(r, epsilonr, chir, sample_size_pixels, pixel_size)); %spherical sample size in angles (depending on the pixel size)
[ulim,vlim] = angles2img(r*ones(1,2), [epsilonr, epsilonr+deg2rad(spherical_sample_size_angles)/2],[0,0],pixel_size,img_size);
planar_sample_frame_size_pixels = round(1.2*2*(vlim(2)-vlim(1)+1)); %planar  sample with frame size in angles (depending on the pixel size) (the framed sample is 1.2 times larger than the sample. This number was tuned empirically)

windowed_img = imread('IMG200.png'); %window planar image
windowed_img = rgb2gray(windowed_img);
windowed_img = double(windowed_img);



planar_sample_frame = windowed_img(round(uc_s- planar_sample_frame_size_pixels/2):round(uc_s+planar_sample_frame_size_pixels/2)-1, round(vc_s-planar_sample_frame_size_pixels/2):round(vc_s+planar_sample_frame_size_pixels/2)-1);

fprintf('Projecting into a naturalistic input...\n');
[spherical_sample_frame,uc_out,vc_out] = planar2sphere_composite(planar_sample_frame,planar_sample_frame_size_pixels, uc_in, vc_in, img_size,pixel_size,r,epsilon,chi,interpolation_method);
spherical_sample = spherical_sample_frame(round(uc_out- sample_size_pixels/2):round(uc_out+sample_size_pixels/2)-1, round(vc_out- sample_size_pixels/2):round(vc_out+sample_size_pixels/2)-1);
spherical_sample = spherical_sample-min(spherical_sample(:));
spherical_sample = spherical_sample/max(spherical_sample(:));


[fx,fy] = freqspace(sample_size_pixels,'meshgrid'); %frequency bands until the Nyquist condition
fxa = fx*sample_size_pixels/(2*spherical_sample_size_angles); %frequency bands in cycles per degree
fya = fy*sample_size_pixels/(2*spherical_sample_size_angles); %frequency bands in cycles per degree

MTF = get_MTF(epsilonr,fxa,fya); %modulation transfer function based on the results of Navarro 1993

spherical_abrr_sample = ifft2(fft2(spherical_sample).*ifftshift(MTF)); %blurring the spherical image
spherical_abrr_sample = spherical_abrr_sample -min(spherical_abrr_sample(:));
spherical_abrr_sample = spherical_abrr_sample/max(spherical_abrr_sample(:));


fprintf('Plotting\n');
figure()
subplot(2,2,1)
imagesc(windowed_img);
axis('square')
title('Planar Windowed Image')
subplot(2,2,2);
imagesc(planar_sample_frame)
axis('square')
title('Planar Sample (with Frame)')
subplot(2,2,3)
imagesc(spherical_sample);
axis('square')
title('Spherical Sample')
subplot(2,2,4);
imagesc(spherical_abrr_sample);
axis('square')
title('Naturalistic Sample')
colormap gray
















