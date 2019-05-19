function disMap = bMatch (left,right,halfBlock,disparity)
%use block on right image as template
%slide window on left image in the dispairy range to find the best matching
%block
height = size(left,1);
width = size(left,2);
disMap = zeros(height,width);

for m = 1:height
    minr = max(1, m - halfBlock);     %partial block at upper and lower edges
    maxr = min(height, m + halfBlock);   
    for n = 1:width
        minc = max(1, n - halfBlock); %partial block at left and right edges  
        maxc = min(width, n + halfBlock);
        
        maxd = min(disparity, width - maxc);
        numBlocks = maxd + 1;
        blockCorr = zeros(1,numBlocks); %vector to store block correlation
        
        template = right(minr:maxr,minc:maxc);
        
        for i = 0 : maxd
            slideBlock = left(minr:maxr,minc+i:maxc+i);
            idx = i+1;           %array index starts from 1
            blockCorr(idx) = corr2(slideBlock,template);
            %blockCorr(idx) = sum(sum(abs(slideBlock-template))); SAD
            %blockCorr(idx) = sum(sum((slideBlock-template).^2));  SSD
        end
        
        [sortCorr index] = sort(blockCorr,'descend');
        %[sortCorr index] = sort(blockCorr); SAD
        maxIndex = index(1);
        d = maxIndex - 1;
        % To compute the sub-pixel needs neighbor of closest-matching block
        % So if the block is at either edge of the search window,
		% skip the sub-pixel process
		if ((maxIndex == 1) || (maxIndex == numBlocks))
			% Skip sub-pixel estimation and store the integer disparity value.
			disMap(m, n) = d;
        else
			C1 = blockCorr(maxIndex - 1);
			C2 = blockCorr(maxIndex);
			C3 = blockCorr(maxIndex + 1);
			disMap(m, n) = d - (0.5 * (C3 - C1) / (C1 - (2*C2) + C3));
        end
    end
    if (mod(m, 10) == 0)
    fprintf('  Image row %d / %d (%.0f%%)\n', m, height, (m / height) * 100);
	end
end
end

        
        