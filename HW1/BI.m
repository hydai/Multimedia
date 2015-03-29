function [ ret ] = BI( img )
%% Get height and width from img
[h, w] = size(img);

%% Reset result
scale = 4;
ret = zeros(h*scale, w*scale);

%% New size from result
[hh, ww] = size(ret);
%% Skip edge cases
for i = scale:hh-scale
    for j = scale:ww-scale
        ii = floor(i/scale);
        jj = floor(j/scale);
        alpha = i/scale - ii;
        beta = j/scale - jj;
        ret(i, j) = ...
            (img(ii, jj)*(1-alpha)*(1-beta) ...
            +img(ii+1, jj)*(alpha)*(1-beta) ...
            +img(ii, jj+1)*(1-alpha)*(beta) ...
            +img(ii+1, jj+1)*(alpha)*(beta));
    end
end
end

