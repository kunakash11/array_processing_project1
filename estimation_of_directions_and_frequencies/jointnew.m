function [theta, f] = jointnew(X, d, m)
    % Algorithm for joint estimation of directions and frequencies
    % X: received data matrix (M x N)
    % d: number of sources
    % m: smoothing factor in time
    % theta: estimated angles (in degrees)
    % f: estimated (normalized) frequencies

    % dimensions
    [M, N] = size(X);

    % step 1: spatio-temporal data matrix (M*m x (N-m+1))
    Xm = [];
    for i = 1:m
        Xm = [Xm; X(:, i:N-m+i)];
    end

    % step 2: signal subspace via SVD
    [U, ~, ~] = svd(Xm, "econ");
    Us = U(:, 1:d); % signal subspace (M*m x d)

    % step 3: space and time-shift operators
    % time - shift by one antenna, extend to smoothed structure
    J1_time = kron(eye(m), [eye(M-1), zeros(M-1, 1)]);
    J2_time = kron(eye(m), [zeros(M-1, 1), eye(M-1)]);

    % space - shift by one smoothing window
    J1_space = kron([eye(m-1), zeros(m-1, 1)], eye(M));
    J2_space = kron([zeros(m-1, 1), eye(m-1)], eye(M));

    % step 4: shift-invariant matrices
    Us1_space = J1_space * Us;
    Us2_space = J2_space * Us;

    Us1_time = J1_time * Us;
    Us2_time = J2_time * Us;

    % step 5: covariance matrices
    A_space = pinv(Us1_space) * Us2_space;
    A_time = pinv(Us1_time) * Us2_time;
    A = [A_space, A_time];

    % step 5: joint diagonalization
    [V, D] = joint_diag(A, 1e-10);

    lambda_space  = diag(D(:, 1:d));   % A_theta → angle
    lambda_time = diag(D(:, d+1:2*d)); % A_phi → frequency

    f = mod(angle(lambda_space)/(2*pi), 1); % normalize in [0, 1)
    f = sort(f);

    theta = asind(-angle(lambda_time)/pi);
    theta = sort(theta);
end