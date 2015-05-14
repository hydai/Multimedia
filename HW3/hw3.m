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
    [out_low, filter_low] = myFilter(y, fs, N, 'Hamming', 'low-pass', fc(1));
    [out_band, filter_band] = myFilter(y, fs, N, 'Hamming', 'band-pass', fc);
    [out_high, filter_high] = myFilter(y, fs, N, 'Hamming', 'high-pass', fc(2));

    %% Plot
    % Frequency domain
    fvtool(filter_low);
    fvtool(filter_band);
    fvtool(filter_high);
    
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
    
    fprintf('Q2 - End\n');
end

function fa(y1, Fs1)
    % Frequency analysis - you can use the following code to plot spectrum
    % y1: signal, Fs1: sampling rate

    L = 2^nextpow2(max(size(y1)));
    y1_FFT = fft(y1,L);
    xx = Fs1/2*linspace(0,1,L/2+1);
    plot(xx,abs(y1_FFT(1:L/2+1)));
end
