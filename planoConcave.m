%% Plano-Concave Lens
%% Introduction
% * Author:                   Sulan Pathiranage
% * Class:                    ESE 582
% * Date:                     Updated 2/19/23

clear all
close all
%% Plano-Concave

t = 1.5;
n_lens = 1.78472;
f = -9;
p_sys = 1/f;
p_lens = p_sys; 
radii = (n_lens - 1)/p_lens;

d1 = 12;
y = 3;
n_space = 1;
y_in = [y];
theta_in = [0];

% Matrices

M_1 = MfreeSpace(d1);
M_2 = Mspherical(n_space, n_lens, radii);
M_3 = MfreeSpace(t);
M_4 = MplanarBound(n_lens, n_space);
M_5 = MfreeSpace(d1);
Msys = M_5*M_4*M_3*M_2*M_1;

[y_fs1, theta_fs1] = transformRays(M_1, y_in, theta_in);
[y_thick_i, theta_thick_i] = transformRays(M_2, y_fs1, theta_fs1);
[y_thick_1, theta_thick_1] = transformRays(M_3, y_thick_i, theta_thick_i);
[y_thick_f, theta_thick_f] = transformRays(M_4, y_thick_1, theta_thick_1);
[y_out, theta_out] = transformRays(M_5, y_thick_f, theta_thick_f);

x = [-d1-t/2 d1+t/2];
axis = ones(size(x))*0;
m_parallel = (y_thick_f(1) - y_out(1))/(t/2 - t/2+d1);
b_parallel = y_out(1) + m_parallel*(t/2 +d1);
y_parallel = -m_parallel*x +b_parallel;

BFL = -y_thick_f/theta_thick_f;
BFL_point = (t/2)+BFL;
FFL_point = (-t/2) - BFL;


theta_focal = y/(-d1-FFL_point);
[y_fs2, theta_fs2] = transformRays(M_1, y_in, theta_focal);
[y_thick_i2, theta_thick_i2] = transformRays(M_2, y_fs2, theta_fs2);
[y_thick_2, theta_thick_2] = transformRays(M_3, y_thick_i2, theta_thick_i2);
[y_thick_f2, theta_thick_f2] = transformRays(M_4, y_thick_2, theta_thick_2);
[y_out2, theta_out2] = transformRays(M_5, y_thick_f2, theta_thick_f2);

x2 = [-t/2-d1 t/2];
m_focal = 0;
b_focal = y_out2;
y_focal = m_focal*x2 +b_focal;

x_image = (b_focal-b_parallel)/(m_parallel-m_focal);
y_image = x_image*m_parallel + b_parallel;

plot([-d1-(t/2) -t/2 t/2 t/2+d1], [y_in(1) y_fs1(1) y_thick_f(1) y_out(1)]); hold on
plot([-d1-(t/2) -t/2 t/2 t/2+d1], [y_in(1) y_fs2(1) y_thick_f2(1) y_out2(1)]); hold on
plot([-(t/2) -(t/2)], [-1 10]), hold on
plot([(t/2) (t/2)], [-1 10]), hold on
plot(x, axis), hold on
plot(x , y_parallel, ":"), hold on
plot(x2 , y_focal, ":"), hold on

plot(BFL_point, 0,Marker=".", MarkerSize=20), hold on
plot(FFL_point, 0,Marker=".", MarkerSize=20), hold on
plot(-x_image, y_image,Marker=".", MarkerSize=20), hold on
plot(-d1-(t/2), y,Marker=".", MarkerSize=20), hold on

text(-d1-(t/2),y+0.2,"P1","FontSize",10,"FontWeight","bold",...
"HorizontalAlignment","center","VerticalAlignment","baseline");
text(-x_image,y_image+0.2,"P2","FontSize",10,"FontWeight","bold",...
"HorizontalAlignment","center","VerticalAlignment","baseline");
text(BFL_point,0.2,"BFL","FontSize",10,"FontWeight","bold",...
"HorizontalAlignment","center","VerticalAlignment","baseline");
text(FFL_point,0.2,"FFL","FontSize",10,"FontWeight","bold",...
"HorizontalAlignment","center","VerticalAlignment","baseline");
xlim([-d1-(t/2)-1, t/2+d1+1]), ylim([-1, y_out+1]), legend("Parallel Ray", "Focal Ray", "Front Surface", "Back Surface", "Optical Axis", 'Location', 'northwest'),   xlabel("Z (mm)"), ylabel("Y (mm)"), title("Plano-Convex");
