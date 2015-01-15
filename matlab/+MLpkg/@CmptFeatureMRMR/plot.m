% feature-selection-mRMR
% Created by Jiahong K. Chen

function obj = plot(obj, plotOpts)

if isempty(obj.hPlot)
    obj.hPlot = figure(1);
else
    figure(obj.hPlot);
    hold on;
end

plot(obj.errRcd, plotOpts);
% title('', 'fontsize', 16);
xlabel('feature number', 'FontSize', 16);
ylabel('error rate', 'FontSize', 16);


end