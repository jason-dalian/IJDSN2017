 function return_value=SBL__Robust_Method(Node_number,measure_data,measure_data_probability,Node_Location,Size_Grid,scale)
 
 
 Node_number_GM=Node_number*(Node_number-1)/2;
 count=0;
 
 % measure_data
 
  for i=1:Node_number-1
 for j=i+1:Node_number
 count=count+1;
 
 ii_index=measure_data(i);
 jj_index=measure_data(j);
 
% Microphone_Center_Location(count,1)=Node_Location(i,1) +Node_Location(j,1);  %i_x
% Microphone_Center_Location(count,2)=Node_Location(i,2) +Node_Location(j,2);  %i_x

% Microphone_Distance(count)=norm(Node_Location(i,:)-Node_Location(j,:));
% kk=(Node_Location(i,2)-Node_Location(j,2))/Node_Location(i,1) +Node_Location(j,1);
% Microphone_Cita(count)=atan(kk)*180/pi;

measure_data_probability_GM(count)=measure_data_probability;

Microphone_1_Location(count,:)=Node_Location(ii_index,:);
Microphone_2_Location(count,:)=Node_Location(jj_index,:);
measure_data_GM(count)=1;
 
 end
 end
 
 % Node_Location

[return_value]=GM_Probility_Cutting(Node_number_GM,measure_data_GM,measure_data_probability_GM,Microphone_1_Location,Microphone_2_Location,Size_Grid,scale);


 
 


