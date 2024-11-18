function U = sphere2projective_form(X,options)
% project points on the sphere to the projective plan
%X are the coordinates (intrinsic)
% options are the extra parameters (r,epsilon,chi) (angular positions)

x1_grid = X(:,1);
y1_grid = X(:,2);
z1_grid = X(:,3);
% r = options.tdata(1);

[x_grid, y_grid] = int2hom(x1_grid, y1_grid);
z_grid = z1_grid;
r_sqrt = x_grid.^2+y_grid.^2+z_grid.^2;
norm = r_sqrt./(z_grid.^2);
x_grid_proj =  norm.*x_grid;
y_grid_proj =  norm.*y_grid;
z_grid_proj =  norm.*z_grid;
[x1_grid_proj, y1_grid_proj] = hom2int(x_grid_proj, y_grid_proj); 
U = [x1_grid_proj, y1_grid_proj];


