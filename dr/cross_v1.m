%ten fold cross-validation
%find the 1,then devide into ten groups,choose the one as test,and the last
%to be the train data
function [DiDrA_test,testdata_index,y_test] =cross_v1(DiDrA)
%input: 原始的数据m*n
%output: 把部分数据置零后的矩阵m*n
    addpath('Code\SIMC');
    [m,n] = size(DiDrA);
    disp('now load the data and preccesseed the data*************');
    %disp(c);
    Pint = find(DiDrA==1);
    Pnoint = find(~DiDrA);
    disp(size(Pint));
    [num_Pint,~] = size(Pint);
    [num_Pnoint,~] = size(Pint);
    
    %disp(num_result);
    K = 10;
    pos_Indices = crossvalind('Kfold', num_Pint, K);%正样本
    pno_Indices = crossvalind('Kfold', num_Pnoint, K);%负样本
   S = zeros(m,n);
   testdata_index = [];

%disp(Indices);
for i=1:1
    testdata_pos = Pint(pos_Indices == i);
    testdata_pno = Pnoint(pno_Indices==i);
    testdata_index = [testdata_pos;testdata_pno];
    disp(size(testdata_index));
    [row_test,colum_test] =index2spa(testdata_index,m);    
    S(row_test,colum_test) = DiDrA(row_test,colum_test);  
    test_data  = DiDrA - S;
    y_test = [ones(length(testdata_pos), 1); zeros(length(testdata_pno), 1)];
end
    
    
%     traindata_pos =(pos_Indices==i);
%     traindata_pno = (pno_Indices==i);
%     traindata_index = [pos_Indices;pno_Indices];
%     
%     
%     pos_train(i) = ~test(i);
%     data_train(i) = a_result(train);
%     data_test(i) = a_result(test);
%     DiDrA_temple = reshape(DiDrA',[],1);
%     DiDrA_temple(datatest)=0;
%     DiDrA= reshape(DiDrA_temple,m,n);     
    DiDrA_test = test_data;
    

   
   



