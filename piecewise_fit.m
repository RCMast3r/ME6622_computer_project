function [A_res, polynomials_a0_am] = piecewise_fit(A_samples, t, fit_dim, window_width, center_increment)

% 1. gather all of the window points. 
% window_points = points[(i + center_increment - (window_width /2)) : 
%   min((i + center_increment + (window_width /2)), length(points))]


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
    
        if mod(m,2) == 0
            offset_left = m/2;
            offset_right = m/2 - 1;
        else
            offset_left = floor(m/2);
            offset_right = floor(m/2);
        end
    
        centers = n:n:length(data);  % periodic centers
        valid_centers = centers(centers - offset_left >= 1 & centers + offset_right <= length(data));
    
        num_windows = length(valid_centers);
        windows = zeros(m, num_windows);
    
        for i = 1:num_windows
            c = valid_centers(i);
            windows(:,i) = data(c - offset_left : c + offset_right);
        end
    end


polynomials_a0_am = [];

y_points = window_points(A_samples, window_width, center_increment);
x_points = window_points(t, window_width, center_increment);

A_res=[];
for i=1:length(x_points)
    [A_res_i, ps] = global_fit(y_points{i}, x_points{i}, fit_dim)
    polynomials_a0_am = cat(2, polynomials_a0_am, ps);
    A_res = cat(2, A_res, A_res_i);
end

end
