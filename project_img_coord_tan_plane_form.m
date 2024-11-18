function U =  project_img_coord_tan_plane_form(X, T )
x1_grid = X(:,1);
y1_grid = X(:,2);
r = T.tdata(1);
epsilon = T.tdata(2);
chi = T.tdata(3);
[x_grid, y_grid] = int2hom(x1_grid, y1_grid);

% z_grid = -2*r* ones(size(y_grid));


[xs, ys, zs] = angles2sphere(r, epsilon, chi);


[x_sphere, y_sphere, z_sphere] = projective2sphere(x_grid, y_grid, r);

[x_proj_matrix, y_proj_matrix, z_proj_matrix] = stereographic_proj_center(x_sphere, y_sphere, z_sphere, r, xs,ys,zs);

[x_proj_matrix_ort, y_proj_matrix_ort,z_proj_matrix_ort] = rot_plan(x_proj_matrix,y_proj_matrix,z_proj_matrix, xs, ys, zs,r);

% x_proj_matrix_ort

[x1_proj_matrix_ort, y1_proj_matrix_ort] = hom2int(x_proj_matrix_ort, y_proj_matrix_ort);
U = [x1_proj_matrix_ort, y1_proj_matrix_ort];




end