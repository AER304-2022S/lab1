function [beta, sigma, hw] = lin_reg(x, y)
    X = [ones(size(x)) x];
    beta = X\y;
    sigma = sqrt(1/(size(x, 1) - 2) * norm(X*beta - y)^2);
    SIGMA = sigma^2 * inv(X'*X);
    t_inv = tinv(.975, size(x, 1) - 2);

    hw = t_inv * sqrt(SIGMA(2, 2));
end

