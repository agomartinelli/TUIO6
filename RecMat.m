function RM = RecMat(x, g, h)
    p = length(h);
    mww = size(g);
    mw = mww(2);
    RM = [];
    
    for i = 1:p
        RMrow = [];
        hi = h(i);
        for j = 1:mw
            gj = g(:, j);
            RMrow = [RMrow, LieDer(gj, hi, x)];
        end
        RM = [RM; RMrow];
    end

return
