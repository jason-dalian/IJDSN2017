function [return_value]=Increment_SBL_LP_Method(Node_number,Node_Location,measure_sequence,Size_Grid)

Room_Width=Size_Grid;
Room_Length=Size_Grid;
 
%  %%约束不等式数目 Node_number-1
%  %%%%目标点坐标point=[x ; y ; W]    %% (2+Node_number-1)*1  
% 
% %%%%%%%%%%%%%%%%%%%%代价函数 y=C'x  C=[0 ; 0  ]
% Num_inequation_constraint=Node_number-1;
% c_tmp=zeros(2,1);
% 
% c=[c_tmp;ones(Num_inequation_constraint,1)];
% %%%%%%%%%%%% Bound of 点的界限 【0，Size_Grid】 %%%%%%%%%%%% 
% lb = zeros(2+Num_inequation_constraint,1);
% ub = Size_Grid*ones(2+Num_inequation_constraint,1); 
% 
% %%%%%%%%%%   equation constraint Ax=b  %%%%%%%%%% 没有
% Aequ=[];
% bequ=[];
% %%%%%%%%%%   inequation constraint Ax<b  %%%%%%%%%% 
% 
% %%%           A=Function_get_A(Node_Location,measure_sequence);
% 
% A_tmp=zeros(Node_number-1,2);
% b=zeros(Node_number-1,1);
n=length(measure_sequence);
N=zeros(1,n);
  for i=1:n
      N(1,i)=i;
  end
M=[measure_sequence;N];

k=1;

for i=2:n
    temp=M(1,i);
    temp1=M(:,i);
    j=i-1;
    while(j>=1&&temp<M(1,j))
        M(:,(j+1))=M(:,j);
        j=j-1;
    end
    M(:,(j+1))=temp1;
    l=j+1;
    %三种情况的判断
    if l==1
        m=M(2,l);
        n=M(2,(l+1));
       x_1=Node_Location(m,1);
       y_1=Node_Location(m,2);

       x_2=Node_Location(n,1);
       y_2=Node_Location(n,2);
       A_tmp(k,:)=[2*x_2-2*x_1,2*y_2-2*y_1];
       b(k,:)=[x_2^2-x_1^2+y_2^2-y_1^2];
       k=k+1;
    end
    
    if l==i
        m=M(2,(l-1));
        n=M(2,l);
       x_1=Node_Location(m,1);
       y_1=Node_Location(m,2);

       x_2=Node_Location(n,1);
       y_2=Node_Location(n,2);
       A_tmp(k,:)=[2*x_2-2*x_1,2*y_2-2*y_1];
       b(k,:)=[x_2^2-x_1^2+y_2^2-y_1^2];
       k=k+1;
    end
   
    if (l>1)&&(l<i)
        m=M(2,(l-1));
        n=M(2,l);
       x_1=Node_Location(m,1);
       y_1=Node_Location(m,2);

       x_2=Node_Location(n,1);
       y_2=Node_Location(n,2);
       A_tmp(k,:)=[2*x_2-2*x_1,2*y_2-2*y_1];
       b(k,:)=[x_2^2-x_1^2+y_2^2-y_1^2];
       k=k+1;
       
       m=M(2,l);
        n=M(2,(l+1));
       x_1=Node_Location(m,1);
       y_1=Node_Location(m,2);

       x_2=Node_Location(n,1);
       y_2=Node_Location(n,2);
       A_tmp(k,:)=[2*x_2-2*x_1,2*y_2-2*y_1];
       b(k,:)=[x_2^2-x_1^2+y_2^2-y_1^2];
       k=k+1;
    end
    
end


%%约束不等式数目 Node_number-1
 %%%%目标点坐标point=[x ; y ; W]    %% (2+Node_number-1)*1  

%%%%%%%%%%%%%%%%%%%%代价函数 y=C'x  C=[0 ; 0  ]
Num_inequation_constraint=k-1;
c_tmp=zeros(2,1);

c=[c_tmp;ones(Num_inequation_constraint,1)];
%%%%%%%%%%%% Bound of 点的界限 【0，Size_Grid】 %%%%%%%%%%%% 
lb = zeros(2+Num_inequation_constraint,1);
ub = Size_Grid*ones(2+Num_inequation_constraint,1); 

%%%%%%%%%%   equation constraint Ax=b  %%%%%%%%%% 没有
Aequ=[];
bequ=[];
%%%%%%%%%%   inequation constraint Ax<b  %%%%%%%%%% 

%%%           A=Function_get_A(Node_Location,measure_sequence);


A=zeros(Num_inequation_constraint,2+Num_inequation_constraint);
A=[A_tmp  -eye(Num_inequation_constraint,Num_inequation_constraint)];
%%%%%%%%%%   inequation constraint Ax<b  %%%%%%%%%% 

[point,fval,exitflag,output,lambda] = linprog(c,A,b,Aequ,bequ,lb,ub);% without equation constraint,do not work correctly
% k=length(b);
% maxit=10*k;
% tol=0;
% [point,f,it,B] = lin(A,b,c,k,maxit,tol);

estimated_location=[point(1) point(2)];
return_value=estimated_location;

