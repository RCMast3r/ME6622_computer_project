close all;
% 1. Select an appropriate discretization level for your data.
t_over_T = 0.001:0.001:1; % 0.001 discretization level for now (1000 points)
f_m = 0.5; %hz
f_c = 4.*((t_over_T).^2);
% pure signal:
A_over_A_0 = (sin(2.*pi.*f_m*t_over_T).^2).*abs((sin(2.*pi.*f_c.*t_over_T)));



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



[p_x_1, x_1]= pdf_est(300, t_over_T, e1_noise_numbers);
[p_x_2, x_2] = pdf_est(300, t_over_T, e2_noise_numbers);

figure;
subplot(2, 1, 1)
plot(x_1, p_x_1);
subplot(2, 1, 2)
plot(x_2, p_x_2);

% A_affected = A~ which is the noise-ily scaled and noise-ily offset signal

a_1 = 0.2;
a_2 = 0.46;
A_affected = (1 + a_1.*e1_noise_numbers.*(t_over_T)).*(A_over_A_0) + (a_2.*e2_noise_numbers.*(t_over_T));
figure;
subplot(2,1,1)
plot(t_over_T, A_affected)
subplot(2,1,2)
plot(t_over_T, A_over_A_0)
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
A_piecewise_fits={};
piecewise_fit_t={};
A_global_fits={};


piecewise_plot_ind = 2;
for poly_fit_deg = 1:10
    
    [A_global_fit, p] = global_fit(A_over_A_0, t_over_T, poly_fit_deg);
    A_global_fits{poly_fit_deg}=A_global_fit;
    % piecewise_fit uses the global fit over sub-sets of the data
    % characterized by the width of the windows and the center point
    % distance from the first point (number of points in the window = odd) 
    [A_piecewise_fit, t, pp] = piecewise_fit(A_over_A_0, t_over_T, poly_fit_deg, 50, 50);
    A_piecewise_fits{poly_fit_deg}=A_piecewise_fit;
    piecewise_fit_t{poly_fit_deg}=t;



    % optimal fit is about varying the window width and the order of the
    % polynomial that is being fit throughout that window. one way of doing
    % this is by looking at the slop in each window to determine what
    % polynomial order to fit. 
    % 
    % what I am thinking is that we can look at
    % the variance of the data in a specific window

    % algorithm goes as follows: 
    % 
    % start with the piecewise fitting function
    % as the basis along with window width "bounds" (10:10:100) along with a
    % static center distance width overlap for each bound [center_widths =
    % (10:10:100)-(1:10)]. the window width is swept to find the width with
    % the least variances. the entire waveform is split into "optimal
    % window widths".
    % 
    % once the window widths have been selected, each window will have its 
    % variance in slopes between point pairs determeined. these are then 
    % used to identify the order of the polynomial fit. the polynomial
    % range will be from 1:25. it will be assumed that the variance in 
    % slopes between any two points is associated with higher order 
    % polynomial fit over the window.

    %A_optimal_fit = optimal_fit(A_over_A_0, t_over_T, poly_fit_deg);

    global_res_clean = rmse(A_global_fit, A_over_A_0)
    piecewise_res_clean = rmse(A_piecewise_fit, A_over_A_0)
    %optimal_res_clean = rmse(A_optimal_fit, A_over_A_0);

% repeating for noisy data
    %[A_global_fit , polynomials_gfit]= global_fit(A_over_A_0, t_over_T, poly_fit_deg);
    %A_piecewise_fit = piecewise_fit(A_over_A_0, t_over_T, poly_fit_deg, 50, 40)
    %A_optimal_fit = optimal_fit(A_over_A_0, t_over_T, poly_fit_deg);

    %global_res_w_noise = rmse(A_global_fit, A_over_A_0);
    %piecewise_resw_noise = rmse(A_piecewise_fit, A_over_A_0);
    %optimal_resw_noise = rmse(A_optimal_fit, A_over_A_0);
end


figure;
for ind=1:10
    subplot(10,1,ind);
    plot(piecewise_fit_t{ind}, A_piecewise_fits{ind});
end

figure;
for ind=1:10
    subplot(10,1,ind);
    plot(t_over_T, A_global_fits{ind});
end


