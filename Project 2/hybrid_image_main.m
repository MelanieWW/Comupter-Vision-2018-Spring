close all; % closes all figures

% read images and convert to single format
im1 = im2single(imread('./shubiao.jpg'));
im2 = im2single(imread('./laoshu2.jpg'));
im1 = rgb2gray(im1); % convert to grayscale
%im1 = imcrop(im1);
im2 = rgb2gray(im2);
im2 = imadjust(im2);

% use this if you want to align the two images (e.g., by the eyes) and crop
% them to be of same size
[im2, im1] = align_images(im2, im1);

% uncomment this when debugging hybridImage so that you don't have to keep aligning
% keyboard; 

%% Choose the cutoff frequencies and compute the hybrid image (you supply
%% this code)
cutoff_low = 20;
cutoff_high = 30; 
[im12, iBlur, iSharpen] = hybridImage(im1, im2, cutoff_low, cutoff_high);

%% Crop resulting image (optional)
figure(1), hold off, imagesc(im12), axis image, colormap gray
disp('input crop points');
[x, y] = ginput(2);  x = round(x); y = round(y);
im12 = im12(min(y):max(y), min(x):max(x), :);
figure(1), hold off, imagesc(im12), axis image, colormap gray

%% frequency analysis

% crop the padding area by image alignment
im1 = im1(min(y):max(y), min(x):max(x), :);
im2 = im2(min(y):max(y), min(x):max(x), :);
iBlur = iBlur(min(y):max(y), min(x):max(x), :);
iSharpen = iSharpen(min(y):max(y), min(x):max(x), :);

fftsize = 512;
im1_fft  = fft2(im1,  fftsize, fftsize); 
im2_fft  = fft2(im2,  fftsize, fftsize); 
iBlur_fft  = fft2(iBlur,  fftsize, fftsize); 
iSharpen_fft  = fft2(iSharpen,  fftsize, fftsize); 
im12_fft  = fft2(im12,  fftsize, fftsize); 

subplot(3,2,1)
imagesc(log(abs(fftshift(im1_fft)))), colormap default
title('fft of image 1')

subplot(3,2,2)
imagesc(log(abs(fftshift(im2_fft)))), colormap default
title('fft of image 2')

subplot(3,2,3)
imagesc(log(abs(fftshift(iBlur_fft))))
title('fft of low-pass filtered image'), colormap default

subplot(3,2,4)
imagesc(log(abs(fftshift(iSharpen_fft)))), colormap default
title('fft of high-pass filtered image')

subplot(3,2,5)
imagesc(log(abs(fftshift(im12_fft)))), colormap default
title('fft of hybrid image')

%% Compute and display Gaussian and Laplacian Pyramids (you need to supply this function)
N = 4; % number of pyramid levels (you may use more or fewer, as needed)
pry = pyramids(im12,'Laplacian',N);

m = size(pry{1}, 1);
newI = pry{1};
for i = 2 : numel(pry)
    [q,p] = size(pry{i});
    pry{i} = cat(1,repmat(zeros(1 , p),[m - q , 1]),pry{i});
    newI = cat(2,newI,pry{i});
end
   imagesc (newI), axis image, colormap gray
   %figure, imshow(newI)

%% image enhancement
