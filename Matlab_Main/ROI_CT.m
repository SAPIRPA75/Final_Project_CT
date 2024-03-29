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
    end

    methods
        function this = ROI_CT()
          
           %bFlag_Save_Roi_to_csv=false;
           this.BFlag_new_ROI = false;
           this.sRoi_file_name ="Roi_pos_Table_properties.csv";
           this.sRoi_file_info = dir("Roi_pos_Table_properties.csv");%sRoi_file_name);
           this.sList_of_angio_ROI = 'Table_list_Angio_Roi.csv';

        end

        function Output_buffer = Draw_ROI(this)
           
            this.sList_of_angio_ROI ='Table_list_Angio_Roi.csv';
            %this.sRoi_file_name ="Roi_pos_Table_properties.csv";
            %sFull_Path_chosen_roi = strcat(this.App_Chosen_ROI,'.csv');
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
            %choise = questdlg("Create The ROI By Circle your desired location",'ROI_Creation','OK','Help','Cancel');
             
            % if (~this.UTIL_Error_handle.Assert_handle(choise,"Dialog failed",this.UTIL_Error_handle.handle_levles.WARNING))
            %         return;
            % end

            

               switch selection
                    

                   case 'OK'  

                        if (this.bFlag_Roi_saved_in_csv && ~this.BFlag_new_ROI )%ifndef default
                                %this.vec_ROI_pos_data = readmatrix(sFull_Path_chosen_roi);
                                   % Output_buffer= this.vec_ROI_pos_data;
                                 Output_buffer=this.sFull_Path_chosen_seg__roi;


                        

                        else
                                    
                                    imageSegmenter(this.Img_present_roi);


                                    %restore
                                    %imshow(this.Img_present_roi);
                                     %vec_ROI_draw = drawfreehand;
                                     %this.vec_ROI_pos_data= vec_ROI_draw.Position;
                                     %wait(vec_ROI_draw);
                                     %close(gcf);



                                     this.sRoi_input_name = this.UTIL_Dialog.Prompt_user_input_request({'Enter Roi name :'},'ROI Selection from User',[1 45],{'angio'});
                                     this.sRoi_input_name = char(this.sRoi_input_name{:});
                                     fileID = fopen(this.sList_of_angio_ROI, 'a');
                                     if fileID == -1
                                         %writematrix(this.sRoi_input_name,this.sList_of_angio_ROI);
                                          %fprintf(fileID, '%s\n', this.sRoi_input_name);
                                          %error_message
                                     end
                                     fprintf(fileID, '%s\n', this.sRoi_input_name);
                                     fclose(fileID);
                                     %writematrix(this.sRoi_input_name,this.sList_of_angio_ROI);

                                     Full_name_with_roi =[this.sRoi_input_name,'.csv'];
                                     %writematrix(this.vec_ROI_pos_data, Full_name_with_roi);

                                     
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

        function Output_buffer= Get_Mask_img(this)
            mat_Local_matrix_3D = this.mat_sdicom_Images{1,:};
            MIP_image = max(mat_Local_matrix_3D, [], 3);
            
          switch strtrim(this.App_Chosen_ROI)
              case "angio_ACA_TOP" 
                 [xPos,yPos] = angio_ACA_TOP(this.mat_sdicom_Images{1,:});
              case "angio_mca_right"
                 [xPos,yPos] = angio_mca_right(this.mat_sdicom_Images{1,:});
              case "Reg_MCA_LEFT"
                [xPos,yPos] = Reg_MCA_LEFT(this.mat_sdicom_Images{1,:});

              otherwise
                  [xPos,yPos] = angio_mca_right(this.mat_sdicom_Images{1,:});
          end

            roiMask = poly2mask(xPos, yPos, size(this.mat_sdicom_Images{this.count_analysys_img,:}, 1), size(this.mat_sdicom_Images{this.count_analysys_img,:}, 1));
            roi_img = this.mat_sdicom_Images{this.count_analysys_img,:};
            roi_img(repmat(~roiMask, [1, 1, size(this.mat_sdicom_Images{this.count_analysys_img,:}, 3)])) = 0;
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
     
           %Output_buffer =readtable("Table_list_Angio_Roi.csv");
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


function [BW,maskedImage] = segmentImage(this)
%segmentImage Segment image using auto-generated code from Image Segmenter app
%  [BW,MASKEDIMAGE] = segmentImage(X) segments image X using auto-generated
%  code from the Image Segmenter app. The final segmentation is returned in
%  BW, and a masked image is returned in MASKEDIMAGE.

% Auto-generated by imageSegmenter app on 22-Jan-2024
%----------------------------------------------------


% Adjust data to span data range.
X = imadjust(this.Img_present_roi);

% Create empty mask
BW = false(size(X,1),size(X,2));

% Draw ROIs

xPos = [279.0261 279.3109 279.7501 280.4965 281.3360 281.9028 282.3076 282.6574 282.9515 283.2058 283.5252 283.9842 284.4219 284.8199 285.2484 285.7021 286.2025 286.6868 287.0687 287.4750 288.1999 289.3006 290.4885 291.7488 292.7664 293.3308 293.5546 293.7302 293.9671 294.3030 295.2930 297.2088 299.0843 300.3170 301.1221 301.8035 302.2572 302.5688 302.9652 303.3457 303.5374 303.6413 303.7597 303.8315 303.8315 303.7436 303.5374 303.2113 302.6697 301.8607 301.0426 300.4063 299.8487 299.2140 298.6021 298.1575 297.8940 297.6237 297.2020 296.6871 296.3212 296.0814 295.7155 295.2007 294.7630 294.4208 293.6703 291.5022 288.1349 285.7766 284.7160 283.9842 283.1990 282.4580 281.7286 281.0915 280.5683 280.1291 279.5249 278.7320 278.0322 277.5877 277.3960 277.2761 277.0859 276.8796 276.7200 276.5855 276.4817 276.3220 276.0852 275.8935 275.6460 275.2427 274.8118 274.4086 274.1931 274.1450 274.1611 274.2329 274.3513 274.4551 274.6308 274.9394 275.2335 275.4810 275.7659 276.0692 276.4419 276.8957 277.4518 277.9666];
yPos = [213.9965 214.1004 214.3626 214.6714 214.8312 214.8632 214.8632 214.8632 214.8632 214.8632 214.8632 214.8793 214.9511 215.0696 215.1414 215.1575 215.1575 215.1575 215.1575 215.1414 215.0375 214.6631 213.8513 212.8462 212.2072 211.8328 211.5240 211.3482 211.2283 210.8295 209.5928 207.4457 205.5944 204.7324 204.4046 204.1516 204.0079 203.9759 204.0079 204.3280 205.4355 207.3059 209.0402 210.2095 210.9500 211.6119 212.4053 213.0802 213.4478 213.6862 213.8926 214.0844 214.3626 214.6874 214.9190 215.0696 215.1575 215.2454 215.4119 215.7154 216.1587 216.5248 216.8205 217.2333 217.6858 217.9800 218.3405 219.5062 221.4018 222.5675 222.8959 223.0144 223.0863 223.1023 223.1023 223.1023 223.1023 223.1023 223.0863 222.9984 222.8080 222.6177 222.4497 222.0743 221.4339 220.8590 220.4074 220.1039 219.8655 219.6752 219.5873 219.5552 219.4513 219.1410 218.5846 217.9097 217.3372 216.8909 216.3651 215.7314 215.2614 214.9098 214.5384 214.3068 214.1708 213.9805 213.7420 213.4386 213.0351 212.6758 212.3907 212.2470];
m = size(BW, 1);
n = size(BW, 2);
addedRegion = poly2mask(xPos, yPos, m, n);
BW = BW | addedRegion;

% Active contour
iterations = 10;
BW = activecontour(X, BW, iterations, 'Chan-Vese');

% Active contour
iterations = 35;
BW = activecontour(X, BW, iterations, 'edge');

% Create masked image.
maskedImage = X;
maskedImage(~BW) = 0;
end





    end
end