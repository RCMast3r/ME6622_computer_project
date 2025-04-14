function [bin_t, bin_counts, d_f_t] = bar_plot(num_cols, t, f_t)

% usage: num_cols = the number of columns to put the f_t results into
         % t = the time vector that f_t was evaluated at 

% plot results: bar(bin_t, bin_counts)
% d_f_t = (x_max - x_min) / k


bin_centers = linspace(-1, 1, num_cols);

bin_counts = zeros(1, length(bin_centers));

d_f_t = 2/length(bin_centers); % (x_max - x_min) / k

% n = bin count in a bin (bin_counts(j))

% N = sample size (length(f_t))

bin_centers = bin_centers + (d_f_t/2);

for i = 1:length(f_t)
    val = f_t(i);
    for j = 1:length(bin_centers)
        if( (val > bin_centers(j) - (d_f_t/2)) && (val < bin_centers(j) + (d_f_t/2)) )
            bin_counts(j) = bin_counts(j) + 1;
        end
    end
end

bin_t = linspace(-1, 1, length(bin_counts));
end

