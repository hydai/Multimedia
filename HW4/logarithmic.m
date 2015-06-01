
function motion_vectors = logarithmic(origin, compare, N, D)
h = size(origin, 1);
w = size(origin, 2);
motion_vectors = zeros(floor(h/N), floor(w/N));
for i = 1:N:h
    for j = 1:N:w
        if ((i + N - 1 > h) || (j + N - 1) > w)
            continue;
        end
        %% Step 1 - init
        np = floor(log2(D));
        n = max(2, 2^(np-1));
        SAD = sad(origin(i:i+N-1, j:j+N-1), ...
                  compare(i:i+N-1, j:j+N-1));
        q = 0;
        l = 0;
        while true
            %% Step 2 - M'(n) <- M(n)
            mp = [0, n; n, 0; 0, -n; -n, 0];
            %% Step 3
            while true
                hitx = 0; hity = 0;
                prex = i + q; prey = j + l;
                for k = 1:4
                    mpx = prex + mp(k, 1);
                    mpy = prey + mp(k, 2);
                    if (mpx <= 0 || mpx+N-1 > h ...
                      ||mpy <= 0 || mpy+N-1 > w)
                        continue;
                    end
                    tmp_sad = sad(origin(i:i+N-1, j:j+N-1), ...
                                  compare(mpx:mpx+N-1, mpy:mpy+N-1));
                    if tmp_sad < SAD
                        SAD = tmp_sad;
                        hitx = mp(k, 1);
                        hity = mp(k, 2);
                    end
                end

                %% Step 4 or 5
                if hitx == 0 && hity == 0
                    % Step 5 - GO TO Step 6 or 2
                    n = floor(n/2);
                    break;
                else
                    % Step 4 - BACK TO Step 3
                    q = q + hitx;
                    l = l + hity;
                    mp = [0+hitx, n+hity; ...
                          n+hitx, 0+hity; ...
                          0+hitx, -n+hity; ...
                          -n+hitx, 0+hity];
                end
            end

            if n ~= 1
                continue;
            else
                %% Step 6
                mv = [1, -1; 1, 0; 1, 1; 0, -1; 0, 1; ...
                      -1, 1; -1, 0; -1, -1];
                hitx = 0; hity = 0;
                prex = i + q; prey = j + l;
                for k = 1:8
                    mvx = prex + mv(k, 1);
                    mvy = prey + mv(k, 2);
                    if (mvx <= 0 || mvx+N-1 > h ...
                      ||mvy <= 0 || mvy+N-1 > w)
                        continue;
                    end
                    tmp_sad = sad(origin(i:i+N-1, j:j+N-1), ...
                                  compare(mvx:mvx+N-1, mvy:mvy+N-1));
                    if tmp_sad < SAD
                        SAD = tmp_sad;
                        hitx = mv(k, 1);
                        hity = mv(k, 2);
                    end
                end
                q = q + hitx;
                l = l + hity;
                break;
            end
        end
        motion_vectors(floor((i-1)/N)+1, floor((j-1)/N)+1, 1) = q;
        motion_vectors(floor((i-1)/N)+1, floor((j-1)/N)+1, 2) = l;
    end
end
end
