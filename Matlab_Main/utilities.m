classdef utilities
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here

    properties ( Access = public)
       
    end

    methods
        function this = utilities()
           
        end

        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end