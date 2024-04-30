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

        function outputArg = Prompt_user_input_request(this,prompt,dlgtitle,fieldsize,definput)
            
            outputArg = inputdlg(prompt,dlgtitle,fieldsize,definput);
            

        end


        function outputArg = Prompt_user_mssage(this)
            fig = uifigure;
            uialert(fig,"Angio_REFF Not Exist!","Invalid File","Icon",'error');
            close(fig);
            outputArg=this;

        end
    end
end