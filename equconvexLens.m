%% Homework 3
%% Introduction
% * Author:                   Sulan Pathiranage
% * Class:                    ESE 582
% * Date:                     Updated 2/05/23

close all
clear all 

%% Biconvex lens design -- INCOMPLETE
t = 3.45/1000; %3.45mm
n2 = 1.673;
f = 9/1000; % 9 mm
p_sys = 1/f;
gullstrands = [t/n2 -2 f]; %quadratic equation 
p_equation = roots(gullstrands);
p_lens = p_equation(2); %reject smaller radius
radii = (n2 - 1)/p_lens;

% Converting to two spherical bounds
d1 = 0.012;
y = 0.003;
n1 = 1;
y_in = [y];
%theta_focal = (-(n1-n2)/(n2*-radii))*y;
%theta_focal = (-(n2-n1)/(n1*radii))*y;
%theta_focal = (2*y*(n1-n2))/n1;
theta_in = [0];

% Matrices

M_1 = MfreeSpace(d1);
[y_fs1, theta_fs1] = transformRays(M_1, y_in, theta_in);

M_2 = Mspherical(n1, n2, radii);
[y_thick_i, theta_thick_i] = transformRays(M_2, y_fs1, theta_fs1);

M_3 = MfreeSpace(t);
[y_thick_1, theta_thick_1] = transformRays(M_3, y_thick_i, theta_thick_i);

M_4 = Mspherical(n2, n1, -radii);
[y_thick_f, theta_thick_f] = transformRays(M_4, y_thick_1, theta_thick_1);

M_5 = MfreeSpace(d1);
[y_out, theta_out] = transformRays(M_5, y_thick_f, theta_thick_f);

%plotting
subplot(2,1,1), plot([-d1-(t/2) -t/2 t/2 t/2+d1], [y_in(1) y_fs1(1) y_thick_1(1) y_out(1)]); hold on
        %plot([-d1-(t/2) -t/2 t/2 1+t/2], [y_in(2) y_fs1(2) y_thick_1(2) y_out(2)]); hold on
        %plot([-2 2], [0 0]), hold on
        plot([-(t/2) -(t/2)], [-1 1]), hold on
        plot([(t/2) (t/2)], [-1 1]), hold on
        ylim([0.0029994 y+0.0000001]),legend("Parallel Ray", "Front Surface", "Back Surface"),   xlabel("Z (m)"), ylabel("Y (m)"), title("Equiconvex");
        %xlim([-d1-0.01 d1+0.01]), ylim([0.0029994 0.00300001]);
        %xlim([-d1-0.01 0.065]),  legend("Parallel Ray", "Focal Ray", "Optical Axis","Front Surface", "Back Surface"), xlabel("Z (m)"), ylabel("Y (m)"), title("Equiconvex");


%% Planoconvex lens design

t = 3.45/1000; %3.45mm
n2 = 1.673;
f = 9/1000; % 9 mm
p_lens = 1/f;
%gullstrands = [t/n -2 f]; %quadratic equation 
%p_equation = roots(gullstrands);
radii = (n2 - 1)/p_lens;
% Converting to one spherical bounds
d1 = 0.012;
y = 0.003;
n1 = 1;
y_in = [y y];
%theta_focal = -y/((d1+t)-f);
theta_focal = -y*(n2-n1)/(n1*radii);
theta_in = [0 theta_focal];

% Matrices
M_1 = MfreeSpace(d1);
[y_fs1, theta_fs1] = transformRays(M_1, y_in, theta_in);
M_2 = Mspherical(n1, n2, radii);
[y_thick_i, theta_thick_i] = transformRays(M_2, y_fs1, theta_fs1);
%M_3 = MfreeSpace(t);
%[y_thick_1, theta_thick_1] = transformRays(M_3, y_thick_i, theta_thick_i);
M_4 = MfreeSpace(1);
[y_out, theta_out] = transformRays(M_4, y_thick_i, theta_thick_i);

%Intersection
m1 = (y_out(1)-y_thick_i(1))/(-t/2+1- -t/2);
b1 = y_thick_i(1) - (-(t/2))*m1;
m2 = (y_out(2)-y_thick_i(2))/(-t/2+1- -t/2);
b2 = y_thick_i(2) - (-(t/2))*m2;
P2_x = (b1-b2)/(m2-m1);
P2_y = P2_x*m1 + b1;

%plotting
    subplot(2,1,2), plot([-d1-(t/2) -t/2 -t/2+1], [y_in(1) y_thick_i(1) y_out(1)]); hold on
    plot([-d1-(t/2) -t/2 -t/2+1], [y_in(2) y_thick_i(2) y_out(2)]); hold on
    plot([-2 2], [0 0]), hold on
    plot([-(t/2) -(t/2)], [-1 1]), hold on
    plot([(t/2) (t/2)], [-1 1]), hold on
    plot(-d1-(t/2), y_in(1),Marker=".", MarkerSize=20), hold on
    plot(P2_x, P2_y,Marker=".", MarkerSize=20), hold on
    xlim([-d1-0.01 0.065]), ylim([-0.02 y+0.01]), legend("Parallel Ray", "Focal Ray", "Optical Axis","Front Surface", "Back Surface"), xlabel("Z (m)"), ylabel("Y (m)"), title("PlanoConvex");
    disp("BFL (m) =")
    disp(P2_x)
