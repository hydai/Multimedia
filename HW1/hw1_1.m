img = imread('BFCatvengers.png');
src = imread('Catvengers.png');
img = im2double(img);
src = im2double(src);

fqi = Demosaicing(img);
myPSNR = MyPSNR(src, fqi);

[peaksnr, snr] = psnr(fqi, src);
fprintf('PSNR = %2.4f, %2.4f\n', peaksnr, myPSNR);
img = fqi-src;
s(1) = subplot(1, 3, 1);
imshow(img);
s(2) = subplot(1, 3, 2);
imshow(fqi);
s(3) = subplot(1, 3, 3);
imshow(src);
title(s(1), 'absolute color differences');
title(s(2), 'Recover image');
title(s(3), 'Source image');