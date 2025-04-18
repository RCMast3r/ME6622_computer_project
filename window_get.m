function [windows] = window_get(data,ms_opt, centers)
%WINDOW_GET Summary of this function goes here
%   Detailed explanation goes here
    windows = {};
    i = 1;
    
    for i_inner=1:(length(centers))
        
        start_ind = centers(i_inner) - ((ms_opt(i_inner)/2))+1;
        end_ind = centers(i_inner) + ((ms_opt(i_inner)/2));
        windows{i} = data(:, max(start_ind, 1):min(end_ind, length(data)));
        i = i+1;
    end
end

