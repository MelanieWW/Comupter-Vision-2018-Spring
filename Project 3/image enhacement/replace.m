function image = replace(noisy,smooth,row,colum)

[height width] = size(noisy);

for m = 1:height
    minr = max(1, m - row);     %partial block at upper and lower edges
    maxr = min(height, m + row);   
    for n = 1:width
        minc = max(1, n - colum); %partial block at left and right edges  
        maxc = min(width, n + colum);
        meanBlock = mean(mean(noisy(minr:maxr,minc:maxc)));
        if (abs(noisy(m,n)-meanBlock)>15)
            noisy(m,n) = smooth(m,n);
        end
    end
end
image = noisy;