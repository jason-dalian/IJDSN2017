 function return_value=SBL_Method(measure_data,Hashing_table,KNN)
 
 [m,n]=size(Hashing_table);
 
 data_length=length(measure_data);
 
 
 if data_length~=(n-2)
    return_value=[0,0];
	 data_length
	 n-2
    disp('Basic_Method error!!');
    %pause;
    return;
 end
 
 weight=zeros(m,1);
 for i=1:m     
    tmp= Hashing_table(i,1:n-2);

    weight(i)=Kendall_Dist(measure_data, tmp);
 end



[value,index]=sort(weight,'descend');
%%取最小的KNN个
%iindex=index(1:KNN);

%%% by jin 2017.1.11
mmax=value(1);
iindex=index(1);
for i=2:length(weight)
    if value(i)==mmax;
        iindex=[iindex index(i)];
    end        
end

value(1:10)';
index(1:10)';
iindex;


for i=1:length(iindex)
	xx(i)=Hashing_table(iindex(i),n-1);
    yy(i)=Hashing_table(iindex(i),n);
end

x=mean(xx);
y=mean(yy);


% 找出所有的最小值，对应坐标取均值）
return_value=[x, y];

