function [A_res] = global_fit(A_samples, t, fit_dim)



%GLOBAL_FIT Summary of this function goes here
%   Detailed explanation goes here

% we can use a built-in function for the solving the set of linear
% equations for the curve fit, however we have to come up with our own
% version of polyfit essentially


% to solve for the Nth dimensional M+1, M+1 dimensional least squares, we
% can create a vandermonde matrix with our elements

vander_vec = (sum(t).*ones([1,10]));
vander_mat = fliplr(vander(vander_vec));
% now, we replace the first element in the first row with N (=num of samples)

% TODO look at lsqr() for solving least squares problem
vander_mat(1,1) = length(A_samples);


for i=2:1:(size(A_samples, 1))
    
end


A_res = A_samples;

end

