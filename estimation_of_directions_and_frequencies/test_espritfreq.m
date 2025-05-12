%% test of modified ESPRIT algorithm with no noise
% parameters
M = 5;
N = 20;
Delta = 1/2;
theta = [-20, 30];
f = [0.1, 0.3];
SNR = 100; % almost no noise

%% generating data with parameters
[X, ~, ~] = gendata(M, N, Delta, theta, f, SNR);

%% ESPRIT to estimate frequencies
f_est = espritfreq(X, length(f));

%% comparison of actual vs. estimated frequencies
fprintf('True frequencies: %s\n', mat2str(f, 4));
fprintf('Estimated frequencies: %s\n', mat2str(f_est', 4));
fprintf('Estimation error: %s\n', mat2str(sort(f)-f_est', 4));