function [table_binary]=creat_table(Node_Location,Room_Width,Room_Length,scale,Node_number)

 table_binary=zeros(Room_Width*scale*Room_Width*scale,Node_number+2); %   

        count_tmp=0;
        for x_i=1:Room_Width*scale
            for y_j=1:Room_Length*scale
                count_tmp = count_tmp+1;
                speaker_x=x_i/scale;
                speaker_y=y_j/scale;
				
				for k=1:Node_number
                measure_data_tmp(k)=(speaker_x-Node_Location(k,1)).^2+(speaker_y-Node_Location(k,2)).^2;
                end
				
				[m,index]=sort(measure_data_tmp);
                
              
				
                table_binary(count_tmp,:)=[index';speaker_x;speaker_y];         
            end
        end 