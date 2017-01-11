function [return_value]=SBL_LP_Robust_Method_Average(Node_number,Node_Location,measure_sequence,Size_Grid,location_error_range_abs)

Room_Width=Size_Grid;
Room_Length=Size_Grid;
N=4;% N possible location for each node 

for i=1:N*N*(Node_number-1)
Node_Location_tmp= Node_Location+location_error_range_abs*sign(-0.5+rand(size(Node_Location)));
ww=SBL_LP_Relax_Method(Node_number,Node_Location_tmp,measure_sequence,Size_Grid);

xx(i)=ww(1);
yy(i)=ww(2);
end

return_value=[mean(xx) mean(yy)];

