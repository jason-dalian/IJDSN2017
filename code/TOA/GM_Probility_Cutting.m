function [return_value]=GM_Probility_Cutting(Node_number,measure_data,measure_data_probability,Microphone_1_Location,Microphone_2_Location,Size_Grid,scale)



Room_Width=Size_Grid;
Room_Length=Size_Grid;
 
step=scale;  %测试步长	

		
		
		% Microphone_1_Location
		% Microphone_2_Location
		
Mic_vector=Microphone_1_Location-Microphone_2_Location;
Room_tag=zeros(Room_Length*step,Room_Width*step); %记录房间内点是否符合条件 1为符合 0为不符合
Room_tag=Incise_probability(Node_number,measure_data,measure_data_probability,Mic_vector,Microphone_1_Location,Microphone_2_Location,Size_Grid,scale);

[x,y]=Coordinate2(Room_tag,Size_Grid,scale);

xx=1:Room_Width*step;
xx=xx./step;
yy=1:Room_Width*step;
yy=yy./step;
[X,Y]=meshgrid(xx,yy);
Z=Room_tag;

%mesh(X,Y,Z);
%pause;

estimated_location=[x y];
return_value=estimated_location;