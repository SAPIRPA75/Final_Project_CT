classdef ROI_CT < CT_Perfusion  

    properties (Access = public)
        ROI_Mask = [];
        vec_ROI_pos_data=[];
        iX_Limit=[];
        iY_Limit =[];
        Global_image_threshold=[];
        Img_present_roi=[]
        bFlag_Roi_saved_in_csv=[];
        BFlag_new_ROI= [];
        sRoi_file_name=[]
        sRoi_file_info=[];
        sRoi_input_name=[];
        sList_of_angio_ROI = [];
        App_Chosen_ROI=[];
        sFull_Path_chosen_seg__roi=[];
        m_pUtilFolder;
    end

    methods
        function this = ROI_CT()
          
           this.BFlag_new_ROI = false;
           this.sRoi_file_name ="Roi_pos_Table_properties.csv";
           this.sRoi_file_info = dir("Roi_pos_Table_properties.csv");%sRoi_file_name);
           this.sList_of_angio_ROI = 'Table_list_Angio_Roi.csv';
           this.m_pUtilFolder=utilities();


        end


        function out = Set_Foler_Plot_Name_Path(this,i_sFloderName)

            this.m_pUtilFolder.m_sFolderPath= this.m_pUtilFolder.Create_Plot_Folder(i_sFloderName);
            out = this;
        end
        function Output_buffer = Draw_ROI(this)
           
            this.sList_of_angio_ROI ='Table_list_Angio_Roi.csv';
            this.sFull_Path_chosen_seg__roi = strcat(this.App_Chosen_ROI,'.m');
           this.sRoi_file_info = dir(this.sFull_Path_chosen_seg__roi);

            if(this.sRoi_file_info.bytes && ~this.BFlag_new_ROI)%check if file not empty >0
            this.bFlag_Roi_saved_in_csv = true;
            Output_buffer=this.sFull_Path_chosen_seg__roi;
            return;
            end
            


            fig = uifigure;
            
            selection = uiconfirm(fig,"Create The ROI By Circle your desired location",'ROI_Creation', "Options",["OK","cancel"],"DefaultOption",1);
            close(fig);

            

               switch selection
                    

                   case 'OK'  

                        if (this.bFlag_Roi_saved_in_csv && ~this.BFlag_new_ROI )%ifndef default
                                 Output_buffer=this.sFull_Path_chosen_seg__roi;


                        

                        else
                                    
                                    imageSegmenter(this.Img_present_roi);





                                     this.sRoi_input_name = this.UTIL_Dialog.Prompt_user_input_request({'Enter Roi name :'},'ROI Selection from User',[1 45],{'angio'});
                                     this.sRoi_input_name = char(this.sRoi_input_name{:});
                                     fileID = fopen(this.sList_of_angio_ROI, 'a');
                                     if fileID == -1
                                     end
                                     fprintf(fileID, '%s\n', this.sRoi_input_name);
                                     fclose(fileID);
                                     Full_name_with_roi =[this.sRoi_input_name,'.csv'];
                                     
                                     this.BFlag_new_ROI =false;
                                     Output_buffer=this.sFull_Path_chosen_seg__roi;

                                      fig = uifigure; 
                                    selection = uiconfirm(fig,"Finished ROI creation?",'ROI_Creation', "Options","End the program","DefaultOption",1);
                                    close(fig);
                                  
                                     end 
                                
                 

                   case 'Help'
                                
                              imshow(this.mat_sdicom_Images{1,1});
                              vec_ROI_draw = drawfreehand;
                              this.vec_ROI_pos_data= vec_ROI_draw.Position;
                              wait(vec_ROI_draw);
                              close(gcf);
                               Output_buffer= this.vec_ROI_pos_data;
                            
                     end
           
        end

        function Output_buffer= Get_Mask_img(this,i_sDirRoiPath)
            l_pSaveLastDir = pwd;
            this.m_pUtilFolder.m_sFolderPath=i_sDirRoiPath;% Change Dir for Spesific ROI {i.e every patient have therre own ROI
            cd(this.m_pUtilFolder.m_sFolderPath);
          switch strtrim(this.App_Chosen_ROI)

              case "Reg_ACA_Top" 
                 [xPos,yPos] = Reg_ACA_Top(this.mat_sdicom_Images{1,:});
              case "Reg_MCA_Right"
                 [xPos,yPos] = Reg_MCA_Right(this.mat_sdicom_Images{1,:});
              case "Reg_MCA_LEFT"
                [xPos,yPos] = Reg_MCA_LEFT(this.mat_sdicom_Images{1,:});

              otherwise
                   [xPos,yPos] = Reg_MCA_Right(this.mat_sdicom_Images{1,:});
          end

            roiMask = poly2mask(xPos, yPos, size(this.mat_sdicom_Images{this.count_analysys_img,:}, 1), size(this.mat_sdicom_Images{this.count_analysys_img,:}, 1));
            roi_img = this.mat_sdicom_Images{this.count_analysys_img,:};
            roi_img(repmat(~roiMask, [1, 1, size(this.mat_sdicom_Images{this.count_analysys_img,:}, 3)])) = 0;
             if(~exist(strcat('ROI_Only_',this.App_Chosen_ROI,'.png'),"file"))
                l_matBinaryRep=imbinarize(roi_img,graythresh(roi_img));
                l_sROIFile=strcat('ROI_Only_',this.App_Chosen_ROI,'.png');
                 imwrite(l_matBinaryRep, l_sROIFile);
              end
            cd(l_pSaveLastDir);% Back the working Directory
            Output_buffer= roi_img;
          
            
            

        end

         function Output_buffer= Get_optimum_Thresh(this)

           Output_buffer = graythresh(this.ROI_Mask);
            

         end

 function Output_buffer= Get_List_ROI(this)
                


fileID = fopen("Table_list_Angio_Roi.csv", 'r');


if fileID == -1
    %error('Could not open the file for reading.');
end

% Read and display each line in the file
i=1;
while ~feof(fileID)
    starray_of_lines{:,i} = fgets(fileID);
    i=i+1;
    
    
end

% Close the file
fclose(fileID);
     
Output_buffer = starray_of_lines;
         end

         





        function [x ,y] = Get_Axis_ROI (this)

            if(isempty(this.sFull_Path_chosen_seg__roi))
              %ini
              mat_dPos_data_X_Axis_min=[];
              mat_dPos_data_X_Axis_max = [];
              mat_dPos_data_Y_Axis_min =[];
              mat_dPos_data_Y_Axis_max = [];

            mat_dPos_data_X_Axis_min =min(this.vec_ROI_pos_data(:, 1));
            mat_dPos_data_X_Axis_max= max(this.vec_ROI_pos_data(:, 1));
            x = [mat_dPos_data_X_Axis_min,mat_dPos_data_X_Axis_max];
            mat_dPos_data_Y_Axis_min =min(this.vec_ROI_pos_data(:, 2));
            mat_dPos_data_Y_Axis_max= max(this.vec_ROI_pos_data(:, 2));
            y = [mat_dPos_data_Y_Axis_min,mat_dPos_data_Y_Axis_max];
            end

        end


    end
end