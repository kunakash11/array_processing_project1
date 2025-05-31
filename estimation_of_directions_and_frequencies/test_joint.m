%% test of joint estimation algorithm with no noise
% parameters
M = 5;
N = 20;
Delta = 1/2;
theta = [-20, 30];
f = [0.1, 0.3];
SNR = 100; % almost no noise
m = 4; % time-smoothing factor

%% generating data with parameters
[X, ~, ~] = gendata(M, N, Delta, theta, f, SNR);

%% function to jointly estimate directions (angles) and frequencies
[theta_est, f_est] = joint(X, length(theta), m);

%% comparison of actual vs. estimated angles and frequencies
fprintf('True angles: %s degrees\n', mat2str(theta, 4));
fprintf('Estimated angles: %s degrees\n', mat2str(theta_est', 4));
fprintf('Estimation error: %s degrees\n', mat2str(sort(theta)-theta_est', 4));

fprintf('\nTrue frequencies: %s\n', mat2str(f, 4));
fprintf('Estimated frequencies: %s\n', mat2str(f_est', 4));
fprintf('Frequency estimation error: %s\n', mat2str(f-f_est', 4));