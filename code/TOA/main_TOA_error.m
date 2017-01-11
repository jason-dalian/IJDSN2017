% main function
clc;
clear all  %清除 
close all; %关闭之前数据

Size_Grid=10;  %房间大小，单位：m 
Room_Length=Size_Grid; %房间长度
Room_Width=Size_Grid;  %房间宽度
RUNS = 100; %%仿真次数
scale=5;        %%%%%%%%%%%%%%%%%%%%%%%%%%%%可变参数，GM算法的空间离散化步长

percent  = 0.9;      %计算定位误差时，只取前90%，舍掉最大的10%
KNN=1;  %% Basic Hamming parameter ，Kendall距离最大的K个点取平均

location_error_range_abs = 0.10;         %%%%%%%%%%%%%%%%%%%%节点位置误差范围,单位m
%measure_error_range_abs = 0.1;       %%%%%%%%%%%%%%%%%%%节点角度误差范围,单位ms  1ms--0.34m   1ms--44.100  
Node_number=20;
measure_data_probability=0.75;

real_statics_run=floor(RUNS*percent);   

anchor_min=1;   %最小 量测误差 单位：ms   %%%%%%%%%%%%%%%%%%%节点角度误差范围,单位ms  1ms--0.34m   1ms--44.100
anchor_max=10;  %最大
anchor_gap=1;   %间隔
anchors=anchor_min:anchor_gap:anchor_max;  %%%%%%%%%%%%%%%%%%%%%%%%%%可变参数，实验所使用的结点个数


for runs = 1:RUNS              
disp(['--------------------------------------------------------- ']);
    disp(['runs = ',num2str(runs)]);
	disp(['--------------------------------------------------------- ']);     
    count=1;     
    for Num_Achohor=anchor_min:anchor_gap:anchor_max
        measure_error_range_abs =  Num_Achohor;
        disp(['measure_error_range_abs = ',num2str(measure_error_range_abs)]);
	    disp(['************* ']); 
        Node_Location=fix(Size_Grid*abs((rand(Node_number,2)))); %     
  
		 %随机生成说话人实际位置，测量信息由是说话人位置与实际节点位置计算
		measure_data=zeros(Node_number,1);  
        real_speaker_location=(Size_Grid*abs((rand(1,2)))); 
        speaker_x=real_speaker_location(1,1);
        speaker_y=real_speaker_location(1,2);
		%%%%%
        
         measure_data_tmp=zeros(Node_number,1);  
    	for k=1:Node_number
         measure_data_tmp(k)=sqrt((speaker_x-Node_Location(k,1)).^2+(speaker_y-Node_Location(k,2)).^2);
        end
			
			%%%%测量到的的到达时间ms  Time of  arrival 
			measure_TOA=1000*measure_data_tmp./340;  %单位毫秒ms
            
            %%% by jin 2017.1.11
			%measure_TOA_with_error=measure_TOA + measure_error_range_abs*sign(-0.5+rand(size(measure_TOA)));
        measure_TOA_with_error=measure_TOA + measure_error_range_abs*(-0.5+rand(size(measure_TOA)));
        
            
           [m,index_measurement]=sort(measure_TOA); 
           index_measurement_true=index_measurement';
                 
           
			[m,index_measurement_error]=sort(measure_TOA_with_error); %将来在measure_TOA上加量测噪声[-1 1] 递增
            unindex_measurement_error=measure_TOA_with_error;
             %%% by jin 2017.1.11
           % Node_Location_with_error=Node_Location + location_error_range_abs*sign(-0.5+rand(size(Node_Location))); 
            Node_Location_with_error=Node_Location + location_error_range_abs*(-0.5+rand(size(Node_Location)));  
 % 		   		 %%%%%%%%%%%建表 table_binary, 实际测试，建表有误差！！！ %%%%%%%%%%% 
  table_binary=zeros(Room_Width*scale*Room_Width*scale,Node_number+2);		  		 
  table_binary=creat_table(Node_Location_with_error,Room_Width,Room_Length,scale,Node_number);    
 %  table_binary=creat_table(Node_Location,Room_Width,Room_Length,scale,Node_number);    

 
 %save test.mat
 %return
 % load  test.mat
 
%             index_measurement';
%             index_measurement_error';
%            my_Kendall_Dist= Kendall_Dist(index_measurement_true, index_measurement_error); 
         
 %%调用四个定位方法， 统计定位误差  	
        
        %基础LPSBL
        %estimated_location=SBL_CSLP_Method(Node_number,Node_Location_with_error,measure_TOA_with_error',Size_Grid);
        estimated_location=SBL_Method(index_measurement_error',table_binary, KNN);   
		rmse_SBL_tmp(count) = sqrt( sum((real_speaker_location(:)-estimated_location(:)).^2) );  %	  
   
        
        %estimated_location=SBL_LP_Basic_Method(Node_number,Node_Location_with_error,index_measurement_error',Size_Grid);
        
        %Relaxed_LPSBL
        estimated_location=SBL_LP_Relax_Method(Node_number,Node_Location_with_error,index_measurement_error',Size_Grid);
        rmse_SBL_LP_Basic_tmp(count) = sqrt( sum((real_speaker_location(:)-estimated_location(:)).^2) );  %   
        
        
        %选择n*(n-1)/2个点
        estimated_location=SBL_LP_Improved_Method1(Node_number,Node_Location_with_error,index_measurement_error',Size_Grid);
		rmse_SBL_LP_Relax_tmp(count) =sqrt( sum((real_speaker_location(:)-estimated_location(:)).^2) );  %   
      
%          if rmse_SBL_LP_Relax_tmp(count)>3  
%             save test.mat
%              return
%          end
        
        %增量SBL
        estimated_location=Increment_SBL_LP_Method(Node_number,Node_Location_with_error, unindex_measurement_error',Size_Grid);
		rmse_SBL_LP_Increment_tmp(count) =sqrt( sum((real_speaker_location(:)-estimated_location(:)).^2) );  %       
             
         count=count+1;          
 
    end  
%     rmse_SBL_final_Anchors(runs,:)=rmse_SBL_tmp;
% 	rmse_SBL_LP_final_Anchors(runs,:)=rmse_SBL_LP_tmp;    
%   	rmse_SBL_LP_Robust_final_Anchors(runs,:) =  rmse_SBL_Robust_tmp;
    rmse_SBL_final_Anchors(runs,:)=rmse_SBL_tmp;
	rmse_SBL_LP_final_Anchors(runs,:)=rmse_SBL_LP_Basic_tmp;    
  	rmse_SBL_LP_Relax_final_Anchors(runs,:) =  rmse_SBL_LP_Relax_tmp;
    rmse_SBL_LP_Increment_final_Anchors(runs,:) =  rmse_SBL_LP_Increment_tmp;
end  

disp(['Saving and Drawing................. ']);
%save data.mat  RUNS Size_Grid  anchors   real_statics_run rmse_SBL_final_Anchors rmse_SBL_LP_final_Anchors rmse_SBL_LP_Robust_final_Anchors
save data.mat  RUNS Size_Grid  anchors   real_statics_run  rmse_SBL_final_Anchors rmse_SBL_LP_final_Anchors rmse_SBL_LP_Relax_final_Anchors rmse_SBL_LP_Increment_final_Anchors

clear all;
load data.mat


%%将误差从小到大排序，取前90%
% [A,B]=sort(rmse_SBL_final_Anchors);
% rmse_SBL_MC = mean(A(1:real_statics_run,:));
% 
% [A,B]=sort(rmse_SBL_LP_final_Anchors);
% rmse_SBL_LP_MC = mean(A(1:real_statics_run,:));
% 
% [A,B]=sort(rmse_SBL_LP_Robust_final_Anchors);
% rmse_SBL_LP_Robust_MC = mean(A(1:real_statics_run,:));
%  
% figure('Position',[1 1 1200 900])
%  plot(anchors, rmse_SBL_MC, 'rs-', 'LineWidth', 2, 'MarkerFaceColor', 'r');
%  hold on;
%   plot(anchors, rmse_SBL_LP_MC, 'g^-', 'LineWidth', 2, 'MarkerFaceColor', 'g');
%  plot(anchors, rmse_SBL_LP_Robust_MC, 'b^-', 'LineWidth', 2, 'MarkerFaceColor', 'b');
% hold off
% legend('\fontsize{12}\bf Basic SBL','\fontsize{12}\bf Relax LP SBL ', '\fontsize{12}\bf Whole Point LP SBL ');

%%将误差从小到大排序，取前90%
[A,B]=sort(rmse_SBL_final_Anchors);
rmse_SBL_MC = mean(A(1:real_statics_run,:));


[A,B]=sort(rmse_SBL_LP_final_Anchors);
rmse_SBL_LP_MC = mean(A(1:real_statics_run,:));

[A,B]=sort(rmse_SBL_LP_Relax_final_Anchors);
rmse_SBL_LP_Relax_MC = mean(A(1:real_statics_run,:));

[A,B]=sort(rmse_SBL_LP_Increment_final_Anchors);
rmse_SBL_LP_Increment_MC = mean(A(1:real_statics_run,:));
 
figure('Position',[1 1 1200 900])
 plot(anchors, rmse_SBL_MC, 'gs-', 'LineWidth', 2, 'MarkerFaceColor', 'g');
 hold on;
  plot(anchors, rmse_SBL_LP_MC, 'r^-', 'LineWidth', 2, 'MarkerFaceColor', 'r');
 plot(anchors, rmse_SBL_LP_Relax_MC, 'b^-', 'LineWidth', 2, 'MarkerFaceColor', 'b');
 plot(anchors, rmse_SBL_LP_Increment_MC, 'k^-', 'LineWidth', 2, 'MarkerFaceColor', 'k');

hold off
legend('\fontsize{12}\bf Basic SBL','\fontsize{12}\bf Relax LP SBL ', '\fontsize{12}\bf Whole Point LPSBL','\fontsize{12}\bf Increment LP SBL');

xlabel('\fontsize{12}\bf TOA Error(ms)');
ylabel('\fontsize{12}\bf Localization Error(in units)');
title('\fontsize{12}\bf  Localization Error vs. TOA Error');





figure('Position',[1 1 1200 900])

[f1,x1] = ecdf(rmse_SBL_MC);
plot(x1,f1,'gs-', 'LineWidth', 2, 'MarkerFaceColor', 'g');
hold on
[f2,x2] = ecdf(rmse_SBL_LP_MC);
plot(x2,f2, 'r^-', 'LineWidth', 2, 'MarkerFaceColor', 'r');

[f3,x3] = ecdf(rmse_SBL_LP_Relax_MC);
plot(x3,f3, 'b^-', 'LineWidth', 2, 'MarkerFaceColor', 'b');
[f4,x4] = ecdf(rmse_SBL_LP_Increment_MC);
plot(x4,f4,  'k^-', 'LineWidth', 2, 'MarkerFaceColor', 'k');
hold off
legend('\fontsize{12}\bf Basic SBL','\fontsize{12}\bf Relax LP SBL ', '\fontsize{12}\bf Whole Point LPSBL','\fontsize{12}\bf Increment LP SBL');

xlabel('\fontsize{12}\bf CDF');
ylabel('\fontsize{12}\bf Localization Error(in units)');
title('\fontsize{12}\bf  Localization Error vs. CDF');





