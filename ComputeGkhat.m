function Gkhat = ComputeGkhat(sys, ghat)

    g = sys.g;
    ht = sys.ht;
    m = sys.deg;
    m_w = sys.m_w;
    
    Gk = g(:, m+1:m_w);
    Gkhat = Gk;

    if m > 0
        gh = ghat(:, 2:end);
        for k = 1:m_w - m
            j = 1;
            sumk = gh(:, j) * LieDer(Gk(:, k), ht(j), sys.x);
            for j = 2:m
                sumk = sumk + gh(:, j) * LieDer(Gk(:, k), ht(j), sys.x);
            end
            Gkhat(:, k) = Gk(:, k) - sumk;
        end
    end
end

