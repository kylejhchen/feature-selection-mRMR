% feature-selection-mRMR
% Created by Jiahong K. Chen

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
    errK    = 1;
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

conti       = true;

errClass    = 1;
cmptFea     = [];
cmptIdx     = 0;

while conti
    
    m       = length(candiFea);
    errK    = 1;
    goodIdx = 0;
    
    for Sid = 1 : m
        idx = [cmptFea; candiFea(Sid)];
        errNow = cvErrEst(dataX(:,idx), dataC, classifier, kFold);
        if errNow < errK
            errK    = errNow;
            goodIdx = Sid;
        end
    end
    
    if errK <= errClass
        cmptFea = [cmptFea; candiFea(goodIdx)];
        if errK < errClass; cmptIdx = length(cmptFea); end;
        errClass = errK;
    else
        cmptFea = cmptFea(1:cmptIdx);
        conti = false;
    end
    
end

end