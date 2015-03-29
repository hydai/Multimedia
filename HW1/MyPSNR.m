function [ ret ] = MyPSNR( src, img )
[h, w, s] = size(src);
MSE = sum(sum(sum((img-src).^2))/h/w)/3;
MAXI = 1;
ret = 20*log10(MAXI)-10*log10(MSE);
end