function dist_matrix = ecc_angles2mm(r_matrix, epsilon_matrix)
% transforms eccentric angles in mm (sometimes the eccentricity is comming mm)
%%%%%%%%%epsilon in rad, r in mm%%%%%%%%%%%%
dist_matrix = 2*r_matrix.*epsilon_matrix;
