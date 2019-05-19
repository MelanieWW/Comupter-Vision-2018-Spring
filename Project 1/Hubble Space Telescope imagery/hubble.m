% CS194-26 (cs219-26): Project 1, starter Matlab code
clc;
clear;

% read in the image
R = imread('hst_05237_02_wfpc2_red.tif');
G = imread('hst_05237_02_wfpc2_green.tif');
B = imread('hst_05237_02_wfpc2_blue.tif');

% convert to double matrix (might want to do this later on to same memory)
R = im2double(R);
G = im2double(G);
B = im2double(B);

%image pyramid
%first layer
B1 = imresize(B,0.5);
G1 = imresize(G,0.5);
R1 = imresize(R,0.5);
%second layer
B2 = imresize(B1,0.5);
G2 = imresize(G1,0.5);
R2 = imresize(R1,0.5);
%third layer
B3 = imresize(B2,0.5);
G3 = imresize(G2,0.5);
R3 = imresize(R2,0.5);

% Align the images
% Align the third layer
    [aG3,vecG3] = align(G3,B3,[-15 15],[-15 15]);
    [aR3,vecR3] = align(R3,B3,[-15 15],[-15 15]);
%Align the second layer
    [aG2,vecG2] = align(G2,B2,[vecG3(1)*2-10 vecG3(1)*2+10],[vecG3(2)*2-10 vecG3(2)*2+10]);
    [aR2,vecR2] = align(R2,B2,[vecR3(1)*2-10 vecR3(1)*2+10],[vecR3(2)*2-10 vecR3(2)*2+10]);
%Align the first layer
    [aG1,vecG1] = align(G1,B1,[vecG2(1)*2-8 vecG2(1)*2+8],[vecG2(2)*2-8 vecG2(2)*2+8]);
    [aR1,vecR1] = align(R1,B1,[vecR2(1)*2-8 vecR2(1)*2+8],[vecG2(2)*2-8 vecG2(2)*2+8]);
%Align the original image
    [aG,vecG] = align(G,B,[vecG1(1)*2-5 vecG1(1)*2+5],[vecG1(2)*2-5 vecG1(2)*2+5]);
    [aR,vecR] = align(R,B,[vecR1(1)*2-5 vecR1(1)*2+5],[vecR1(2)*2-5 vecR1(2)*2+5]);

% open figure
%% figure(1);

% create a color image (3D array)
% ... use the "cat" command
% show the resulting image
% ... use the "imshow" command
% save result image
   RGB = cat(3,aR,aG,B);
   imshow(RGB);
   imwrite(RGB,'result-hst_05237.jpg' );
