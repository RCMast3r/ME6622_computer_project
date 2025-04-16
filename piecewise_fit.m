function [A_res, t, polynomials_a0_am] = piecewise_fit(A_samples, t, fit_dim, window_width, center_increment)

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
        windows = {};
        i = 1;
        
        for i_inner=(center_increment/2):center_increment:(length(data))

            start_ind = i_inner - ((window_width/2))+1;
            end_ind =i_inner + ((window_width/2));
            windows{i} = data(:, max(start_ind, 1):min(end_ind, length(data)));
            i = i+1;
        end

    end


polynomials_a0_am = {};

y_points = window_points(A_samples, window_width, center_increment);
x_points = window_points(t, window_width, center_increment);
A_res_init={};
t_res={};
% gather the results of each piecewise fit
for i=1:length(x_points)
    if(length(x_points)>1)
        [A_res_init{i},  polynomials_a0_am{i}]= global_fit(y_points{i}, x_points{i}, fit_dim);
        t_res{i}=x_points{i};
    else
        % else we concatenate with the last non-singular length one in the
        % bunch and recalculate
        A_res_init{i}=x_points{i-1}.*polynomials_a0_am{i-1};
        t_res{i}=x_points{i};
    end
end

% Step 1: Flatten the data
all_t = [];
all_A = [];

for i = 1:length(t_res)
    all_t = [all_t, t_res{i}];        % concatenate all time points
    all_A = [all_A, A_res_init{i}];        % concatenate corresponding A_res values
end

% Step 2: Get unique times and average the A_res for each unique time
[unique_t, ~, idx] = unique(all_t);   % idx maps all_t to unique_t

A_res = zeros(size(unique_t));

for i = 1:length(unique_t)
    A_res(i) = mean(all_A(idx == i));  % average A_res values for same time
end
t=unique_t;
end
