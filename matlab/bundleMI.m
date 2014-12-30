% feature-selection-mRMR
% Created by Jiahong K. Chen

% Input:  X     dim-by-k, matrix of discrete data 
%         y     dim-by-1, discrete data
% Output: bMI   k-by-1, bMI(i) = I(X(:,i),y)

function bMI = bundleMI(X, y)

k   = size(X, 2);
bMI = zeros( k , 1 );

for i = 1 : k
    bMI(i) = mutualInfoDis(X(:,i), y);
end

end