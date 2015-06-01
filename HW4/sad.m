function SAD = sad(compare, origin)
N = size(origin, 1);
SAD = 0;
for i = 1:N
    for j = 1:N
        SAD = SAD + abs(origin(i, j) - compare(i, j));
    end
end
end