% feature-selection-mRMR
% Created by Jiahong K. Chen

function obj = plot(obj, plotOpts)

if isempty(obj.hPlot); clf(obj.hPlot); end;

obj.hPlot = figure(1);

if strcmp(obj.wrapper, 'back')
    titleStr = [inputname(1), ': ', obj.classifier, ' Backward'];
    iter     = length(obj.candiFea):-1:length(obj.cmptFea);
elseif strcmp(obj.wrapper, 'for')
    titleStr = [inputname(1), ': ', obj.classifier, ' Forward'];
    iter     = 0:length(obj.errRcd)-1;
end

plot(iter, obj.errRcd, plotOpts);
if strcmp(obj.wrapper, 'back'); set(gca, 'XDir', 'reverse'); end;
title(titleStr, 'fontsize', 16);
xlabel('feature number', 'FontSize', 16);
ylabel('error rate', 'FontSize', 16);


% legendStr = {'forward'; 'backward'};
% h_legend  = legend(legendStr);
% set(h_legend,'FontSize',16);

filename = strcat(obj.classifier, obj.wrapper, num2str(obj.nMRMR,'%02d'), '.eps');
print(obj.hPlot, filename,'-depsc');

end