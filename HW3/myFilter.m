function [out, filter] = myFilter(in, fs, N, wFun, type, para)

% in: input signal
% fs: sampling frequency
% N : size of FIR filter, assumed to be odd
% wFun: 'Hanning', 'Hamming', 'Blackman'
% type: 'low-pass', 'high-pass', 'bandpass', 'bandstop' 
% para: cut-off frequency or band frequencies corresponding to the filter type
%       if type is 'low-pass' or 'high-pass', para has only one element         
%       if type is 'bandpass' or 'bandstop', para is a vector of 2 elements

% 1. Normalization
fc = para/fs;
mid = floor(N/2);

% 2. Create the filter according the ideal equations in Table5.2
filter = zeros(1, N);
if strcmp(type, 'low-pass') == 1
    for n = -mid:mid
        if isequal(n, 0) == 1
            filter(n+mid+1) = 2*fc;
        else
            filter(n+mid+1) = sin(2*pi*fc*n)/(pi*n);
        end
    end
elseif strcmp(type, 'high-pass') == 1
    for n = -mid:mid
        if isequal(n, 0) == 1
            filter(n+mid+1) = 1 - 2*fc;
        else
            filter(n+mid+1) = -sin(2*pi*fc*n)/(pi*n);
        end
    end
elseif strcmp(type, 'band-pass') == 1
    for n = -mid:mid
        if isequal(n, 0) == 1
            filter(n+mid+1) = 2*(fc(2)-fc(1));
        else
            filter(n+mid+1) = sin(2*pi*fc(2)*n)/(pi*n) - sin(2*pi*fc(1)*n)/(pi*n);
        end
    end
else
    % Unknown Type, do nothing
end
        
% 3. Create the windowing function
% 4. Get the realistic filter
if strcmp(wFun,'Hanning') == 1
    filter = filter.*(0.5+0.5*cos(2*pi*(1:N)/N));
elseif strcmp(wFun, 'Hamming') == 1
    filter = filter.*(0.54+0.46*cos(2*pi*(1:N)/N));
elseif strcmp(wFun, 'Blackman') == 1
    filter = filter.*(0.42+0.5*cos(2*pi*(1:N)/(N-1))+0.08*cos(4*pi*(1:N)/N-1));
else
    % Unknown Type, do nothing
end

% 5. Filter the input signal in time domain. Do not use matlab function 'conv'
out = zeros(1, size(in, 1));
for n = 1:size(in, 1)
    for k = 1:N
        if n-k >= 1
            out(n) = out(n) + filter(k)*in(n-k);
        end
    end
end