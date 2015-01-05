% feature-selection-mRMR
% Created by Jiahong K. Chen

% Algorithm: incremental method of mRMR
% Input: 
%       dataX n-by-p, n is #observation, p is dim of feature
%       dataC n-by-1, the class of observations
%       nSelect     , # selected features <= n
% Output:
%       slctFea nSelect-by-1, selected features (ordered)

function slctFea = mRMR(dataX, dataC, nSelect)

% initialize
slctFea     = zeros(nSelect, 1);
dimF        = size(dataX, 2);
remainFea   = (1:dimF);

% mutual info of dataX and dataC, dimFea-by-1
Ixc     = bundleMI(dataX, dataC);

% select the first feature with max-Rev
[~, idxF]          = max(Ixc);
slctFea(1)         = remainFea(idxF);

% drop the selected feature
remainFea( idxF )  = [];
Ixc(       idxF )  = [];
dimRemain          = dimF-1; % = length(remainFea)

% mutual info of xj, xi
Ixx     = zeros(dimRemain, nSelect-1);
redun   = zeros(dimRemain, 1);
for fea = 2 : nSelect
    
    Ixx(:, fea-1) = bundleMI( dataX(:,remainFea) , dataX(:,slctFea(fea-1)) );
    % redun       = mean( Ixx(:,1:fea-1) , 2 ); % issue: change size for every loop
    redun         = ( redun*(fea-2) + Ixx(:,fea-1) ) / (fea-1);
    
    % select the feature with incremental mRMR
    [~, idxF]   = max(Ixc - redun);
    slctFea(fea)= remainFea(idxF);
    
    % drop the selected feature
    Ixx(      idxF, : ) = [];
    redun(    idxF    ) = [];
    remainFea(idxF    ) = [];
    Ixc(      idxF    ) = [];
    dimRemain           = dimRemain - 1;
    
end

end