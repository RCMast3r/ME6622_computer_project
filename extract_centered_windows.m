function windows = extract_centered_windows(data, windowWidth, increment)
% extract_centered_windows extracts windows of fixed width at regular increments,
% starting from the first index of the data.
%
% Inputs:
%   - data: 1D array
%   - windowWidth: width of each window (must be odd for symmetric centering)
%   - increment: step size between windows (applies to center after first window)
%
% Output:
%   - windows: matrix (each row is a window)

    if mod(windowWidth, 2) == 0
        error('Window width must be odd for symmetric centering.');
    end

    dataLen = length(data);
    halfWidth = floor(windowWidth / 2);

    % Start with the first window beginning at index 1
    starts = [1, (1 + increment) - halfWidth : increment : dataLen - halfWidth]

    windows = [];

    for s = starts
        startIdx = s;
        endIdx = s + windowWidth - 1;

        % Pad with NaNs if out of bounds
        if startIdx < 1 || endIdx > dataLen
            window = nan(1, windowWidth);
            validStart = max(startIdx, 1);
            validEnd = min(endIdx, dataLen);
            windowStart = validStart - startIdx + 1;
            windowEnd = windowStart + (validEnd - validStart);
            window(windowStart:windowEnd) = data(validStart:validEnd);
        else
            window = data(startIdx:endIdx);
        end

        windows = [windows; window];
    end
end
