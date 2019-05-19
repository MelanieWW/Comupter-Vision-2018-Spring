clc;
clear;

%im3 = imread('scale_3.tif');
%im3 = medfilt2(im3);

%im5 = imread('scale_5.tif');
%im5Fil = medfilt2(im5,[5,5]);

im9 = imread('scale_9.tif');
%im9 = medfilt2(im9);

im15 = imread('scale_15.tif');

%im21 = mat2gray(imread('scale_21.tif'));

im = replace(im9,im15,1,20);
%im2 = replace(im1,im15,1,15);
%im = medfilt2(im,[5,5]);

%im = mat2gray(im);
%im2 = mat2gray(im2);
imshowpair(im9,im,'montage');