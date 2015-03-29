function [ ret ] = Thresholding( img )
%% Get height and width from img
[h, w] = size(img);

%% Let threshold value equal to average of all gray value
thr = sum(sum(img))/h/w;
ret = img;

%% Rewrite the data
ret(img > thr) = 1;
ret(img <= thr) = 0;
end

