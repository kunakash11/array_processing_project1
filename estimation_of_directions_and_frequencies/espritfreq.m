function f = espritfreq(X, d)
    % modified ESPRIT algorithm for estimating frequencies
    % X: received signal matrix (M x N)
    % d: number of sources
    % f: estimated (normalized) frequencies

    % dimensions
    [~, N] = size(X);

    % step 1: SVD of X
    [~, ~, V] = svd(X, "econ");

    % step 2: extract signal subspace (first d columns of V)
    % SVD returns V' in MATLAB - using columns
    Vs = V(:, 1:d);

    % step 3: selection matrices
    J1 = [eye(N-1), zeros(N-1, 1)]; % first M-1 rows
    J2 = [zeros(N-1, 1), eye(N-1)]; % last M-1 rows

    % step 4: subspaces
    Vs1 = J1 * Vs;
    Vs2 = J2 * Vs;

    % step 5: solve invariance equation - Vs1 * Psi = Vs2
    % using LS solution: Psi = (Vs1' * Vs1)^(-1) * Vs1' * Vs2
    Psi = pinv(Vs1) * Vs2;

    % step 6: eigendecomposition of Psi
    [~, D] = eig(Psi);

    % step 7: extract eigenvalues
    lambda = diag(D);

    % step 8: eigenvalues to frequencies
    % f = angle(lambda)/(2*pi)
    f = -angle(lambda)/(2*pi);

    % step 9: frequencies in [0, 1)
    f = mod(f, 1);

    % sort angles
    f = sort(f);
end