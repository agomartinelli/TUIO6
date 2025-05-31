function [MU, NU] = ComputeMu(sys)

    x = sys.x;
    t = sys.time;
    g0 = sys.g0;
    g = sys.g;

    m = sys.deg;
    ht = sys.ht;

    X = [t; x];

    G(:,1) = [1; g0];
    for j = 1:m
        G = [G, [0; g(:, j)]];
    end
    Ht = [t, ht];

    MU = RecMat(X, G, Ht);
    NU = inv(MU);

end

