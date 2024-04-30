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
        m_matRegistered;
        m_pMskBox;
        m_CMaskROIAnalysys;
        m_iColoredSet;
        m_MatColorizedArtery;
    end

    methods
        function this = Analysys_CT()

            this.dStep_inteval_PERFUSION = 1/this.iRepiptive_frame_PERFUSION;
            this.m_pMskBox = Dialog_box();
            this.m_CMaskROIAnalysys = cell(30,23);
            this.m_iColoredSet=1;
            % columnNames = {'set','MeanIntensity', 'CurrentTime', 'BinaryImage'};
            % this.table_Perfusion = table('Size',[690 4],'VariableNames',columnNames,'VariableTypes',{'double','double','double','cell'});

                                                        
        end

        function outputArg = Canny_Edge_Detection(this)

            %outputArg=imbinarize(this.ROI_Mask, this.Global_image_threshold);
            outputArg = this.mat_sdicom_Images{this.count_analysys_img,1};
            %edges = edge(this.ROI_Mask,'canny',this.Global_image_threshold,0.5); % To detemine Deviation
            %outputArg=edges;
            %outputArg= imfill(edges, 'holes');
            %outputArg = imbinarize(this.ROI_Mask,this.Global_image_threshold);
            % imshow(outputArg);
            % 
            % close(gcf);

           %outputArg = edge(this.ROI_Mask,'canny',[0.01 0.05],0.5); % To detemine Deviation
           
        end

        function outputArg = HEAD_PERFUSION_Detection(this)

               %matCanny_resault = edge(this.ROI_Mask,'canny',this.Global_image_threshold,0.5); % To detemine Deviation
                %matCanny_resault=imbinarize(this.ROI_Mask, this.Global_image_threshold);
                
               dMean_pixelIntensities = mean(this.ROI_Mask(:));
               dTime_set = this.iSet_Counter + this.iBlock_Counter*this.dStep_inteval_PERFUSION;
               this.m_CMaskROIAnalysys{(this.iSet_Counter+1),this.iBlock_Counter}=this.ROI_Mask; 
               sSet_name= "set" + num2str((this.iSet_Counter+1));
               % sBlock_name = "block_" + num2str(this.iBlock_Counter);
               sBlock_name= {dMean_pixelIntensities,dTime_set};
               this.table_Perfusion{this.iBlock_Counter,sSet_name} = sBlock_name;
               %%outputArg =this.table_Perfusion;
               outputArg=this;


        end

         function [x ,y] = Get_Axis_Perfusion(this)
             
             l_bInitFlag=1;
             y= [];
             x=0;
             i=1;
             j=2;
             this.iSet_Counter =1;
                while this.iSet_Counter <=30
                    sSet_name= "set" + num2str((this.iSet_Counter));
                    Data_vecotr = this.table_Perfusion{str2double(this.iFrame_number_chosen),sSet_name};
                    if(l_bInitFlag)
                        y= Data_vecotr{1,1};
                        l_bInitFlag=~l_bInitFlag;
                    end
                    y=[y, Data_vecotr{1,1}];
                    x=[x,Data_vecotr{1,2}];
                    
                    this.iSet_Counter = this.iSet_Counter +1;
                end

                l_bInitFlag=~l_bInitFlag;

         end


         function out = Get_registered_Image(this,g_iCounterMatDetection,i_sFolderPlotPath)
                 l_pSaveLastDir = pwd;
                 this.m_pUtilFolder.m_sFolderPath=i_sFolderPlotPath;
                 cd(this.m_pUtilFolder.m_sFolderPath);
                %this.m_pUtilFolder.m_sFolderPath=i_sDirRoiPath;% Change Dir for Spesific ROI {i.e every patient have therre own ROI
                    if(exist(fullfile(this.m_pUtilFolder.m_sFolderPath,'Regestrions_Points.mat'),"file"))
                        load(fullfile(this.m_pUtilFolder.m_sFolderPath,'Regestrions_Points.mat'));
                         load(fullfile(this.m_pUtilFolder.m_sFolderPath,'ANGIO_REFF.mat'));
                         t = fitgeotform2d(mp,fp,"projective");
                        pRfixed = imref2d(size(this.mat_Chosen_Edge_Detection{g_iCounterMatDetection}));
                         this.m_matRegistered = imwarp(variable,t,OutputView=pRfixed);
                         cd(l_pSaveLastDir);
                        out=this;
                        return;
                    else
                        if(exist(fullfile(this.m_pUtilFolder.m_sFolderPath,'Angio_REFF.mat'),"file"))
                            load(fullfile(this.m_pUtilFolder.m_sFolderPath,'Angio_REFF.mat'));
                             this.m_matANGIO_REFF=variable;
                        else
                           this.m_pMskBox=this.m_pMskBox.Prompt_user_mssage();
                        end

                        if(exist(fullfile(this.m_pUtilFolder.m_sFolderPath,'Head_Perfusion_REFF.mat'),"file"))
                            load(fullfile(this.m_pUtilFolder.m_sFolderPath,'Head_Perfusion_REFF.mat'));
                             this.m_matHead_Perfusion_REFF= variable;
                        else
                            variable=this.mat_Chosen_Edge_Detection{g_iCounterMatDetection};
                            save(fullfile(this.m_pUtilFolder.m_sFolderPath, 'Head_Perfusion_REFF.mat'),'variable');
                            disp('Saved Head_Perfusion_REFF.mat');
                            load(fullfile(this.m_pUtilFolder.m_sFolderPath,'Head_Perfusion_REFF.mat'));
                            this.m_matHead_Perfusion_REFF= variable;
                        end
                        [mp,fp] = cpselect(this.m_matANGIO_REFF*25,this.m_matHead_Perfusion_REFF*25,Wait=true);
                        save(fullfile(this.m_pUtilFolder.m_sFolderPath, 'Regestrions_Points.mat'), 'mp','fp');
                         t = fitgeotform2d(mp,fp,"projective");
                        pRfixed = imref2d(size(this.mat_Chosen_Edge_Detection{g_iCounterMatDetection}));
                         this.m_matRegistered = imwarp(this.m_matANGIO_REFF,t,OutputView=pRfixed);
                         cd(l_pSaveLastDir);
                        out=this;
                        return;

                    end
                

         end

         function out = GetAbsImgDiff(this,first,second)


                  diff1 = imabsdiff(second, first);  
                  l_dmean=mean(diff1(:));
                % Combine differences into a single color image for visualization
                if (l_dmean > 0.1319*1.15 || l_dmean < 0.1319*0.85)
                     combined_diff = cat(3,zeros(size(diff1)) , diff1, zeros(size(diff1)));  
                else
                     combined_diff = cat(3, diff1, zeros(size(diff1)), zeros(size(diff1)));  
                end
                out = combined_diff;

         end


         function out = PlotArteryColorChanges(this)

                 l_bGuardMaxSet = 1;
                 if (l_bGuardMaxSet)
                this.m_MatColorizedArtery=this.GetAbsImgDiff(this.m_CMaskROIAnalysys{this.m_iColoredSet,8}*25,this.m_CMaskROIAnalysys{(this.m_iColoredSet+1),8}*25);
                 end
                % Display the combined differences as a color image
                this.m_iColoredSet =  this.m_iColoredSet+1;
                if(this.m_iColoredSet >= 30)
                    l_bGuardMaxSet = 0;
                end
                %figure;
                %imshow(this.m_MatColorizedArtery*100);
                %title('Visualized Differences');
               

             out=this;
         end
    end
end