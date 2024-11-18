function epsilon_matrix = ecc_mm2angles(r_matrix, dist_matrix)
% transforms eccentricity in mm eccentric angles(sometimes the eccentricity is comming mm)
%%%%%%%%%epsilon in rad, r in mm%%%%%%%%%%%%
epsilon_matrix = dist_matrix./(2*r_matrix);
