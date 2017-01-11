function [return_value]=SBL_CSLP_Method(Node_number,Node_Location,TOA,Size_Grid)

Room_Width=Size_Grid;
Room_Length=Size_Grid;
n=length(TOA);
for i=1:n
    A(i)=i;
end
M=[TOA;A];

for i=2:n
    temp=M(1,i);
    temp1=M(:,i);
    j=i-1;
    while(j>=1&&temp<M(1,j))
        M(:,(j+1))=M(:,j);
        j=j-1;
    end
    M(:,(j+1))=temp1;
end


for i=1:n-1
    Dtoa(1,i)=M(1,i+1)-M(1,i);
    Dtoa(2,i)=M(2,i);
    Dtoa(3,i)=M(2,i+1);
end

for i=2:n-1
    tep=Dtoa(1,i);
    tep1=Dtoa(:,i);
    j=i-1;
    while(j>=1&&tep<Dtoa(1,j))
        Dtoa(:,(j+1))=Dtoa(:,j);
        j=j-1;
    end
    Dtoa(:,(j+1))=tep1;
end

Num_inequation_constraint=ceil(0.75*(n-1));
 %%Լ������ʽ��Ŀ Node_number-1
 %%%%Ŀ�������point=[x ; y ; W]    %% (2+Node_number-1)*1  

%%%%%%%%%%%%%%%%%%%%���ۺ��� y=C'x  C=[0 ; 0  ]
%Num_inequation_constraint=Node_number-1;
c_tmp=zeros(2,1);

c=[c_tmp;ones(Num_inequation_constraint,1)];
%%%%%%%%%%%% Bound of ��Ľ��� ��0��Size_Grid�� %%%%%%%%%%%% 
lb = zeros(2+Num_inequation_constraint,1);
ub = Size_Grid*ones(2+Num_inequation_constraint,1); 

%%%%%%%%%%   equation constraint Ax=b  %%%%%%%%%% û��
Aequ=[];
bequ=[];
%%%%%%%%%%   inequation constraint Ax<b  %%%%%%%%%% 

%%%           A=Function_get_A(Node_Location,measure_sequence);

A_tmp=zeros(Num_inequation_constraint,2);
b=zeros(Num_inequation_constraint,1);
for i=1:Num_inequation_constraint

m= Dtoa(2,i);
n= Dtoa(3,i);;

x_1=Node_Location(m,1);
y_1=Node_Location(m,2);

x_2=Node_Location(n,1);
y_2=Node_Location(n,2);
A_tmp(i,:)=[2*x_2-2*x_1,2*y_2-2*y_1];
b(i,:)=[x_2^2-x_1^2+y_2^2-y_1^2];
end

A=zeros(Num_inequation_constraint,2+Num_inequation_constraint);
A=[A_tmp  -eye(Num_inequation_constraint,Num_inequation_constraint)];
%%%%%%%%%%   inequation constraint Ax<b  %%%%%%%%%% 

[point,fval,exitflag,output,lambda] = linprog(c,A,b,Aequ,bequ,lb,ub);% without equation constraint,do not work correctly


estimated_location=[point(1) point(2)];
return_value=estimated_location;

