function [aImg vec] = align(movingImg,fixedImg,windowCol,windowRow)

[row col] = size(fixedImg);
upperW = windowCol(1)
lowerW = windowCol(2)
leftW = windowRow(1)
rightW = windowRow(2)
%displacement vectors
disp = [];
%2-D correlation of aligned images
corr = [];


for i = upperW:lowerW
    for j = leftW:rightW
        aImg = circshift(movingImg,[i j]);
        disp = [disp;i,j];
        corri = corr2(fixedImg,aImg);
        corr = [corr corri];
    end
end
%find the alignment with highest correlation
  [cor,idx] = max(corr);
  vec = disp(idx,:);
  
  %backGround = zeros(row+30,col+30);
  %backGround(16+vec(1):15+row+vec(1),16+vec(2):15+col+vec(2))=movingImg;
  %aImg = backGround(16:15+row,16:15+col);
   aImg = circshift(movingImg,[vec(1) vec(2)]);
   