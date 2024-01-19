classdef Analysys_CT < ROI_CT
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here

    properties (Access = public)
        mat_Chosen_Edge_Detection = [];
        count_analysys_img = 1;%366
        iSet_Counter = 0;
        iBlock_Counter=1;
        table_Perfusion = table();
        dStep_inteval_PERFUSION = [];
        iRepiptive_frame_PERFUSION = 23;
        iSet_Step_Counter = 1;
        iX_Time_Vector = [];
        iY_Mean_Intensity_vector = [];
        iFrame_number_chosen =[];
    end

    methods
        function this = Analysys_CT()

            this.dStep_inteval_PERFUSION = 1/this.iRepiptive_frame_PERFUSION;
         
            % columnNames = {'set','MeanIntensity', 'CurrentTime', 'BinaryImage'};
            % this.table_Perfusion = table('Size',[690 4],'VariableNames',columnNames,'VariableTypes',{'double','double','double','cell'});

                                                        
        end

        function outputArg = Canny_Edge_Detection(this)

            edges = edge(this.ROI_Mask,'canny',this.Global_image_threshold,0.5); % To detemine Deviation
            outputArg=edges;
            %outputArg= imfill(edges, 'holes');
            %outputArg = imbinarize(this.ROI_Mask,this.Global_image_threshold);
            % imshow(outputArg);
            % 
            % close(gcf);

           %outputArg = edge(this.ROI_Mask,'canny',[0.01 0.05],0.5); % To detemine Deviation
           
        end

        function outputArg = HEAD_PERFUSION_Detection(this)

               matCanny_resault = edge(this.ROI_Mask,'canny',this.Global_image_threshold,0.5); % To detemine Deviation
               dMean_pixelIntensities = mean(matCanny_resault(:));
               dTime_set = this.iSet_Counter + this.iBlock_Counter*this.dStep_inteval_PERFUSION;
               sSet_name= "set" + num2str((this.iSet_Counter+1));
               % sBlock_name = "block_" + num2str(this.iBlock_Counter);
               sBlock_name= {dMean_pixelIntensities,dTime_set};
               this.table_Perfusion{this.iBlock_Counter,sSet_name} = sBlock_name;
               outputArg =this.table_Perfusion;


        end

         function [x ,y] = Get_Axis_Perfusion(this)
             
             y= [];
             x=[];
             i=1;
             j=2;
             this.iSet_Counter =0;
                while this.iSet_Counter <30
                    sSet_name= "set" + num2str((this.iSet_Counter+1));
                    Data_vecotr = this.table_Perfusion{str2double(this.iFrame_number_chosen),sSet_name};
                    y=[y, Data_vecotr{1,1}];
                    x=[x,Data_vecotr{1,2}];
                    this.iSet_Counter = this.iSet_Counter +1;
                end

           end
    end
end