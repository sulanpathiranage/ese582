%% Homework 2
%% Introduction
% * Author:                   Sulan Pathiranage
% * Class:                    ESE 582
% * Date:                     Updated 1/31/23
clear all
close all
%% Webcam Imaging

sensor_h = 7.5 / 1000;
obj_h = 375 / 1000;
m = -sensor_h / obj_h;
total_d = 0.375;
d1 = total_d / (1 - m);
d2 = total_d - d1;
f = d1 * d2 / (d1 + d2);
y_obj = 0.1715;
z_obj = 0.375;
theta_center = -y_obj/d1; 
theta_focal = -y_obj/(d1-f);       
y_in = [y_obj, y_obj, y_obj];
theta_in = [0, theta_center, theta_focal];

%Matrices
M_1 = MfreeSpace(d1);
[y_fs1, theta_fs1] = transformRays(M_1, y_in, theta_in);
M_2 = MthinLens(f);
[y_thin, theta_thin] = transformRays(M_2, y_fs1, theta_fs1);
M_3 = MfreeSpace(d2);
[y_out, theta_out] = transformRays(M_3, y_thin, theta_thin);
Msys = M_3*M_2*M_1;
% Finding intersection
m_F2 = (y_out(1)-y_fs1(1))/(d2-0);
F2 = -y_fs1(1)/m_F2;
m_F1 = (y_in(3)-y_fs1(3))/(-d1-0);
F1 = -y_fs1(3)/m_F1;
%plottng
figure(1)
plot1 = plot([-d1 0 d2], [y_in(1) y_fs1(1) y_out(1)]); hold on
plot([-d1 0 d2], [y_in(2) y_fs1(2) y_out(2)]), hold on
plot([-d1 0 d2], [y_in(3) y_fs1(3) y_out(3)]), hold on
plot([-0.4 0.05], [0 0]), hold on
plot(F2, 0,Marker="o"), hold on
plot(F1, 0,Marker="o"), hold on
plot([0 0], [-1 1]), xlim([-d1-0.01 d2+0.01]), ylim([y_out(1)-0.1 y_in(1)+0.3]), hold on
legend("Parallel", "Center", "Focal", "Optical Axis","Back Focal", "Front Focal", "Thin Lens"), xlabel("Z (m)"), ylabel("Y (m)"), title("Webcam - 0.375m");

%% Part 2

total_d = 1.375;
d1 = total_d / (1 - m);
d2 = total_d - d1;
f = d1 * d2 / (d1 + d2);
y_obj = 0.1715;
z_obj = 1.375;
theta_center = -y_obj/d1; 
theta_focal = -y_obj/(d1-f);       
y_in = [y_obj, y_obj, y_obj];
theta_in = [0, theta_center, theta_focal];

%Matrices
M_1 = MfreeSpace(d1);
[y_fs1, theta_fs1] = transformRays(M_1, y_in, theta_in);
M_2 = MthinLens(f);
[y_thin, theta_thin] = transformRays(M_2, y_fs1, theta_fs1);
M_3 = MfreeSpace(d2);
[y_out, theta_out] = transformRays(M_3, y_thin, theta_thin);
Msys = M_3*M_2*M_1;

% Finding intersection
m_F2 = (y_out(1)-y_fs1(1))/(d2-0);
F2 = -y_fs1(1)/m_F2;
m_F1 = (y_in(3)-y_fs1(3))/(-d1-0);
F1 = -y_fs1(3)/m_F1;

%plottng
figure(2)
plot2 = plot([-d1 0 d2], [y_in(1) y_fs1(1) y_out(1)]); hold on
plot([-d1 0 d2], [y_in(2) y_fs1(2) y_out(2)]), hold on
plot([-d1 0 d2], [y_in(3) y_fs1(3) y_out(3)]), hold on
plot([-2 2], [0 0]), hold on
plot(F2, 0,Marker="o"), hold on
plot(F1, 0,Marker="o"), hold on
plot([0 0], [-1 1]), xlim([-d1-0.01 d2+0.01]), ylim([y_out(1)-0.1 y_in(1)+0.3]), hold on
legend("Parallel", "Center", "Focal", "Optical Axis","Back Focal", "Front Focal", "Thin Lens"), xlabel("Z (m)"), ylabel("Y (m)"), title("Webcam - 1.375m");
