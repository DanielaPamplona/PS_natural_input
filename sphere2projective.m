function [xh, yh, zh] = sphere2projective(x1,y1,z1)

r_sqrt = x1.^2+y1.^2+z1.^2;
norm = r_sqrt./z1.^2;
xh = x1.*norm;
yh = y1.*norm;
zh = z1.*norm;


