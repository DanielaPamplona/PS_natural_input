function [x_matrix, y_matrix, z_matrix] = angles2projective(r_matrix, epsilon_matrix, chi_matrix)
% tranform angular coordinates in the sphere into projective coordinates in the plane
% r_matrix, epsilon_matrix, chi_matrix, angular coordinates in the sphere ( NOT SPHERICAL COORDINATES)
% x_matrix, y_matrix, z_matrix, projective coordinates
z_matrix = -2*r_matrix;
x_matrix = 2*r_matrix.*tan(epsilon_matrix).*cos(chi_matrix);
y_matrix = x_matrix.*tan(chi_matrix);
