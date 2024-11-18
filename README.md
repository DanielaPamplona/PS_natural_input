
This package contains the source code to reproduce the planar to naturalistic transform described in [1].
Case this code is used for research, please do not forget to cite [1].
This code is under the Academic Free License (AFL) v3.0

For problems or questions on this program, please contact
 Daniela Pamplona <daniela.pamplona@mail.com>


== Overview ==

The folder functionsAux contains auxiliar functions like changing coordinates, convert radians to degrees, etc.
The file run_me.m shows how to use this code, from loading the patch to project it into a sphere, and get the naturalistic input.

Planar images are defined in 2D planes, therefore only 2 coordinates (u,v) are necessary to get pixel values.
However, when these images are projected onto a sphere, the image become defined in a 3D
surface, so we need 3 coordinates to get the pixel value.
To work with the 3D image is very complex, and most of the frameworks on computer vision would not work with such input.
Therefore, the spherical patch is reprojected onto
the tangent plan to the sphere in the center of the patch. The complete procedure has three steps (all inside of the function
planar2sphere_composite):

1) Project the planar image onto a sphere:functions projective2sphere_form
and sphere2projective_form. They are defined such they can be used as tform structure in matlab.

2) Reproject these patches onto the tangent plan to the sphere at
center of the patch. For that we use the functions stereographic_proj_center_form and inv_stereographic_proj_center_form (also inside of the planar2sphere_composite)

3) Finally, these patches are rotated to the horizontal plan, by the functions rot_plan_form and inv_rot_plan_form.

The step 1 is the one that gives rise to the image in Figure 1.d) of the paper.


== Recomendations ==

The step 2 introduces distortions on the image patch that depend on the distance to the center of the patch, therefore one should not use very large patches (it also depends on the parameters of the image patch, resolution, and imaging system. In our case we use patches of 128x128 pixels)

One should not project the entire image to the sphere and project it into a plane, it will introduce a lot of distortions not related with the imaging of the eye, but with the second projection. 

To work directly with the spherical image, one can use the functions projective2sphere_form and sphere2projective_form, assuming that the input is a planar (projective) image (might need some small extra adjustments).


== Software dependencies ==
 
* Matlab R2012a (maybe works correctly in older versions)
* Image Processing Toolbox for Matlab


== References ==

[1] Pamplona, Triesch, Rothkopf, 2013, Power spectra of the natural input to the visual system, Vision Research

# PS_natural_input
