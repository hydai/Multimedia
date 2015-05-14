function hw3
    % hw3.m - 請完整寫出把三首歌都分出來的過程
    %% Q1
    %% INIT
    clear all;close all;
    fprintf('Q1 - Start\n');
    %% Read in input audio file (wavread or audioread)
    [y, fs] = audioread('hw3_mix.wav');

    %% Filtering
    N = 501;
    fc = [420, 780];
    [out_low, filter_low] = myFilter(y, fs, N, 'Blackman', 'low-pass', fc(1));
    [out_band, filter_band] = myFilter(y, fs, N, 'Blackman', 'band-pass', fc);
    [out_high, filter_high] = myFilter(y, fs, N, 'Blackman', 'high-pass', fc(2));

    %% Plot
    % Frequency domain
    fvtool(filter_low);
    fvtool(filter_band);
    fvtool(filter_high);
    figure;
    % Filter
    subplot(1, 3, 1);
    fa(out_low, fs);
    title('low-pass');
    subplot(1, 3, 2);
    fa(out_band, fs);
    title('band-pass');
    subplot(1, 3, 3);
    fa(out_high, fs);
    title('high-pass');
    figure;
    % Time domain
    subplot(1, 3, 1);
    plot([1:length(filter_low)], filter_low);
    title('low-pass');
    subplot(1, 3, 2);
    plot([1:length(filter_band)], filter_band);
    title('band-pass');
    subplot(1, 3, 3);
    plot([1:length(filter_high)], filter_high);
    title('high-pass');
    
    %% Save the filtered audio (wavwrite or audiowrite)
    audiowrite('low-pass.wav', out_low, fs);
    audiowrite('band-pass.wav', out_band, fs);
    audiowrite('high-pass.wav', out_high, fs);
    
    fprintf('Q1 - End\n');

    %% Q2
    fprintf('Q2 - Start\n');
    %% INIT
    %clear all;close all;
    [y, fs] = audioread('AnJing_4bit.wav');
    %% Plot the spectrum and shape of the input wave file
    figure;
    subplot(2, 2, 1);
    fa(y, fs);
    title('input wave');
    %% Add random noise (uniform distribution)
    bits = 8;
    offset = 2^(bits-1); % 128
    noise = y+rand(size(y))-0.5;
    y = floor(y*offset); % -1~1 => -128~128
    noise = floor(noise*offset); % -1~1 => -128~128
    subplot(2, 2, 2);
    fa(noise, fs);
    title('add random noise');
    %% Apply the first-order feedback loop for noise shaping.
    c = 0.9;
    out = zeros(size(noise));
    for n = 1:size(noise, 1)
        if n == 1
            Ei = zeros(1, 2);
        else
            Ei = y(n-1, :)-out(n-1, :);
        end
        out(n, :) = floor(noise(n, :) + c*Ei);
    end
    out = out/offset;
    subplot(2, 2, 3);
    fa(out, fs);
    title('noise shaping');
    out_low = zeros(size(out));
    [out_low(:, 1), ~] = myFilter(out(:, 1), fs, bits+1, 'Hanning', 'low-pass', 500);
    [out_low(:, 2), ~] = myFilter(out(:, 2), fs, bits+1, 'Hanning', 'low-pass', 500);
    subplot(2, 2, 4);
    fa(out_low, fs);
    title('Done');
    audiowrite('AnJing_8bit.wav', out_low, fs);
    fprintf('Q2 - End\n');
    
end

function fa(y1, fs1)
    % Frequency analysis - you can use the following code to plot spectrum
    % y1: signal, fs1: sampling rate

    L = 2^nextpow2(max(size(y1)));
    y1_FFT = fft(y1,L);
    xx = fs1/2*linspace(0,1,L/2+1);
    plot(xx,abs(y1_FFT(1:L/2+1)));
end
