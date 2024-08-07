classdef CT_Perfusion
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here

    properties (Access = protected)
        
        Struct_dicom_collection = struct();
        Struct_Dicom_Files = struct();
        csv_file_path = 'Dicom_Table_properties.csv';
        Dicom_file_check= [];
       
        UTIL_Dialog =[];
        UTIL_Load = [];
        UTIL_Error_handle = [];
        
        
    end

    properties (Access = public)

        Table_Dicom_Full_Data =[];
        App_Chosen_seris=[];
        Chosen_section_data = [];
        Array_Dicom_Paths =[];
        mat_sdicom_Images = {};
        arr_sNot_Sorted_Dicom_Files= [];
        arr_New_Sorted_Dicom_Images= [];
        arr_sTable_display=[];
        med_Image = [];
        Table_dicom_collection= [];
        sCurrent_folder =[];
        iRow_Location_in_table=[];
        icol_Location_in_table= [];
        sNew_Dicom_file_folder=[];
        bIs_Foler_empty = true;
        Table_analysed_ROI_Dicom =[];
        UTIL_freq=[];
        App_Choose_Patient=[];
        Table_Patient_Name=[];
        m_matHead_Perfusion_REFF;
        m_matANGIO_REFF;
        
    end

    methods
        function this = CT_Perfusion()
            
            this.sCurrent_folder = pwd;
            this.UTIL_Dialog = Dialog_box();
            this.UTIL_Load = Load_Box();
            this.UTIL_Error_handle = Error_Handle();
            this.UTIL_freq = Time_Frequency();

        end

        function [Output_buffer] = Get_Patient_Table_Names(this)

            Output_buffer = readcell("Table_Patient_Names.xlsx");

        end

        function out= Get_Patient_MCA_Index(this)


        end

        function    [Out_buffer1, Out_buffer2] = Create_Sorted_Dicom_Files_From_ROI(this)
                    
            sNew_Dicom_file_name = ['frame_No_',num2str(this.count_analysys_img)];
            this.sNew_Dicom_file_folder = [this.sCurrent_folder,'\F_1990_After_Proccess','\',this.App_Chosen_seris];
            check_if_empty=dir(this.sNew_Dicom_file_folder);
            this.bIs_Foler_empty =numel(check_if_empty) <=2; 
            if(this.count_analysys_img ==1 &&  this.bIs_Foler_empty )
                  
                mkdir(this.sNew_Dicom_file_folder);
                sNew_Dicom_file_location = [this.sNew_Dicom_file_folder,'\',sNew_Dicom_file_name];
                dicomwrite(this.mat_Chosen_Edge_Detection{app.vDSA.count_analysys_img,1},sNew_Dicom_file_location);
            end
           

            Out_buffer1 = this.sNew_Dicom_file_folder;
            Out_buffer2 = this.bIs_Foler_empty;
             

        end

        function Out_buffer = Create_analysed_ROI_file(this)
                
            sourceTable=dicomCollection(this.sNew_Dicom_file_folder);
            Saved_location = [this.sNew_Dicom_file_folder,'\','analysed_ROI_Dicom_Images.csv'];
             writetable(sourceTable, Saved_location);
             Out_buffer = readtable(Saved_location);

           
        end

        function Out_buffer = Get_Table_Dicom(this)

                Out_buffer= this.Table_Dicom_Full_Data{:,11};
                
        end

        function [Output_Buffer1,Output_Buffer2] = Get_New_Sorted_Dicom_Dim(this)

             
             [Output_Buffer1,Output_Buffer2]=size(this.arr_New_Sorted_Dicom_Images);



        end

        function Output_Buffer = Set_New_Sorted_Mat_Dicom(this)
        

           for i = 1 : this.iRow_Location_in_table
            sRead_img = this.arr_New_Sorted_Dicom_Images{i,1};
            Output_Buffer{i,:}= dicomread(sRead_img,"frames",1); 

           end

        end

        function Output_Buffer = Sorted_Dicom_Img(this)

                  iLength_Of_Struct=size(this.arr_sNot_Sorted_Dicom_Files,1);
                  Struct_sbuffer_dicom_Images = this.arr_sNot_Sorted_Dicom_Files;
                  j=1;
                  for i = 1 : iLength_Of_Struct

                         while (Struct_sbuffer_dicom_Images{j,2} ~= i)
            
                                  j=j+1;
                          end

                 Output_Buffer{i,1} =Struct_sbuffer_dicom_Images{j,1};
                 Output_Buffer{i,2} = i;
                 j=1;
                 end

        end


        function  Output_Buffer = Get_All_Dicom_Path(this)
                    
                     iRow_Location_in_table=[];
                     icol_Location_in_table= [];
                    counter=1;

                     [iRow_Location_in_table,icol_Location_in_table]=size(this.Chosen_section_data);

                    for i=1 : icol_Location_in_table
                        
                        if( i> 13 && ~isempty(this.Chosen_section_data{i}))
                            
                            Output_Buffer{counter,:} =  this.Chosen_section_data{i};
                            counter = counter+1;
                        end
                    end

                   


        end

        

        function [Output_Buffer1, Output_Buffer2] = Create_Dicom_Matrix(this)

                 iRow_Location_in_table=[];
                 icol_Location_in_table= [];

               
                
        [iRow_Location_in_table,icol_Location_in_table] = size(this.Array_Dicom_Paths);

        

         this.mat_sdicom_Images=cell(iRow_Location_in_table,icol_Location_in_table);

            pLoad_Handle = this.UTIL_Load.Get_Load_Box_handle(); % Initial progress is 0%


             for i = 1 : iRow_Location_in_table
                sRead_img = this.Array_Dicom_Paths{i,:};
                this.mat_sdicom_Images{i,icol_Location_in_table}= dicomread(sRead_img,"frames",1); 
                info =dicominfo( sRead_img);
                this.arr_sNot_Sorted_Dicom_Files{i,1} = sRead_img;
                this.arr_sNot_Sorted_Dicom_Files{i,2} = info.InstanceNumber;
                InstanceNumber(i)= info.InstanceNumber;% for Debug Process % mybe needed serisTime for differnt seris

                this.UTIL_Load.Porcess_load(i/iRow_Location_in_table,pLoad_Handle,'Creating dicom metrix');
             end

            this.UTIL_Load.Close_Load_ny_handle(pLoad_Handle);  

            Output_Buffer1 =  this.mat_sdicom_Images;
            Output_Buffer2 =  this.arr_sNot_Sorted_Dicom_Files;
        
            
        end


        function Output_Buffer = Get_Chosen_Dicom_Section(this)

                    iRow_Location_in_table=[];
                    icol_Location_in_table= [];
                    row =0;

                    [iRow_Location_in_table,icol_Location_in_table]=size(this.Table_Dicom_Full_Data);
                    for i=1 : iRow_Location_in_table
                            if (ismember(this.App_Chosen_seris,this.Table_Dicom_Full_Data{i,:}))
                                row= i;
                            end
                    end


                  Output_Buffer = this.Table_Dicom_Full_Data{row,:};
                 
       
            
        end

      

        function outputArg = Create_Table_Data(this)

            if (isempty(this.App_Choose_Patient))
                this.App_Choose_Patient=this.Table_Patient_Name{10,1};
                    
                Sselected_Folder=strcat(pwd,'\',this.App_Choose_Patient);
                Sselected_file_path=strcat(pwd,'\','Dicom_Table_properties_',this.App_Choose_Patient,'.csv');
                fileID = fopen(Sselected_file_path, 'r');

                if(fileID == -1)
                     Table_dicom_collection =dicomCollection(Sselected_Folder);
                      writetable(Table_dicom_collection, Sselected_file_path);
                      outputArg = readtable(Sselected_file_path);
                      return;
                
                else
                      fclose(fileID);
                      outputArg = readtable(Sselected_file_path);
                      return;
                end
                    
            else

                     
                    Sselected_Folder=strcat(pwd,'\',this.App_Choose_Patient);
                    Sselected_file_path=strcat(pwd,'\','Dicom_Table_properties_',this.App_Choose_Patient,'.csv');
                    fileID = fopen(Sselected_file_path, 'r');
                    if(fileID == -1)
                          Table_dicom_collection =dicomCollection(Sselected_Folder);
                          writetable(Table_dicom_collection, Sselected_file_path);
                          fclose(fileID);
                          outputArg = readtable(Sselected_file_path);
                          return;
                    else
    
                          fclose(fileID);
                          outputArg = readtable(Sselected_file_path);
                          return;
    
                    end

            end


          

        end

        function Out_buffer = Get_Table_Display(this)
                
                Out_buffer={this.Chosen_section_data{2},this.Chosen_section_data{3},this.Chosen_section_data{4},this.Chosen_section_data{9}};

        end

        function out = Get_Reff_Images(this,i_sChosenSeris,i_iCounterFrameInApp,i_sFileLocation)
            this.m_pUtilFolder.m_sFolderPath=i_sFileLocation;
            switch i_sChosenSeris
                case 'HEAD PERFUSION'
                    this.m_matHead_Perfusion_REFF=this.mat_Chosen_Edge_Detection{i_iCounterFrameInApp,1};
                    variable= this.m_matHead_Perfusion_REFF;
                    imshow(this.m_matHead_Perfusion_REFF*25);
                    title("Head Perfusion REFF");
                    ylabel("Mean Pixel intensity");
                    xlabel("Matrix 512X512 uint16");
                    save(fullfile(this.m_pUtilFolder.m_sFolderPath, 'Head_Perfusion_REFF.mat'), 'variable');
                    saveas(gcf,fullfile(this.m_pUtilFolder.m_sFolderPath, 'Head_Perfusion_REFF.fig'));
                    saveas(gcf,fullfile(this.m_pUtilFolder.m_sFolderPath,'Head_Perfusion_REF.png'));
                      close(gcf);
                    out = this;
                    return;

                case 'ANGIO  F_0.7 iMAR'
                         this.m_matANGIO_REFF=this.mat_Chosen_Edge_Detection{i_iCounterFrameInApp,1};
                         variable =  this.m_matANGIO_REFF;
                         save(fullfile(this.m_pUtilFolder.m_sFolderPath, 'Angio_REFF.mat'), 'variable');
                         imshow(this.m_matANGIO_REFF*25);
                         title("Angio REFF");
                         ylabel("Mean Pixel intensity");
                         xlabel("Matrix 512X512 uint16");
                         saveas(gcf,fullfile(this.m_pUtilFolder.m_sFolderPath, 'Angio_REFF.fig'));
                         saveas(gcf,fullfile(this.m_pUtilFolder.m_sFolderPath,'Angio_REFF.png'));
                         close(gcf);
                         out = this;
                        return;
            end
        end

        end
end