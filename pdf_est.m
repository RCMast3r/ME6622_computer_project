function [p_x, x] = pdf_est(num_cols, t, f_t)
% usage: sum(p_x) should be 1, plot(linspace(-1, 1, length(p_x)), p_x*100);
% gives the pdf estimation
%PDF_EST the relative probability of the values.
% to do this we can simply normalize the bin center counts by the number of
% bins
[bin_t, bin_counts, d_f_t] = bar_plot(num_cols, t, f_t);
p_x = bin_counts / sum(bin_counts);

x = linspace(-1, 1, length(bin_counts));
end

