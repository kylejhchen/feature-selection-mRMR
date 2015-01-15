% example of HDR
clear; cc;
% import MLpkg.*;

dataPath    = '/Users/kylechen/Dropbox/Github/feature-selection-mRMR/matlab/data/';
dataSet     = 'mfeat.mat';
dataFile    = [dataPath, dataSet];
load(dataFile);

rawX        = rawData;
dataC       = kron((1:10)',ones(200,1));
preDataMtd  = 'binarize';

nMRMR       = 50;
wrapper     = 'for';
classifier  = 'NB';
errThres    = 1e-1;
kFold       = 10;

tic;
HDRdataset  = MLpkg.CmptFeatureMRMR(rawX, dataC);

HDRdataset.prepareData(preDataMtd);
HDRdataset.setModelPara(nMRMR, classifier, wrapper, errThres, kFold);

HDRdataset.findCandidateFeature();

% Plot
HDRdataset.compactWrapper('for');
HDRdataset.plot('-ob');
HDRdataset.compactWrapper('back');
HDRdataset.plot('->r');
toc;
