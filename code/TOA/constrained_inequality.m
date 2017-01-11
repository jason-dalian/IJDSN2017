function  [A_tmp,b]=constrained_inequality(Node_Location_i,Node_Location_j)
x_1=Node_Location_i(1);
y_1=Node_Location_i(2);

x_2=Node_Location_j(1);
y_2=Node_Location_j(2);

A_tmp=[2*x_2-2*x_1,2*y_2-2*y_1];
b=[x_2^2-x_1^2+y_2^2-y_1^2];