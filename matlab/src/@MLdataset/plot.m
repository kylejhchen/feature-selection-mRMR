function hPlot = plot(obj, plotOpt, hPlot)

if nargin < 3
    hPlot = figure(1);
end

hold on;
plot(obj.errRcd, plotOpt);
% title('', 'fontsize', 16);
xlabel('feature number', 'FontSize', 16);
ylabel('error rate', 'FontSize', 16);


end