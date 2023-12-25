classdef Time_Frequency<utilities
    %UNTITLED7 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        
    end

    methods
        function this = Time_Frequency()
          
        end

        function outputArg = Set_Time_Frequency(this,Time_duration,Num_frames)
            

            outputArg = (Time_duration/Num_frames);
        end
    end
end