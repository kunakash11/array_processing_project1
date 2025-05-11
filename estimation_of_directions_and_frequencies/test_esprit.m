%% test of ESPRIT algorithm with no noise
% parameters
M = 5;
N = 20;
Delta = 1/2;
theta = [-20, 30];
f = [0.1, 0.3];
SNR = 100; % almost no noise

%% generating data with parameters
[X, ~, ~] = gendata(M, N, Delta, theta, f, SNR);

%% ESPRIT to estimate directions (angles)
theta_est = esprit(X, length(theta));

%% comparison of actual vs. estimated angles
fprintf('True angles: %s degrees\n', mat2str(theta, 4));
fprintf('Estimated angles: %s degrees\n', mat2str(theta_est', 4));
fprintf('Estimation error: %s degrees\n', mat2str(sort(theta)-theta_est', 4));