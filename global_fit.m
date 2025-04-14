function [A_res, polynomials_a0_am] = global_fit(A_samples, t, fit_dim)

% goal, fit the mth-order polynomial to the A samples and give the
% resulting fit polynomial function coefficients 

% we can use a built-in function for the solving the set of linear
% equations for the curve fit, however we have to come up with our own
% version of polyfit essentially


% to solve for the Nth dimensional M+1, M+1 dimensional least squares, we
% can create a vandermonde matrix with our elements

x_mat = zeros(fit_dim +1, fit_dim+1);
for i=1:(fit_dim+1) % row
    for j=1:(fit_dim+1) % col
        x_mat(i, j) = sum(t.^((i-1)+(j-1)));
        (i-1)+(j-1);
    end
end

y_x = zeros(fit_dim+1, 1);

for i=1:(fit_dim+1)
    y_x(i, 1) = sum(A_samples.*(t.^(i-1)));
end

% x_mat * poly = y_x
polynomials_a0_am = x_mat\y_x;

A_res = zeros(size(t));
for i = 0:fit_dim
    A_res = A_res + polynomials_a0_am(i+1) * t.^i;
end

end

