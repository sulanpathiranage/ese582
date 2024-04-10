%% Homework 2
%% Introduction
% * Author:                   Sulan Pathiranage
% * Class:                    ESE 582
% * Date:                     Updated 1/30/23

%% Mthinlens(focal length)
function M = MthinLens(f)
    M = [1 0; -1/f 1];
end
