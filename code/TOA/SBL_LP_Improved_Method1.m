function [return_value]=SBL_LP_Improved_Method1(Node_number,Node_Location,measure_sequence,Size_Grid)

Room_Width=Size_Grid;
Room_Length=Size_Grid;
 
 %%约束不等式数目 Node_number-1
 %%%%目标点坐标point=[x ; y ; W]    %% (2+Node_number-1)*1  

%%%%%%%%%%%%%%%%%%%%代价函数 y=C'x  C=[0 ; 0  ]
Num_inequation_constraint=Node_number-1;
Total_number=(Node_number-1)*Node_number./2;

c_tmp=zeros(2,1);
c=[c_tmp;ones(Total_number,1)];
%%%%%%%%%%%% Bound of 点的界限 【0，Size_Grid】 %%%%%%%%%%%% 
lb = zeros(2+Total_number,1);
ub = Size_Grid*ones(2+Total_number,1); 

%%%%%%%%%%   equation constraint Ax=b  %%%%%%%%%% 没有
Aequ=[];
bequ=[];
%%%%%%%%%%   inequation constraint Ax<b  %%%%%%%%%% 

%%%           A=Function_get_A(Node_Location,measure_sequence);

A_tmp=zeros(Total_number,2);
b=zeros(Total_number,1);
k=1;
for i=1:(length(measure_sequence)-1)
    for j=(i+1):(length(measure_sequence))


m=measure_sequence(i);
n=measure_sequence(j);

x_1=Node_Location(m,1);
y_1=Node_Location(m,2);

x_2=Node_Location(n,1);
y_2=Node_Location(n,2);
A_tmp(k,:)=[2*x_2-2*x_1,2*y_2-2*y_1];
b(k,:)=[x_2^2-x_1^2+y_2^2-y_1^2];
k=k+1;
    end
end
A=zeros(Total_number,2+Total_number);
A=[A_tmp  -eye(Total_number,Total_number)];
%%%%%%%%%%   inequation constraint Ax<b  %%%%%%%%%% 

[point,fval,exitflag,output,lambda] = linprog(c,A,b,Aequ,bequ,lb,ub);% without equation constraint,do not work correctly
% k=length(b);
% maxit=10*k;
% tol=0;
% [point,f,it,B] = lin(A,b,c,k,maxit,tol);

estimated_location=[point(1) point(2)];
return_value=estimated_location;

