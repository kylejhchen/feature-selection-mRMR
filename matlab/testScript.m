% test script
clear; clc;


% ===== Test for candidateFeature =====
load('/Users/kylechen/Dropbox/Github/feature-selection-mRMR/dataset/mfeat/binarizedData.mat');
dataX = double(binarizedData);
dataC = kron((1:10)',ones(200,1));
nMRMR = 100;
wrapper = 'back';
classifier = 'NB';
errThres = 1e-1;
candiFea = candidateFeature(dataX, dataC, nMRMR, classifier, errThres);
cmptFea = compactWrapper(dataX, dataC, candiFea, classifier, wrapper);

% ===== Test for candidateFeature =====
% load fisheriris
% dataX = meas;
% dataC = [ones(50,1); 2*ones(50,1); 3*ones(50,1)];
% nMRMR = 100;
% wrapper = 'back';
% classifier = 'NB';
% candiFea = candidateFeature(dataX, dataC, nMRMR, wrapper, classifier);

% ===== Test for mRMR =====
% file = '/Users/kylechen/Documents/MATLAB/hcPengMRMR/mRMR/mRMR_0.9_compiled/test_lung_s3.csv';
% dataset = load(file);
% 
% dataC = dataset(:,1);
% dataX = dataset(:,2:end);
% 
% nSelect = 10;
% tic;
% myFea   = mRMR(dataX, dataC, nSelect);
% toc;
% tic;
% feaPeng = mrmr_mid_d(dataX, dataC, nSelect);
% toc;
% Lia = ismember(myFea,feaPeng)