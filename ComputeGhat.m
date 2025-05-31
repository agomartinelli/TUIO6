function ghat = ComputeGhat(sys, NU)

    g0 = sys.g0;
    g = sys.g;

    m = sys.deg;

    G(:,1) = [1; g0];
    for j = 1:m
        G = [G, [0; g(:,j)]];
    end

    Ghat = simplify(G * NU);
    ghat = Ghat(2:end, :);

end



