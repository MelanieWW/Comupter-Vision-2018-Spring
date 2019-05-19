function [RGB_imadjust] = im_adjust(RGB)
   srgb2lab = makecform('srgb2lab');
   lab2srgb = makecform('lab2srgb');
   RGB_lab = applycform(RGB, srgb2lab); % convert to L*a*b*

% the values of luminosity can span a range from 0 to 100; scale them
% to [0 1] range (appropriate for MATLAB(R) intensity images of class double) 
% before applying the three contrast enhancement techniques
   max_luminosity = 100;
   L = RGB_lab(:,:,1)/max_luminosity;

% replace the luminosity layer with the processed data and then convert
% the image back to the RGB colorspace
   RGB_imadjust = RGB_lab;
   RGB_imadjust(:,:,1) = imadjust(L)*max_luminosity;
   RGB_imadjust = applycform(RGB_imadjust, lab2srgb);
end