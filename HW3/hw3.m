function hw3
    % hw3.m - 請完整寫出把三首歌都分出來的過程
    %% INIT
    clear all;close all;clc;

    %% Read in input audio file (wavread or audioread)
    [y, fs] = audioread('hw3_mix.wav');

    %% Filtering
    N = 601;
    fc = [400, 800];
    [out_low, filter_low] = myFilter(y, fs, N, 'Hamming', 'low-pass', fc(1));
    [out_band, filter_band] = myFilter(y, fs, N, 'Hamming', 'band-pass', fc);
    [out_high, filter_high] = myFilter(y, fs, N, 'Hamming', 'high-pass', fc(2));

    %% Plot
    fvtool(filter_low);
    fvtool(filter_band);
    fvtool(filter_high);
    
    subplot(1, 3, 1);
    fa(out_low, fs);
    title('low-pass');
    subplot(1, 3, 2);
    fa(out_band, fs);
    title('band-pass');
    subplot(1, 3, 3);
    fa(out_high, fs);
    title('high-pass');
    
    %% Save the filtered audio (wavwrite or audiowrite)
    audiowrite('low-pass.wav', out_low, fs);
    audiowrite('band-pass.wav', out_band, fs);
    audiowrite('high-pass.wav', out_high, fs);
end

function fa(y1, Fs1)
    % Frequency analysis - you can use the following code to plot spectrum
    % y1: signal, Fs1: sampling rate

    L = 2^nextpow2(max(size(y1)));
    y1_FFT = fft(y1,L);
    xx = Fs1/2*linspace(0,1,L/2+1);
    plot(xx,abs(y1_FFT(1:L/2+1)));
end
