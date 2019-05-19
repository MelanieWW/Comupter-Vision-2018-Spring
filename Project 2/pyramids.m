function [ pyr ] = pyramids( img, type, layer )
%This function generates Gaussian or Laplacian pyramid
%   PYR = GENPYR(IMG,TYPE,LAYER) IMG is the input image, 
%	TYPE can be 'Gaussian' or 'Laplacian'.
%	PYR is a 1*LEVEL cell array.

pyr = cell(1,layer);
pyr{1} = img;
for p = 2:layer
	pyr{p} = pyr_reduce(pyr{p-1});
end
if strcmp(type,'Gaussian'), return; end

for p = layer-1:-1:1 % adjust the image size
	newsz = size(pyr{p+1})*2-1;
	pyr{p} = pyr{p}(1:newsz(1),1:newsz(2),:);
end

for p = 1:layer-1
	pyr{p} = pyr{p}-pyr_expand(pyr{p+1});
end
end