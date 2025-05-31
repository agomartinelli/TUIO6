function ho = LieDer(f, h, x)
    u = jacobian(h, x);
    ho = u * f;
    ho = simplify(ho);
end

