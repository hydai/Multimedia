%% HW4 Part (b)
N = [8, 16];
D = [8, 16];
PREFIX = 'caltrain0';
POSTFIX = '.bmp';
FN = {'08', '09', '10', '11', '12', '13', '14', '15', '16', '17'};

PSNR_FS = zeros(10, 2, 2);
PSNR_2D = zeros(10, 2, 2);

%% Full search
for fn = 1:10
    file = strcat(PREFIX, FN{fn}, POSTFIX);
    for n = 1:2
        for d = 1:2
            fprintf('Full FN = %s, N = %d, D = %d\n', FN{fn}, N(n), D(d));
            origin = im2double(rgb2gray(imread('input/caltrain007.bmp')));
            compare = im2double(rgb2gray(imread(strcat('input/', file))));
            motion_vectors = full_search(origin, compare, N(n), D(d));
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
            PSNR_FS(fn, d, n) = psnr(compare, origin_copy);
        end
    end
end

%% 2D Logarithmic
for fn = 1:10
    file = strcat(PREFIX, FN{fn}, POSTFIX);
    for n = 1:2
        for d = 1:2
            fprintf('Log FN = %s, N = %d, D = %d\n', FN{fn}, N(n), D(d));
            origin = im2double(rgb2gray(imread('input/caltrain007.bmp')));
            compare = im2double(rgb2gray(imread(strcat('input/', file))));
            motion_vectors = logarithmic(origin, compare, N(n), D(d));
            origin_copy = origin;
            for i = 1:size(motion_vectors, 1)
                for j = 1:size(motion_vectors, 2)
                    ii = (i - 1) * N(n);
                    jj = (j - 1) * N(n);
                    inner_i = ii + 1 + motion_vectors(i, j, 1);
                    inner_j = jj + 1 + motion_vectors(i, j, 2);
                    
                    origin_copy(inner_i:(inner_i + N(n) - 1), ...
                                inner_j:(inner_j + N(n) - 1)) ...
                        = origin((ii + 1):(ii + N(n)), ...
                                 (jj + 1):(jj + N(n)));
                end
            end
            
            PSNR_2D(fn, d, n) = psnr(compare, origin_copy);
        end
    end
end

%% Plot PSNR
for n = 1:2
    for d = 1:2
        hold on;
        plot([1:10], PSNR_FS(:, d, n), 'b--o', 'Color', 'b');
        plot([1:10], PSNR_2D(:, d, n), 'b--o', 'Color', 'r');
        title(strcat('D = ', int2str(D(d)), ' N = ', int2str(N(n))));
        figure;
    end
end
