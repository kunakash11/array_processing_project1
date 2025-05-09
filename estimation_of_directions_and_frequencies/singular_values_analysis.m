%% analysis of singular values
% base parameters
M = 5;
N = 20;
Delta = 1/2;
theta = [-20, 30];
f = [0.1, 0.3];
SNR = 20;

%% case 0: base case
% generating data with base parameters
[X_base, A_base, S_base] = gendata(M, N, Delta, theta, f, SNR);

% computing singular values for base case
sv_base = svd(X_base);

%% case 1: number of samples doubles
N_doubled = 2*N;
[X_more_samples, ~, ~] = gendata(M, N_doubled, Delta, theta, f, SNR);
sv_more_samples = svd(X_more_samples);

%% case 2: number of antennas doubles
M_doubled = 2*M;
[X_more_antennas, ~, ~] = gendata(M_doubled, N, Delta, theta, f, SNR);
sv_more_antennas = svd(X_more_antennas);

%% case 3: small angle separation
theta_close = [-20, -15];
[X_close_angles, ~, ~] = gendata(M, N, Delta, theta_close, f, SNR);
sv_close_angles = svd(X_close_angles);

%% case 4: small frequency separation
f_close = [0.1, 0.11];
[X_close_freq, ~, ~] = gendata(M, N, Delta, theta, f_close, SNR);
sv_close_freq = svd(X_close_freq);

%% plotting singular values
figure(1);
subplot(2, 3, 1);
stem(sv_base, 'LineWidth', 2);
title('Base Case');
xlabel('Index');
ylabel('Singular Value');
grid on;

subplot(2, 3, 2);
stem(sv_more_samples, 'LineWidth', 2);
title('Double Samples (N = 40)');
xlabel('Index');
ylabel('Singular Value');
grid on;

subplot(2, 3, 3);
stem(sv_more_antennas, 'LineWidth', 2);
title('Double Antennas (M = 10)');
xlabel('Index');
ylabel('Singular Value');
grid on;

subplot(2, 3, 4);
stem(sv_close_angles, 'LineWidth', 2);
title('Close Angles ([-20, -15])');
xlabel('Index');
ylabel('Singular Value');
grid on;

subplot(2, 3, 5);
stem(sv_close_freq, 'LineWidth', 2);
title('Close Frequencies ([0.1, 0.11])');
xlabel('Index');
ylabel('Singular Value');
grid on;

% displaying first few singular values
fprintf('Singular values (base case): %s\n', mat2str(sv_base(1:min(6,length(sv_base)))', 4));
fprintf('Singular values (double samples): %s\n', mat2str(sv_more_samples(1:min(6,length(sv_more_samples)))', 4));
fprintf('Singular values (double antennas): %s\n', mat2str(sv_more_antennas(1:min(6,length(sv_more_antennas)))', 4));
fprintf('Singular values (close angles): %s\n', mat2str(sv_close_angles(1:min(6,length(sv_close_angles)))', 4));
fprintf('Singular values (close frequencies): %s\n', mat2str(sv_close_freq(1:min(6,length(sv_close_freq)))', 4));