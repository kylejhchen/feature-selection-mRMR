% feature-selection-mRMR
% Created by Jiahong K. Chen

function [meanErr, varErr, mt2Err] = cvErrEst(dataX, dataC, classifier, kFold)

% not support for R2011a
% if strcmp(classifier,'LDA')
%     classifyFun = @fitcdiscr;
% elseif strcmp(classifier,'NB')
%     classifyFun = @NaiveBayes.fit;
% else
%     error('Incorrect classifier')
% end

nSample = size(dataX, 1);
indices = crossvalind('Kfold', nSample, kFold);

errSn   = zeros(kFold, 1);

for i = 1:kFold
    
    cp          = classperf(dataC);
    test        = (indices == i); 
    train       = ~test;
    
    if strcmp(classifier,'LDA')
        predClass   = classify(dataX(test,:), dataX(train,:), dataC(train,:));
    elseif strcmp(classifier,'NB')
        fitModel    = NaiveBayes.fit(dataX(train,:), dataC(train,:), 'Distribution', 'mvmn');
        predClass   = predict(fitModel, dataX(test,:));
    else
        error('Incorrect classifier')
    end

    classperf(cp, predClass, test);
    
    errSn(i)    = cp.ErrorRate;

end

meanErr = mean(errSn);
varErr  = var(errSn);
mt2Err  = mean(errSn.^2);

end