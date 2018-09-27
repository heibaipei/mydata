function [results] = cross_varification(LD_org, K)	
%  cross_varification 
%  draw the portion of the data
%  draw the auc
LD_org = importdata('E:\2018-2019-1\2018-8\M\mydata\dr\Fdatasets\DiDrA.mat');
[LD,index_test,y_test] = cross_v1(LD_org,K);
disease_featrue = importdata('E:\2018-2019-1\2018-8\M\mydata\dr\Fdatasets\U_disease_cell_Fd.mat');
drug_feature = importdata('E:\2018-2019-1\2018-8\M\mydata\dr\Fdatasets\U_drug_cell_Fd.mat');
Omega = find(LD==1);

%%%以下是求准确率
M_recover=SIMC(LD,Omega,disease_featrue,drug_feature);

m = length(index_test);
pre_test = zeros(m);
[row, list] = ind2sub(size(LD), index_test);
for i=1:K
    
    %%comput the single time 
    for j = 1:m
    temp = M_recover(row(i),list(i));
    s_M_d = sort(M_recover(row(i),:),2,'descend');% 2 表示按照行进行排列  ‘descend’表示递减
    s_M_c = sort(M_recover(row(i),:),2);% 递增表示 
    
    rank_num1 = find(s_M_d==temp); 
    rank_num2 = find(s_M_c==temp); 
    
    if y_test ==1 && (rank_num1<50)        
        pred_test(i)  = 1;
    elseif y_test == 1 && (rank_num1>50)
        pred_test(i) =0;
    elseif y_test == 0 && (rank_num2<50)
        pred_test(i)  = 1;
    else y_test == 0 && (rank_num2>50)
        pred_test(i) =0;
    end   
    pred(i) = sum(pred_test)/m;   
    end
    mean_pred = sum(pred)/K; 
    
end 
    
