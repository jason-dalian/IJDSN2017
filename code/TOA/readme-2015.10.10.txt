1. SBL_Method: 查表法

2. SBL_LP_Basic_Method： 基本LP

3. SBL_LP_Relax_Method 辅助变量 LP

4. SBL_LP_Robust_Method   考虑锚节点的位置误差  解决方案1：(N-1)K1*K2  一个不等式----多个不等式  

5. SBL_LP_Robust_Method_Average   考虑锚节点的位置误差 解决方案2：算法调用多次SBL_LP_Relax_Method，结果取平均

6. 解决方案3   SBL_Probility_Method
发现一个问题：为何随着节点数增加， SBL_Method: 查表法误差增大？？