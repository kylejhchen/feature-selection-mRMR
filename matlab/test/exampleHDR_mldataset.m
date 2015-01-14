% example of HDR
clear; cc;
load('/Users/kylechen/Dropbox/Github/feature-selection-mRMR/dataset/mfeat/binarizedData.mat');
rawX        = rawData;
dataC       = kron((1:10)',ones(200,1));
nMRMR       = 10;
wrapper     = 'for';
classifier  = 'NB';
errThres    = 1e-1;
kFold       = 10;
preDataMtd  = 'binarize';

mydataset   = MLdataset(rawX, dataC);

mydataset.prepareData(preDataMtd);
mydataset.setModelPara(nMRMR, classifier, wrapper, errThres, kFold);

mydataset.findCandidateFeature();

% Plot
mydataset.compactWrapper('for');
mydataset.plot('-ob');
mydataset.compactWrapper('back');
mydataset.plot('->r');

legendStr = {'forward'; 'backward'};
h_legend  = legend(legendStr);
set(h_legend,'FontSize',16);

filename = strcat('errF_B_', 'kernel_', num2str(nMRMR,'%03d'), '.eps');
print(mydataset.hPlot, filename,'-depsc');
