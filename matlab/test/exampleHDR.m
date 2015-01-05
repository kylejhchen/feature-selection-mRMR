% Example of HDR dataset
clear; clc;

egPath = '/Users/kylechen/Dropbox/Github/feature-selection-mRMR/matlab/test';
cd(egPath);

load('/Users/kylechen/Dropbox/Github/feature-selection-mRMR/dataset/mfeat/binarizedData.mat');
dataX = binarizedData;
dataC = kron((1:10)',ones(200,1));
nMRMR = 50;
wrapper = 'back';
classifier = 'NB';
errThres = 1e-1;
tic;
candiFea = candidateFeature(dataX, dataC, nMRMR, classifier, errThres);
% cmptFea = compactWrapper(dataX, dataC, candiFea, classifier, wrapper);
[ fCmptFea, fErrRcd ] = compactWrapper(dataX, dataC, candiFea, classifier, 'for');
[ bCmptFea, bErrRcd ] = compactWrapper(dataX, dataC, candiFea, classifier, 'back');
toc;

hPlot = figure(1);
hold on;
plot(fErrRcd, '-ob');
plot(bErrRcd, '->r');
% title('', 'fontsize', 16);
xlabel('feature number', 'FontSize', 16);
ylabel('eror rate', 'FontSize', 16);
legendStr   = {'forward'; 'backward'};
h_legend = legend(legendStr);
set(h_legend,'FontSize',16);

filename = strcat('errF_B_', num2str(nMRMR,'%03d'), '.eps');
print(hPlot,filename,'-depsc2','-r300');
