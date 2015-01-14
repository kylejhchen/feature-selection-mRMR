classdef MLdataset
    
    properties
        rawDataX
        rawDataC

        dataX
        dataC
        
        nMRMR
        wrapper
        classifier
        errThres
        kFold
        
        mrmrFea
        candiFea
        cmptFea
        errRcd
    end
    
    methods
        
        function obj = MLdataset(rawX, rawC)
            obj.rawDataX = rawX;
            obj.rawDataC = rawC;
            obj.dataX    = rawX;
            obj.dataC    = rawC;
        end
        
%         function obj = set.dataX(obj, dataX)
%             obj.dataX = dataX;
%         end
%         function obj = set.dataC(obj, dataC)
%             obj.dataC = dataC;
%         end
        
    end
    
    methods
        
        % preprocessing data
        obj = prepareData(obj, method)
        obj = candidateFeature(obj, nMRMR, classifier, errThres, kFold)
        obj = compactWrapper(obj, wrapper)
        hPlot = plot(obj, plotOpt, hPlot)
        
    end
    
    methods (Access = private)
        mi = mutualInfoDis(obj, x, y)
        bMI = bundleMI(obj, X, y)
        [meanErr, varErr, mt2Err] = cvErrEst(obj, dataX, dataC, classifier, kFold)
    end
    
end