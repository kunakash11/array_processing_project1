function theta = esprit(X, d)
    % ESPRIT algorithm for estimating angles of arrival
    % X: received signal matrix (M x N)
    % d: number of sources
    % theta: estimated angle (in degrees)

    % dimensions
    [M, ~] = size(X);

    % step 1: SVD of X
    [U, ~, ~] = svd(X, "econ");

    % step 2: extract signal subspace (first d columns of U)
    Us = U(:, 1:d);

    % step 3: selection matrices
    J1 = [eye(M-1), zeros(M-1, 1)]; % first M-1 rows
    J2 = [zeros(M-1, 1), eye(M-1)]; % last M-1 rows

    % step 4: subspaces
    Us1 = J1 * Us;
    Us2 = J2 * Us;

    % step 5: solve invariance equation - Us1 * Phi = Us2
    % using LS solution: Phi = (Us1' * Us1)^(-1) * Us1' * Us2
    Phi = pinv(Us1) * Us2;

    % step 6: eigendecomposition of Phi
    [~, D] = eig(Phi);

    % step 7: phases of eigenvalues
    lambda = diag(D);

    % step 8: eigenvalues to angles
    % sin(theta) = -angle(lambda)/(2*pi*Delta)
    % assuming Delta = 1/2
    sin_theta = -angle(lambda)/(pi);

    % step 9: angles in degrees
    theta = asind(sin_theta);

    % sort angles
    theta = sort(theta);
end
