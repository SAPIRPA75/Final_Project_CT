classdef utilities
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here

    properties ( Access = public)
       
        m_sFolderPath;
        m_pHandleInterp;
    end

    methods
        function this = utilities()
           
            this.m_pHandleInterp = [];
        end


        function out = Set_interp_Handle(this,i_pHandlePlot)
                
            this.m_pHandleInterp = i_pHandlePlot;
            out =this;
        end
        
        function outputArg = Create_Plot_Folder(this,l_sFloderName)
            folderName = l_sFloderName;  
            this.m_sFolderPath = fullfile(pwd, folderName); 
            
            if exist(this.m_sFolderPath, 'dir') ~= 7
                mkdir(folderName);
                disp(['Folder created: ' this.m_sFolderPath]);
            else
                disp(['Folder already exists: ' this.m_sFolderPath]);
            end

            outputArg=this;

        end
    end
end