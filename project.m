% 1. Select an appropriate discretization level for your data.
t_over_T = 0.001:0.001:1; % 0.001 discretization level for now (1000 points)
f_m = 0.5; %hz
f_c = 4.*((t_over_T).^2);
% pure signal:
A_over_A_0 = (sin(2.*pi.*f_m*t_over_T).^2).*abs((sin(2.*pi.*f_c.*t_over_T)));

plot(t_over_T, A_over_A_0)

% white noise:

% "random vector is considered to be a white noise vector if its 
% components each have a probability distribution with zero mean and 
% finite variance"


% 2. Select a (known) noise function N(t/T) and determine its PDF.

e1_noise_numbers = randn([1 length(t_over_T)]); % zero-mean guassian noise for e_1
e2_noise_numbers = randn([1 length(t_over_T)]); % zero-mean guassian noise for e_1

% TODO maybe switch to something that I can use to specify more directly
% the PDF arguments?

% TODO use hmwk1 function to get the PDF


p_x_1 = pdf_est(100, t_over_T, e1_noise_numbers);

figure;
plot(t_over_T, p_x);

% A_affected = A~ which is the noise-ily scaled and noise-ily offset signal

a_1 = 0.2;
a_2 = 0.46;
A_affected = (1 + a_1.*e1_noise_numbers.*(t_over_T)).*(A_over_A_0) + (a_2.*e2_noise_numbers.*(t_over_T));

plot(t_over_T, A_affected)

% goodness of fit: 
% normalized root mean squared error (comparison between different sensor ranges)

% root mean squared vs MSE: RMS is provided in the same unit as the target
% variable units(A/A_0)

% chosen goodness of fit: RMSE, due to not needing different sensor range
% comparisons, only one sensor response goodness of fit and this gives the
% goodness of fit in units of the measured data which is already visualized

% RMSE goal 0.01 (1/100th of the scale of the "measured" signal)
% TODO: why is this a good value to shoot for? idk

% before noise

% each needs several different ranges of polynomial degrees

% these fits are described in lectures 2/18/25, 2/20/25
for poly_fit_deg = 1:10
    
    
    A_global_fit = global_fit(A_over_A_0, t_over_T, poly_fit_deg);

    % piecewise_fit uses the global fit over sub-sets of the data
    % characterized by the width of the windows and the center point
    % distance from the first point (number of points in the window = odd) 
    A_piecewise_fit = piecewise_fit(A_over_A_0, t_over_T, poly_fit_deg);

    % 
    A_optimal_fit = optimal_fit(A_over_A_0, t_over_T, poly_fit_deg);

    global_res_clean = rmse(A_global_fit, A_over_A_0);
    piecewise_res_clean = rmse(A_piecewise_fit, A_over_A_0);
    optimal_res_clean = rmse(A_optimal_fit, A_over_A_0);

% repeating for noisy data
    A_global_fit = global_fit(A_over_A_0, t_over_T, poly_fit_deg);
    A_piecewise_fit = piecewise_fit(A_over_A_0, t_over_T, poly_fit_deg);
    A_optimal_fit = optimal_fit(A_over_A_0, t_over_T, poly_fit_deg);

    global_res_w_noise = rmse(A_global_fit, A_over_A_0);
    piecewise_resw_noise = rmse(A_piecewise_fit, A_over_A_0);
    optimal_resw_noise = rmse(A_optimal_fit, A_over_A_0);
end





