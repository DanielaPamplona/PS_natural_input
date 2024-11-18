function U =  inv_project_img_coord_tan_plane_form(X, T )
r = T.tdata(1);
theta = T.tdata(2);
phi = T.tdata(3);


x1_grid = X(:,1);
y1_grid = X(:,2);

[x_grid, y_grid] = int2hom(x1_grid, y1_grid);


z_grid = -2*r* ones(size(y_grid));


 [xc, yc, zc] = angles2sphere(r, theta, phi);

[x_rot,y_rot,z_rot] = inv_rot_plan(x_grid,y_grid,z_grid, xc, yc, zc,r);
[x_proj_sphere, y_proj_sphere, z_proj_sphere] = inv_stereographic_proj_center(x_rot,y_rot,z_rot, r, xc,yc,zc);
[x_matrix,y_matrix, z_matrix] = sphere2projective(x_proj_sphere, y_proj_sphere, z_proj_sphere);
[x1_matrix, y1_matrix] = hom2int(x_matrix, y_matrix);

%U = [x1_matrix; y1_matrix]';
U = [x1_matrix(:), y1_matrix(:)];
end