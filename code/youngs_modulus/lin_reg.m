function [beta, sigma] = lin_reg(x, y)
    X = [ones(size(x)) x];
    beta = X\y;
    sigma = sqrt(1/(size(x, 1) - 2) * norm(X*beta - y)^2);
end

