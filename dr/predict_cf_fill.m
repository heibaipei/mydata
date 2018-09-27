

LD_org = importdata('E:\2018-2019-1\2018-8\M\mydata\dr\Fdatasets\DiDrA.mat');
disease_featrue = importdata('E:\2018-2019-1\2018-8\M\mydata\dr\Fdatasets\U_disease_cell_Fd.mat');
drug_feature = importdata('E:\2018-2019-1\2018-8\M\mydata\dr\Fdatasets\U_drug_cell_Fd.mat');
% addpath('Code\SIMC');
[LD,num_row,num_list] = cross_v1(LD_org);
Omega=find(LD==1);
[~,m] = size(num_list);
M_recover=SIMC(LD,Omega,disease_featrue,drug_feature);
% M_list_recover = sort(M_recover, 2, 'descend');
rank_num = [];
for i=1:m
%     disp(num_row);
%     disp(num_list);
    temp = M_recover(num_row(i),num_list(i));
    s_M = sort(M_recover(num_row(i),:),2,'descend');
%     disp(s_M);
    rank_num(i) = find(s_M==temp);    
end



