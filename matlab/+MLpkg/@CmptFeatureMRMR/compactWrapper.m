% feature-selection-mRMR
% Created by Jiahong K. Chen

% Input:
%       dataX n-by-p, n is #observation, p is dim of feature
%       dataC n-by-1, the class of observations
%       candiFea    , candidate features filtered by candidateFeature
%       wrapper     , 'back' or 'for'
%       classifier  , 'NB' or 'LDA'
% Output: compact feature

function obj = compactWrapper(obj, wrapper)

if nargin == 1
    wrapper = obj.wrapper;
end

kFold = 10;
if strcmp(wrapper, 'back')
    [ cmptFea, errRcd ] = backWrapper(obj.dataX, obj.dataC, obj.candiFea, obj.classifier, kFold);
elseif strcmp(wrapper, 'for')
    [ cmptFea, errRcd ] = forWrapper(obj.dataX, obj.dataC, obj.candiFea, obj.classifier, kFold);
end

obj.cmptFea = cmptFea;
obj.errRcd  = errRcd;
obj.wrapper = wrapper;

end


% backward wrapper
function [ cmptFea, errRcd ] = backWrapper(dataX, dataC, candiFea, classifier, kFold)

conti       = true;
errClass    = cvErrEst(dataX(:,candiFea), dataC, classifier, kFold);

while conti

    m       = length(candiFea);
    if (m==0); break; end;
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

nCmptFea = length(cmptFea);
errRcd   = zeros(nCmptFea, 1);
for Sid = 1 : nCmptFea
    idx = candiFea(1:Sid);
    errRcd(Sid) = cvErrEst(dataX(:,idx), dataC, classifier, kFold);
end
    
end

% forward wrapper
function [ cmptFea, errRcd ] = forWrapper(dataX, dataC, candiFea, classifier, kFold)

conti       = true;

errClass    = 1;
cmptFea     = [];
cmptIdx     = 0;
errRcd      = [];

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
        candiFea(goodIdx)    = [];
        if errK < errClass; cmptIdx = length(cmptFea); end;
        errClass = errK;
        errRcd  = [errRcd; errClass];
    else
        cmptFea = cmptFea(1:cmptIdx);
        errRcd  = errRcd(1:cmptIdx);
        conti   = false;
    end
    
end

end