% CS194-26 (cs219-26): Project 1, starter Matlab code
clc;
clear;

% name of the input file
imname = '01164v.jpg';

% read in the image
Img = imread(imname);
[row,col] = size(Img);


% convert to double matrix (might want to do this later on to same memory)
Img = im2double(Img);

%0.8 is the threshole of white margin
mask1 = imbinarize(Img, .8);
%fill the holes inside the margin
mask1 = ~mask1;
mask1 =imfill(mask1,'holes');
mask1 = ~mask1;
Img(mask1) = 0;

%fill gab between white and black margins
mask2 = imbinarize(Img, .2);
mask2 = bwareaopen(mask2,2000);
mask2 =imfill(mask2,'holes');
mask3 = ~mask2;
Img(mask3) = 0;

%crop the black border
%left border
mid = mask2(floor(row/2),1:floor(col/5));
leftMargin = sum(mid == 0);
%right border
mid = mask2(floor(row/2),floor(col*4/5):end);
rightMargin = sum(mid == 0);
%upper border
mid = mask2(1:floor(row/5),floor(col/2));
upperMargin = sum(mid == 0);
%lower border
mid = mask2(floor(row*4/5):end,floor(col/2));
lowerMargin = sum(mid == 0);
%crop
Img = Img(upperMargin+1:row-lowerMargin,leftMargin+1:col-rightMargin);
imshow(Img)
% compute the height of each part (just 1/3 of total)
height = floor(size(Img,1)/3);
% separate color channels
B = Img(1:height,:);
G = Img(height+1:height*2,:);
R = Img(height*2+1:height*3,:);


% Align the images
    [aG,vecG] = align(G,B,[-15 15],[-15 15]);
    [aR,vecR] = align(R,B,[-15 15],[-15 15]);


% open figure
%% figure(1);

% create a color image (3D array)
% ... use the "cat" command
% show the resulting image
% ... use the "imshow" command

   RGB = cat(3,aR,aG,B);
   figure,imshow(RGB);

%contrast enhancement
   RGB_adjust = im_adjust(RGB);
   figure,imshow(RGB_adjust);

% save result image
   imwrite(RGB,['result-' imname]);
