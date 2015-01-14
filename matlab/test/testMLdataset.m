% test for MLdataset
clear; cc;
load('/Users/kylechen/Dropbox/Github/feature-selection-mRMR/dataset/mfeat/binarizedData.mat');
rawX = rawData;
dataC = kron((1:10)',ones(200,1));
nMRMR = 10;
wrapper = 'back';
classifier = 'NB';
errThres = 1e-1;
kFold    = 10;

preDataMethod = 'binarize';

mydataset = MLdataset(rawX, dataC);
% mydataset.prepareData(preDataMethod);
mydataset = mydataset.prepareData(preDataMethod);
mydataset = mydataset.candidateFeature(nMRMR, classifier, errThres, kFold);
mydataset = mydataset.compactWrapper(wrapper);

mydataset.plot('-ob')
% get(mydataset)
% set(mydataset, 'dataX', test)