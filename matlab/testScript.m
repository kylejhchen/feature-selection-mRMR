% test script
clear; clc;

file = '/Users/kylechen/Documents/MATLAB/hcPengMRMR/mRMR/mRMR_0.9_compiled/test_lung_s3.csv';
dataset = load(file);

dataC = dataset(:,1);
dataX = dataset(:,2:end);

nSelect = 10;

tic;
myFea   = mRMR(dataX, dataC, nSelect);
toc;
% tic;
% feaPeng = mrmr_mid_d(dataX, dataC, nSelect);
% toc;
% Lia = ismember(myFea,feaPeng)