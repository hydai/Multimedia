function [ ret ] = Demosaicing(src)
ret = src;

% Get height and width
[h, w, s] = size(src);

% Check 8 direct
mvx = [-1, -1, -1, 0, 0, 1, 1, 1];
mvy = [-1, 0, 1, -1, 1, -1, 0, 1];

% Skip edge situation
for i = 2:(h-1)
    for j = 2:(w-1)
        for k = 1:3
            if ret(i, j, k) == 0
                % ct for counting the data around the position
                ct = 0;
                for m = 1:8
                    ii = i + mvx(m);
                    jj = j + mvy(m);
                    if src(ii, jj, k) ~= 0
                        ct = ct + 1;
                        ret(i, j, k) = ret(i, j, k) + src(ii, jj, k);
                    end
                end
                % avoid ct equals to zero leading a error case
                if ct == 0
                    ct = 1;
                end
                ret(i, j, k) = ret(i, j, k)/ct;
            end
        end
    end
end

end

