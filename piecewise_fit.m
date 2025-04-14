function [A_res, polynomials_a0_am] = piecewise_fit(A_samples, t, fit_dim, window_width, center_increment)

% 1. gather all of the window points. 
% window_points = points[(i + center_increment - (window_width /2)) : 
%   min((i + center_increment + (window_width /2)), length(points))]


    function [points] = window_points(p, window_width, center_increment)
        points_cell_array = {};  % Initialize as cell array
        ind = 1;
    
        for i = 1:center_increment:length(p)
            range_l = max((i - window_width / 2) + 1, 1)
            range_r = min((i + ceil(window_width / 2)), length(p))
            
            window = p(range_l:range_r);
            points{ind} = window;
            ind = ind + 1;
        end



    end

polynomials_a0_am = [];

y_points = window_points(A_samples, window_width, center_increment);
x_points = window_points(t, window_width, center_increment);


end
