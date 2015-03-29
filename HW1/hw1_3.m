%% Load data
img = im2double(imread('Catvengers_gray.png'));

%% Nearest neighbor
NN_img = NN(img);

%% Bi
BI_img = BI(img);

%% Print data
subplot(1, 3, 1);
imshow(img);
subplot(1, 3, 2);
imshow(NN_img);
subplot(1, 3, 3);
imshow(BI_img);

%% Save data
imwrite(NN_img, 'NN_Cat.png');
imwrite(BI_img, 'BI_Cat.png');