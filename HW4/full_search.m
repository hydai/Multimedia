function motion_vectors = full_search(origin, compare, N, D)
h = size(origin, 1);
w = size(origin, 2);
outer_i = 1;
motion_vectors = zeros(floor(h/N), floor(w/N));
for i = 1:N:h
    outer_j = 1;
    for j = 1:N:w
        SAD = 2147483647;
        vectors = [0, 0];
        for img_h_st = (i - D):(i + D)
            if ((img_h_st + N - 1) > h || img_h_st <= 0)
                continue;
            end
            for img_w_st = (j - D):(j + D)
                if ((img_w_st + N - 1) > w || img_w_st <= 0)
                    continue;
                end
                tmp_sad = sad(compare(img_h_st:(img_h_st + N - 1), ...
                                      img_w_st:(img_w_st + N - 1)), ...
                              origin(i:(i + N - 1), ...
                                     j:(j + N - 1)));
                if (tmp_sad < SAD)
                    SAD = tmp_sad;
                    vectors(1) = img_h_st - i;
                    vectors(2) = img_w_st - j;
                end
            end
        end
        motion_vectors(outer_i, outer_j, 1) = vectors(1);
        motion_vectors(outer_i, outer_j, 2) = vectors(2);
        outer_j = outer_j + 1;
    end
    outer_i = outer_i + 1;
end
end
