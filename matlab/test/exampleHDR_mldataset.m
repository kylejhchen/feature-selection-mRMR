% example of HDR
clear; cc;
load('/Users/kylechen/Dropbox/Github/feature-selection-mRMR/dataset/mfeat/binarizedData.mat');
rawX        = rawData;
dataC       = kron((1:10)',ones(200,1));
nMRMR       = 10;
wrapper     = 'back';
classifier  = 'NB';
errThres    = 1e-1;
kFold       = 10;
preDataMtd  = 'binarize';

mydataset   = MLdataset(rawX, dataC);
mydataset   = mydataset.prepareData(preDataMtd);
mydataset   = mydataset.candidateFeature(nMRMR, classifier, errThres, kFold);

mydatasetFor  = mydataset.compactWrapper('for');
mydatasetBack = mydataset.compactWrapper('back');



% Plot
hPlot = mydatasetFor.plot('-ob');
hPlot = mydatasetBack.plot('->r', hPlot);

legendStr = {'forward'; 'backward'};
h_legend  = legend(legendStr);
set(h_legend,'FontSize',16);

filename = strcat('errF_B_', 'kernel_', num2str(nMRMR,'%03d'), '.eps');
print(hPlot,filename,'-depsc2','-r300');
