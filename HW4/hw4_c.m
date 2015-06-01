%% HW4 Part (c)

N = [8, 16];
D = [8, 16];

TIME_FS = zeros(2, 2);
TIME_LOG = zeros(2, 2);

%% Full search
for n = 1:2
    for d = 1:2
        st = tic;
        FST(n, d);
        TIME_FS(n, d) = toc(st);
    end
end

%% 2D log
for n = 1:2
    for d = 1:2
        st = tic;
        LOGT(n, d);
        TIME_LOG(n, d) = toc(st);
    end
end

for n = 1:2
    for d = 1:2
        fprintf('Full Search N = %d, D = %d, T = %f\n', N(n), D(d), TIME_FS(n, d));
        fprintf('2D Log N = %d, D = %d, T = %f\n', N(n), D(d), TIME_LOG(n, d));
    end
end