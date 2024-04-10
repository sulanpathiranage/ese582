%% Homework 2
%% Introduction
% * Author:                   Sulan Pathiranage
% * Class:                    ESE 582
% * Date:                     Updated 1/30/23

%% transformRays(M, input_y, input_theta)
function [y_out,theta_out] = transformRays(M,y_in,theta_in)
    product = M * [y_in; theta_in];
    y_out = product(1,:);
    theta_out = product(2,:);
end