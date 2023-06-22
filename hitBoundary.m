function [isReachedBoundary,d] = hitBoundary(z,uz,layer_num,zBoundary,mut,step)
    % finding the distance to the closest boundary:
    if uz == 0                                  % parallel to boundary.
        d = inf;
    elseif uz > 0                               % moving forward - checking distance to next boundary.
        d = (zBoundary(layer_num)-z)/uz;
    elseif layer_num > 1
        d = (zBoundary(layer_num-1)-z)/uz;      % if we have more than one layer.
    else
        d = -z/uz;                              % moving backward
    end
    
    % flag that will indicate if we hit the boundary, used in main.
    if step < d*mut                                 
        isReachedBoundary = 0;        % did not reached boundary.
    elseif step >= d*mut
        isReachedBoundary = 1;        % reached boundary.
    end
end