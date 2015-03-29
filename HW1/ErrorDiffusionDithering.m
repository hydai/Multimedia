function [ ret ] = ErrorDiffusionDithering( img, type )
%% Get height and width from img
[h, w] = size(img);

%% Select mask by type
xOffset = 1;
if isequal(type, 1)
    mask = [0 0 7; 3 5 1];
    base = 16;
    yOffset = 2;
    xBoundMin = 0;
    xBoundMax = 1;
    yBoundMin = -1;
    yBoundMax = 1;
else
    mask = [0 0 0 7 5; 3 5 7 5 3; 1 3 5 3 1];
    base = 48;
    yOffset = 3;
    xBoundMin = 0;
    xBoundMax = 2;
    yBoundMin = -2;
    yBoundMax = 2;
end

%% Skip edge case
for i = 1:h-2
    for j = 3:w-2
        p = img(i, j);
        if p < 0.5
            e = p;
            img(i, j) = 0;
        else
            e = p-1;
            img(i, j) = 1;
        end
        %% Modify neighbor's value
        for ii = xBoundMin:xBoundMax
            for jj = yBoundMin:yBoundMax
                img(i+ii, j+jj) = img(i+ii, j+jj) + ...
                                  e*mask(xOffset+ii, yOffset+jj)/base;
            end
        end
    end
end
ret = img;
end