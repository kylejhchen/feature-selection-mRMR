% feature-selection-mRMR
% Created by Jiahong K. Chen

function setModelPara(obj, nMRMR, classifier, wrapper, errThres, kFold)

obj.nMRMR       = nMRMR;
obj.wrapper     = wrapper;
obj.classifier  = classifier;
obj.errThres    = errThres;
obj.kFold       = kFold;

end