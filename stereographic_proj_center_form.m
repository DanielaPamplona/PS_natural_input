function U = stereographic_proj_center_form(X,T)
%invert the stereographic projection
%X are the coordinates (intrinsic)
% T are the extra parameters (r,epsilon,chi) (angular positions)
x1_grid = X(:,1);
y1_grid = X(:,2);
z1_grid = X(:,3);

r = T.tdata(1);
epsilon = T.tdata(2);
chi = T.tdata(3);
[xs, ys, zs] = angles2sphere(r, epsilon, chi);
[x_matrix, y_matrix] = int2hom(x1_grid, y1_grid);
z_matrix = z1_grid;
%the points should be in homogeneous coordinates
NP = [-xs, -ys, -zs-2*r];
%mu = (2 *r^2 )./(x_matrix*xs+ y_matrix*ys+z_matrix*zs + r*(z_matrix+ 2*r+zs));
mu = 2*r^2./(x_matrix*xs+ y_matrix*ys+z_matrix*(zs+r)+r*(zs+2*r));
x_proj_matrix = NP(1) + mu.*(x_matrix-NP(1));
y_proj_matrix = NP(2) + mu.*(y_matrix-NP(2));
z_proj_matrix = NP(3) + mu.*(z_matrix-NP(3));

[x1_proj_matrix, y1_proj_matrix] = hom2int(x_proj_matrix, y_proj_matrix);
z1_proj_matrix = z_proj_matrix;
U = [x1_proj_matrix, y1_proj_matrix,z1_proj_matrix];
