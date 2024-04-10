%% Homework 3
%% Introduction
% * Author:                   Sulan Pathiranage
% * Class:                    ESE 582
% * Date:                     Updated 1/30/23

%% MplanarBound (n1, n2)
function M = MplanarBound(n1, n2)
    % y2 = y1
    % 02 = n1/n2 * 01
    M = [1, 0; 0, n1/n2];
end
