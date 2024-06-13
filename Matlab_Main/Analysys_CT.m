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
        m_iNumOfTables;
        
    end
        
    properties(Access = private)
        
            m_iStd;
            m_iPickValue;

    end


    methods (Access = public)
        function this = Analysys_CT()

            this.dStep_inteval_PERFUSION = 1/this.iRepiptive_frame_PERFUSION;
            this.m_pMskBox = Dialog_box();
            this.m_CMaskROIAnalysys = cell(30,23);
            this.m_iColoredSet=1;
            this.m_iNumOfTables= 1;
            this.m_iStd=0;
            this.m_iPickValue=0;

                                                        
        end

        function outputArg = Canny_Edge_Detection(this)

            outputArg = this.mat_sdicom_Images{this.count_analysys_img,1};
           
        end

        function outputArg = HEAD_PERFUSION_Detection(this,i_sFolderPlotPath)

              

               dMean_pixelIntensities = mean(this.ROI_Mask(:));
               dTime_set = this.iSet_Counter + this.iBlock_Counter*this.dStep_inteval_PERFUSION;
               this.m_CMaskROIAnalysys{(this.iSet_Counter+1),this.iBlock_Counter}=this.ROI_Mask; 
              
             
               sSet_name= "set" + num2str((this.iSet_Counter+1));
               sBlock_name= {dMean_pixelIntensities,dTime_set};
               this.table_Perfusion{this.iBlock_Counter,sSet_name} = sBlock_name;
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

                   l_imax = max(first(:));

                   l_iGain = double(double(this.iY_Mean_Intensity_vector(this.m_iColoredSet))/double(l_imax));

                   l_matGainImg= double(first) * l_iGain;

                l_imax = max(l_matGainImg(:));

              
                
                % Initialize color channels
                red_channel = zeros(size(l_matGainImg));
                green_channel = zeros(size(l_matGainImg));
                blue_channel = zeros(size(l_matGainImg));
                


                % Assign colors based on thresholds
                for i = 1:size(l_matGainImg, 1)
                    for j = 1:size(l_matGainImg, 2)

                        if (l_matGainImg(i, j) < this.m_iPickValue && l_matGainImg(i, j) >0  )
                                

                              % Define thresholds based on sigma
                            threshold1 =  this.m_iPickValue - this.m_iStd; % 1 sigma
                            threshold2 =  this.m_iPickValue - 2 * this.m_iStd; % 2 sigma
                            % threshold3 =  this.m_iPickValue - 3 * this.m_iStd; % 3 sigma

                             if l_matGainImg(i, j) < threshold2
                            % Green for values greater than 3 sigma
                            green_channel(i, j) = 1;
                        elseif l_matGainImg(i, j) > threshold2 && l_matGainImg(i, j) < threshold1
                            % Orange for values between 2 sigma and 3 sigma
                            red_channel(i, j) = 1;
                            green_channel(i, j) = 0.5;
                        elseif l_matGainImg(i, j) < this.m_iPickValue &&  l_matGainImg(i, j) > threshold1
                            % Red for values between mean + sigma and mean + 2 sigma
                            red_channel(i, j) = 1;
                             end


                        elseif(l_matGainImg(i, j) >0)
                                
                                threshold1 =  this.m_iPickValue + this.m_iStd; % 1 sigma
                                threshold2 =  this.m_iPickValue + 2 * this.m_iStd; % 2 sigma
                                % threshold3 =  this.m_iPickValue + 3 * this.m_iStd; % 3 sigma
    
    
                                if l_matGainImg(i, j) > threshold2
                                % Green for values greater than 3 sigma
                                green_channel(i, j) = 1;
                            elseif l_matGainImg(i, j) < threshold2 && l_matGainImg(i, j) > threshold1
                                % Orange for values between 2 sigma and 3 sigma
                                red_channel(i, j) = 1;
                                green_channel(i, j) = 0.5;
                            elseif l_matGainImg(i, j) > this.m_iPickValue &&  l_matGainImg(i, j)< threshold1
                                % Red for values between mean + sigma and mean + 2 sigma
                                red_channel(i, j) = 1;
                                 end



                        end

                       
                    end
                end





                % Combine the color channels using cat function
                colored_image = cat(3, red_channel, green_channel, blue_channel);
                out = colored_image;

         end


         function out = PlotArteryColorChanges(this)

                    this=this.Calculate_Standard_Deviation();
                    
                 l_bGuardMaxSet = 1;
                 if (l_bGuardMaxSet)
                this.m_MatColorizedArtery=this.GetAbsImgDiff(this.m_CMaskROIAnalysys{this.m_iColoredSet,str2double(this.iFrame_number_chosen)}*25,this.m_CMaskROIAnalysys{(this.m_iColoredSet+1),str2double(this.iFrame_number_chosen)}*25);
                 end
                % Display the combined differences as a color image
                this.m_iColoredSet =  this.m_iColoredSet+1;
                if(this.m_iColoredSet >= 30)
                    l_bGuardMaxSet = 0;
                end
             
             out=this;
         end


         function Plot_Specific_TTP_ROI(this,i_iPosX,i_iPosY,i_vecTime,i_iFrame_Counter)
                

             

             l_istaticCounter=0;
             l_iTime_axis = 0:(this.dStep_inteval_PERFUSION):30;
                l_bFirstElemnet=1;
             for index = 1: numel(this.m_CMaskROIAnalysys)
                 
                 l_iIndex_mean=1;
                 if(mod(index,23) == str2double(this.iFrame_number_chosen))
                        
                    

                         if l_bFirstElemnet
                                l_MatstoredMatrix= this.m_CMaskROIAnalysys{index};
                                vecPixel_Intensities= l_MatstoredMatrix(i_iPosY,i_iPosX);
                                 l_bFirstElemnet=0;
                         end
    
    
                                 l_MatstoredMatrix= this.m_CMaskROIAnalysys{index};
                                 l_dPixel_Intensities= l_MatstoredMatrix(i_iPosY,i_iPosX);
                                 vecPixel_Intensities=[vecPixel_Intensities,l_dPixel_Intensities]; 

                     

                      l_iIndex_mean = l_iIndex_mean +1;  
                 end
             end

             l_handleInter = interp1(i_vecTime(7:end), double(vecPixel_Intensities(7:end)),l_iTime_axis, 'linear');
             
             figure;


              
              plot(i_vecTime(7:end),double(vecPixel_Intensities(7:end)),'o',l_iTime_axis,l_handleInter,':.');
              xlabel('Time [sec]');
              ylabel('Vessel Intensity [HU]');
              title('TIME ATTENUATION CURVE');
              colorbar;



         end
    end

    methods (Access = private)

        function out = Calculate_Standard_Deviation(this)
           
            this.m_iPickValue = mean(this.iY_Mean_Intensity_vector);
            
            sum_squared_deviations = sum((this.iY_Mean_Intensity_vector - this.m_iPickValue).^2);
            
            sample_variance = sum_squared_deviations / (length(this.iY_Mean_Intensity_vector) - 1);
            
            this.m_iStd = sqrt(sample_variance);

            this.m_iPickValue= max(this.iY_Mean_Intensity_vector);

            out=this;

        end
    end
end