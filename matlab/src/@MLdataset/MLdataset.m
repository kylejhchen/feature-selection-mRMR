

classdef MLdataset < matlab.mixin.SetGet
    
    properties
        rawDataX
        rawDataC
    end % raw data
    
    properties (SetAccess = private)
        preDataMtd
        dataX
        dataC
    end % processed data
    
    properties (SetAccess = private)
        nMRMR
        wrapper
        classifier
        errThres
        kFold
    end % model parameter
    
    properties (SetAccess = private)
        mrmrFea
        candiFea
        cmptFea
        errRcd
    end % model results
    
    properties
       hPlot 
    end % figure properties
    
    methods
        
        % Construtor
        function obj = MLdataset(rawX, rawC)
            obj.rawDataX = rawX;
            obj.rawDataC = rawC;
            obj.dataX    = rawX;
            obj.dataC    = rawC;
        end % MLdataset
        
        % Parameter setter
        setModelPara(obj, nMRMR, classifier, wrapper, errThres, kFold)
        set(obj, PropName, value)
        
    end % Parameter settings
    
    methods
        
        % preprocessing data
        prepareData(obj, method)
        
        % feature selection
        findCandidateFeature(obj, nMRMR, classifier, errThres, kFold)
        compactWrapper(obj, wrapper)
        
        % ploting tools
        plot(obj, plotOpt)
        saveImage(obj, filename)
        
    end % Public methods
    
%     methods (Access = private)
%         mi = mutualInfoDis(obj, x, y)
%         bMI = bundleMI(obj, X, y)
%         [meanErr, varErr, mt2Err] = cvErrEst(obj, dataX, dataC, classifier, kFold)
%     end
    
end