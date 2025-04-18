function windows = window_points(data, m, n)
%SELECT_PERIODIC_WINDOWS Selects windows of width m centered at intervals of n
%
% Inputs:
%   data - Input vector (1D)
%   n    - Period (distance between window centers)
%   m    - Window width (must be odd or even)
%
% Output:
%   windows - Matrix of size (m x num_windows), each column is a window
    windows = {};
    i = 1;
    
    for i_inner=(n/2):n:(length(data))

        start_ind = i_inner - ((m/2))+1;
        end_ind =i_inner + ((m/2));
        windows{i} = data(:, max(start_ind, 1):min(end_ind, length(data)));
        i = i+1;
    end

end