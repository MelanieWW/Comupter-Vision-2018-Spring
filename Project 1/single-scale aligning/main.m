clc;
clear;

% name of the input file
imname = '00458u.jpg';

% read in the image
Img = imread(imname);

%crop out the white frame
fullim = imcrop(Img);

% convert to double matrix (might want to do this later on to same memory)
fullim = im2double(fullim);

% compute the height of each part (just 1/3 of total)
height = floor(size(fullim,1)/3);
% separate color channels
B = fullim(1:height,:);
G = fullim(height+1:height*2,:);
R = fullim(height*2+1:height*3,:);


% Align the images

% Align the third layer
    [aG,vecG] = align(G,B,[-15 15],[-15 15]);
    [aR,vecR] = align(R,B,[-15 15],[-15 15]);


% open figure
%% figure(1);

% create a color image (3D array)
% ... use the "cat" command
% show the resulting image
% ... use the "imshow" command
% save result image
   RGB = cat(3,aR,aG,B);
   imshow(RGB);
   imwrite(RGB,['result-' imname]);
