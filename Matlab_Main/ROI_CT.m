classdef ROI_CT < CT_Perfusion  

    properties (Access = public)
        ROI_Mask = [];
        vec_ROI_pos_data=[];
        iX_Limit=[];
        iY_Limit =[];
        Global_image_threshold=[];
    end

    methods
        function this = ROI_CT()
            
           
        end

        function Output_buffer = Draw_ROI(this)



            fig = uifigure;
            
            selection = uiconfirm(fig,"Create The ROI By Circle your desired location",'ROI_Creation', "Options",["OK","cancel"],"DefaultOption",1);
            close(fig);
            %choise = questdlg("Create The ROI By Circle your desired location",'ROI_Creation','OK','Help','Cancel');
             
            % if (~this.UTIL_Error_handle.Assert_handle(choise,"Dialog failed",this.UTIL_Error_handle.handle_levles.WARNING))
            %         return;
            % end

            

               switch selection
                    

                   case 'OK'
               
                              imshow(this.mat_sdicom_Images{1,1}*25);
                              vec_ROI_draw = drawfreehand;
                              this.vec_ROI_pos_data= vec_ROI_draw.Position;
                              wait(vec_ROI_draw);
                              close(gcf);
                               Output_buffer= this.vec_ROI_pos_data;


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