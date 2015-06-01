function LOGT(n, d)
N = [8, 16];
D = [8, 16];

%% 2D Log
    fprintf('N = %d, D = %d\n', N(n), D(d));
    origin = im2double(rgb2gray(imread('input/caltrain007.bmp')));
    compare = im2double(rgb2gray(imread('input/caltrain008.bmp')));
    motion_vectors = logarithmic(origin, compare, N(n), D(d));
    motion_vectors = int64(motion_vectors);
    origin_copy = origin;
    for i = 1:size(motion_vectors, 1)
        for j = 1:size(motion_vectors, 2)
            inner_i = (i - 1) * N(n) + 1 + motion_vectors(i, j, 1);
            inner_j = (j - 1) * N(n) + 1 + motion_vectors(i, j, 2);

            origin_copy(inner_i:(inner_i + N(n) - 1), ...
                        inner_j:(inner_j + N(n) - 1)) ...
                = origin(((i - 1) * N(n) + 1):((i - 1) * N(n) + N(n)), ...
                         ((j - 1) * N(n) + 1):((j - 1) * N(n) + N(n)));
        end
    end
    diff = abs(compare - origin_copy);
end