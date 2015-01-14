function obj = prepareData(obj, method)

    if strcmp(method, 'binarize')
        obj.dataX = binarizeData(obj.rawDataX);
    end

end