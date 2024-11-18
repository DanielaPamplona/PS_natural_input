function [x_sphere, y_sphere, z_sphere, mu] = inv_stereographic_proj_center(x_proj_matrix, y_proj_matrix, z_proj_matrix, r, xs,ys,zs)
    %mu = 4 *r^2./(x_proj_matrix.^2 + y_proj_matrix.^2+z_proj_matrix.^2+2*r*z_proj_matrix+4*r^2); 
    NP = [-xs, -ys, -zs-2*r];
    mu = 4*r^2./(x_proj_matrix.^2 + y_proj_matrix.^2+z_proj_matrix.^2+2*r*(2*r+z_proj_matrix));
    x_sphere = NP(1) + mu.*(x_proj_matrix-NP(1));
    y_sphere = NP(2) + mu.*(y_proj_matrix-NP(2));
    z_sphere = NP(3) + mu.*(z_proj_matrix-NP(3));
