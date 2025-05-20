function A_inv = pseudo_inverse(A,d)
    [M, ~] = size(A);
    if (M - 1) < d
        A_inv = A' * inv(A * A');
    else
        A_inv = inv(A' * A) * A';
    end
end