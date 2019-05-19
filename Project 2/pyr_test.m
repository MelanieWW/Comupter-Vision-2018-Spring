im = imread('./apple.jpg');
im = rgb2gray(im);
im = double(im)/255;
N = 4; % number of pyramid levels (you may use more or fewer, as needed)
pry = pyramids(im,'Gaussian',N);

m = size(pry{1}, 1);
newI = pry{1};
for i = 2 : numel(pry)
    [q,p] = size(pry{i});
    pry{i} = cat(1,repmat(zeros(1 , p),[m - q , 1]),pry{i});
    newI = cat(2,newI,pry{i});
end
   % imagesc (newI), axis image, colormap gray
   imshow(newI)