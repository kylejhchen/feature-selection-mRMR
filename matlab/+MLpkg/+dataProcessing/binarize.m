% feature-selection-mRMR
% Created by Jiahong K. Chen

% To binarize the raw data

function newData = binarize(orgData)

[m, n] = size(orgData);

meanData = mean(orgData);

newData = ones(m,n);

for fea = 1 : n
    
    newData( (orgData(:,fea) < meanData(fea)) , fea) = -1;
    
end

end