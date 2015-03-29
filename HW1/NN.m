function [ ret ] = NN( img )
%% Get height and width from img
[h, w] = size(img);

%% Reset result
scale = 4;
ret = zeros(h*scale, w*scale);

%% New size from result
[hh, ww] = size(ret);
for i = scale:hh-scale
    for j = scale:ww-scale
        %% Find nearest neighbor
        ii = round(i/scale + 0.5);
        jj = round(j/scale + 0.5);
        ret(i, j) = img(ii, jj);
    end
end
end

