function [ ret ] = MyPSNR( src, img )
[h, w, s] = size(src);
MSE = sum(sum(sum((img-src).^2))/h/w)/3;
MAXI = 0;
for i = 1:size(img,1)
    mm = max(src(i));
    if (mm > MAXI)
        MAXI = mm;
    end
end
MAXI = sum(MAXI)/3;
ret = 20*log10(MAXI)-10*log10(MSE);
end