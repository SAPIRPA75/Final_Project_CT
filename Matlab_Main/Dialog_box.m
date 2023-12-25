classdef Dialog_box < utilities 

    properties ( Access = public)
        
    end

    methods
        function this = Dialog_box()

        end

        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end