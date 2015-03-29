%% load data first
lena = im2double(imread('lena_gray.bmp'));
myimg = im2double(rgb2gray(imread('demoimg.bmp')));

%% thresholding image
thresholding_lena = Thresholding(lena);
thresholding_myimg = Thresholding(myimg);

%% error diffusion mask #1
EDD_lena_1 = ErrorDiffusionDithering(lena, 1);
EDD_myimg_1 = ErrorDiffusionDithering(myimg, 1);

%% error diffusion mask #2
EDD_lena_2 = ErrorDiffusionDithering(lena, 2);
EDD_myimg_2 = ErrorDiffusionDithering(myimg, 2);

%% Print result
subplot(2, 2 ,1);
imshow(lena);
subplot(2, 2 ,2);
imshow(thresholding_lena);
subplot(2, 2, 3);
imshow(EDD_lena_1);
subplot(2, 2, 4);
imshow(EDD_lena_2);

figure;

subplot(2, 2 ,1);
imshow(myimg);
subplot(2, 2 ,2);
imshow(thresholding_myimg);
subplot(2, 2, 3);
imshow(EDD_myimg_1);
subplot(2, 2, 4);
imshow(EDD_myimg_2);

%% Save result
imwrite(thresholding_lena, 'thresholding_lena.png');
imwrite(EDD_lena_1, 'EDD_lena_1.png');
imwrite(EDD_lena_2, 'EDD_lena_2.png');
imwrite(thresholding_myimg, 'thresholding_myimg.png');
imwrite(EDD_myimg_1, 'EDD_myimg_1.png');
imwrite(EDD_myimg_2, 'EDD_myimg_2.png');