function [X, A, S] = gendata(M, N, Delta, theta, f, SNR)
    % generating recieived signal matrix X
    % M: number of antennas
    % N: number of samples
    % Delta: wavelength spacing (default = 1/2 wavelengths)
    % theta: directions of sources (in degrees) (-90 to 90)
    % f: normalized frequencies of sources (0 to 1)
    % SNR: signal-to-noise ratio per source (in dB)
    % noise: spatially and temporally white, complex Gaussian
    
    % number of sources
    d = length(theta);

    % converting degrees to radians
    theta_rad = theta * pi / 180;

    %% steering matrix A (M x d)
    A = zeros(M, d);
    for i = 1:d
        % calculating steering vector based on DOA for each source
        A(:, i) = exp(-1j * 2 * pi * Delta * (0:M-1)' * sin(theta_rad(i)));
    end

    %% source signals S (d x N)
    S = zeros(d, N);
    for i = 1:d
        % each source = complex sinusoid with frequency f(i)
        S(i, :) = exp(1j * 2 * pi * f(i) * (0:N-1));
    end

    %% noiseless received signal
    X_noiseless = A * S;

    %% adding noise based on SNR
    % converting SNR from dB to linear scale
    snr_linear = 10^(SNR/20);

    % calculating noise power
    signal_power = 1; % assuming each source has unit power
    noise_power = signal_power / snr_linear;

    % generating complex Gaussian noise
    noise = sqrt(noise_power/2) * (randn(M, N) + 1j * randn(M, N));

    %% final received signal
    X = X_noiseless + noise;
end