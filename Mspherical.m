%% Homework 3
%% Introduction
% * Author:                   Sulan Pathiranage
% * Class:                    ESE 582
% * Date:                     Updated 1/30/23

%% MsphericalBound (focal length)
function M = Mspherical(n1,n2,R)
    % y2 = (-n1*z2/n2*z1)y1 -> y2 = n1/n2 y
    % 01 = -(n2-n1/n2*R)y + (n1/n2)0
    M = [1, 0; -(n2-n1)/(n2*R), n1/n2];
end
