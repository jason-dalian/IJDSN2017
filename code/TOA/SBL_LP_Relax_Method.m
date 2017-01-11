function [return_value]=SBL_LP_Improved_Method(Node_number,Node_Location,measure_sequence,Size_Grid)

Room_Width=Size_Grid;
Room_Length=Size_Grid;
 
 %%约束不等式数目 Node_number-1
 %%%%目标点坐标point=[x ; y ; W]    %% (2+Node_number-1)*1  

%%%%%%%%%%%%%%%%%%%%代价函数 y=C'x  C=[0 ; 0  ]
Num_inequation_constraint=Node_number-1;
c_tmp=zeros(2,1);

c=[c_tmp;ones(Num_inequation_constraint,1)];
%%%%%%%%%%%% Bound of 点的界限 【0，Size_Grid】 %%%%%%%%%%%% 
lb = zeros(2+Num_inequation_constraint,1);
ub = zeros(2+Num_inequation_constraint,1);
ub(1:2) = Size_Grid*ones(2,1); 
ub(3:end) = 2*Size_Grid*ones(Num_inequation_constraint,1); 

%%%%%%%%%%   equation constraint Ax=b  %%%%%%%%%% 没有
Aequ=[];
bequ=[];
%%%%%%%%%%   inequation constraint Ax<b  %%%%%%%%%% 

%%%           A=Function_get_A(Node_Location,measure_sequence);

A_tmp=zeros(Node_number-1,2);
b=zeros(Node_number-1,1);
for i=1:(length(measure_sequence)-1)


m=measure_sequence(i);
n=measure_sequence(i+1);

x_1=Node_Location(m,1);
y_1=Node_Location(m,2);

x_2=Node_Location(n,1);
y_2=Node_Location(n,2);
A_tmp(i,:)=[2*x_2-2*x_1,2*y_2-2*y_1];
b(i,:)=[x_2^2-x_1^2+y_2^2-y_1^2];

end
A=zeros(Node_number-1,2+Num_inequation_constraint);
A=[A_tmp  -eye(Num_inequation_constraint,Num_inequation_constraint)];
%%%%%%%%%%   inequation constraint Ax<b  %%%%%%%%%% 

[point,fval,exitflag,output,lambda] = linprog(c,A,b,Aequ,bequ,lb,ub);% without equation constraint,do not work correctly

fval;
point(1:end);

% k=length(b);
% maxit=10*k;
% tol=0;
% [point,f,it,B] = lin(A,b,c,k,maxit,tol);

estimated_location=[point(1) point(2)];
return_value=estimated_location;

