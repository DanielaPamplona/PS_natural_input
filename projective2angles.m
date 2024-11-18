function [r_matrix, epsilon_matrix, chi_matrix] = projective2angles(x_matrix, y_matrix, z_matrix)
% r_matrix = sqrt(x_matrix.^2+y_matrix.^2+z_matrix.^2);
% 
r_matrix = -z_matrix/2;
epsilon_matrix = atan(sqrt(x_matrix.^2+y_matrix.^2)./-z_matrix);
chi_matrix = atan2(y_matrix,x_matrix);
