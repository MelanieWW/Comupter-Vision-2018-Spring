function [im12, iBlur, iSharpen] = hybridImage(im1, im2, cutoff_low, cutoff_high)
%The hybridImge function will blur im1 and sharpen im2
%cutoff_low and cutoff_high input the standard deviation of 
%low-pass and hig-pass filter respectively

%the larger the standard deviation and filter size, ...
%the blurer the image is
hs1 = 15;     %half size of the low-pass filter
iBlur = imgaussfilt(im1,cutoff_low,'FilterSize',(hs1*2+1));

%the larger the stadard deviation and filter size, ...
%the more details are kept
hs2 = 20;
iSharpen = im2 - imgaussfilt(im2,cutoff_high,'FilterSize',(hs2*2+1));

im12 = 0.5*(iBlur + iSharpen);    %scale image to double precise

end

