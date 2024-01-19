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
    end

    methods
        function this = ROI_CT()
          
           bFlag_Save_Roi_to_csv=false;
           BFlag_new_ROI = false;
           sRoi_file_name ="Roi_pos_Table_properties.csv";
           sRoi_file_info = dir(sRoi_file_name);

        end

        function Output_buffer = Draw_ROI(this)

            this.sRoi_file_name ="Roi_pos_Table_properties.csv";
           this.sRoi_file_info = dir(this.sRoi_file_name);

            if(this.sRoi_file_info.bytes)%check if file not empty >0
            this.bFlag_Roi_saved_in_csv = true;
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
                                    this.vec_ROI_pos_data = readmatrix(this.sRoi_file_name);
                                    Output_buffer= this.vec_ROI_pos_data;
                        

                        else
                                    imshow(this.Img_present_roi);
                                     vec_ROI_draw = drawfreehand;
                                     this.vec_ROI_pos_data= vec_ROI_draw.Position;
                                     wait(vec_ROI_draw);
                                     close(gcf);
                                     writematrix(this.vec_ROI_pos_data, this.sRoi_file_name);
                                     this.BFlag_new_ROI =false;
                                     Output_buffer= this.vec_ROI_pos_data;
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

            roiMask = poly2mask(this.vec_ROI_pos_data(:,1), this.vec_ROI_pos_data(:,2), size(this.mat_sdicom_Images{this.count_analysys_img,:}, 1), size(this.mat_sdicom_Images{this.count_analysys_img,:}, 1));
            roi_img = this.mat_sdicom_Images{this.count_analysys_img,:};
            roi_img(repmat(~roiMask, [1, 1, size(this.mat_sdicom_Images{this.count_analysys_img,:}, 3)])) = 0;
            Output_buffer= roi_img;
          
            
            

        end

         function Output_buffer= Get_optimum_Thresh(this)

           Output_buffer = graythresh(this.ROI_Mask);
            

        end





        function [x ,y] = Get_Axis_ROI (this)

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