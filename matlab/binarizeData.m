% feature-selection-mRMR
% Created by Jiahong K. Chen

% To binarize the raw data

function newData = binarizeData(orgData)

[m, n] = size(orgData);

meanData = mean(orgData);

newData = false(m,n);

for fea = 1 : n
    
    newData(:, fea) = orgData(:,fea) >= meanData(fea);
    
end

end