%% Load the stereo images.
left = imread('teddy\im2.png');
right = imread('teddy\im6.png');
left = rgb2gray(double(left)/255);
right = rgb2gray(double(right)/255);

%% Match Block to get disparity of correspondences
halfBlock  = 10;       %block size 9-by-9
blockSize = 2*halfBlock + 1;
disparityRange = 50;  %disparity searching range
disMap = bMatch (left,right,halfBlock,disparityRange);

%% Visualize the disparity map
fprintf('Displaying disparity map...\n');


% Switch to figure 1.
figure(1);

% Clear the current figure window.
clf;

% Display the disparity map. 
% Passing an empty matrix as the second argument tells imshow to take the
% minimum and maximum values of the data and map the data range to the 
% display colors.
image(disMap);

% Configure the axes to properly display an image.
axis image;

colormap gray
% Display the color map legend.
colorbar;

% Specify the minimum and maximum values in the disparity map so that the 
% values can be properly mapped into the full range of colors.
% If you have negative disparity values, this will clip them to 0.
%caxis([0 disparityRange]);

% Set the title to display.
title(strcat('Basic block matching, Block size = ', num2str(blockSize)));

