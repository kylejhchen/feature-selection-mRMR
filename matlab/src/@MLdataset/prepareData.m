% feature-selection-mRMR
% Created by Jiahong K. Chen

function obj = prepareData(obj, method)
    
    obj.preDataMtd = method;
    if strcmp(method, 'binarize')
        obj.dataX = binarizeData(obj.rawDataX);
    end

end