% Input:
%       dataX n-by-p, n is #observation, p is dim of feature
%       dataC n-by-1, the class of observations
%       candiFea    , candidate features filtered by candidateFeature
%       wrapper     , 'back' or 'for'
%       classifier  , 'NB' or 'LDA'
% Output: compact feature

function cmptFea = compactWrapper(dataX, dataC, candiFea, classifier, wrapper)

kFold = 10;
if strcmp(wrapper, 'back')
    cmptFea = backWrapper(dataX, dataC, candiFea, classifier, kFold);
elseif strcmp(wrapper, 'for')
    cmptFea = forWrapper(dataX, dataC, candiFea, classifier, kFold);
end

end

function cmptFea = backWrapper(dataX, dataC, candiFea, classifier, kFold)

conti       = true;
errClass    = cvErrEst(dataX(:,candiFea), dataC, classifier, kFold);

while conti

    m       = length(candiFea);
    errK    = Inf;
    badIdx  = 0;
    
    for Sid = 1 : m
        idx = candiFea( [1:Sid-1, Sid+1:m] );
        errNow = cvErrEst(dataX(:,idx), dataC, classifier, kFold);
        if errNow < errK
            errK    = errNow;
            badIdx  = Sid;
        end
    end
    
    if errK <= errClass
        candiFea(badIdx)    = [];
        errClass            = errK;
    else
        cmptFea             = candiFea;
        conti               = false;
    end

end
    
end

function cmptFea = forWrapper(dataX, dataC, candiFea, classifier, kFold)
end