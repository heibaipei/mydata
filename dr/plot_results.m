addpath('Code\SIMC');

DiDrA = importdata('E:\2018-2019-1\2018-8\M\mydata\dr\Fdatasets\DiDrA.mat');
[LD,test_index,y_test] = cross_v1(DiDrA);

% disp('now load the data and preccesseed the data*************');

load('E:\2018-2019-1\2018-8\M\mydata\dr\Fdatasets\DiseaseSim.txt');
load('E:\2018-2019-1\2018-8\M\mydata\dr\Fdatasets\DrugSim.txt');
[m1,n1] = size(DiseaseSim);
[m2,n2] = size(DrugSim);
[disease_featrue,drug_feature] = cf_featrues(DiseaseSim, DrugSim,10,20); %%获得AOP的特征

Omega=find(LD==1);   
M_recover=SIMC(LD,Omega,disease_featrue,drug_feature);

[I, J] = ind2sub(size(LD), test_index);
Ypred = M_recover(test_index);

% disp(size(Ypred));
[X,Y,T,AUC] = perfcurve(y_test,Ypred,1);
disp(AUC)
figure(4);
plot(X,Y);
hold on;
xlabel('FPR')
ylabel('TPR')

%%%computer the mumber in top_10, top_20 
rank_num=[];
pre_y = zeros(100);
for i = 1;length(I)
    disp('这是长度')
    disp(length(I))
    temple = M_recover(I(i),J(i));
    [x,y] = sort(M_recover(:,J(i)),2,'descend');    
    rank_num(i) = find(M_recover ==temple);
    disp(rank_num(i))
    
%     if rank(i)<10
%         pre_y(10)= pre_y(10) + 1;
%     elseif rank(i)<20
%         pre_y(20) =pre_y(10) + 1;
%     elseif rank(i)<30
%         pre_y(30) =pre_y(30) + 1;
%     elseif rank(i)<50
%         pre_y(50) =pre_y(50) + 1;
%    elseif rank(i)<100
%         pre_y(100) = pre_y(100) + 1;
%     end       
end


% figure(2);
% bar(pre_y,5);
% xlabel('top-k');
% ylabel('unmber');
% title('链接预测');
% axis([0 110 0 100]);  % 设置坐标轴在指定的区间
% set(gca,'XTickLabel',{'','','top-20','','top-40','','top-60','','top-80','','top-100'})