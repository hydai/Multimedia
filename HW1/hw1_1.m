%% Load data first
img = im2double(imread('BFCatvengers.png'));
src = im2double(imread('Catvengers.png'));

%% Demosaice image
fqi = Demosaicing(img);

%% Find PSNR by own implement
myPSNR = MyPSNR(src, fqi);

%% Print result
fprintf('PSNR = %2.4f\n', myPSNR);
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
