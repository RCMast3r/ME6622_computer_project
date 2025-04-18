function [ret] = window_optimal_points(data, ms, ns)
best_ms = [];  % best m for each center
center_indices = [];

for n_ind = 1:length(ns)
    n = ns(n_ind);

    for i_inner = (n/2):n:(length(data))
        min_var = inf;
        best_m = NaN;

        for m_ind = 1:length(ms)
            m = ms(m_ind);

            start_ind = round(i_inner - m/2 + 1);
            end_ind = round(i_inner + m/2);

            if start_ind < 1 || end_ind > length(data)
                continue;  % skip windows that go out of bounds
            end

            window = data(:, start_ind:end_ind);
            window_var = var(window(:));  % variance across all elements

            if window_var < min_var
                min_var = window_var;
                best_m = m;
            end
        end

        best_ms(end+1) = best_m;
        center_indices(end+1) = i_inner;
    end

end
ret.windows = window_get(data, best_ms, center_indices);
ret.ms = best_ms;
ret.center_indices = center_indices;

end