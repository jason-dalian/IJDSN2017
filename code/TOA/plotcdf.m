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

