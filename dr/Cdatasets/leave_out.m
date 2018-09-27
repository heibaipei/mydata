function [DiDrA] = leave_out(a)
% DiDrA = importdata('D:\2018-2019-1\2018-8\M\mydata\dr\Cdatasets\DiDrA.mat');
[m,n] = size(a);
N = n;
[train,test] = crossvalind('LeaveMOut',N,1);
index_num=find(test==1);
list_d = a(:,index_num);
index_linc = find(list_d==1);
num_index_linc = size(index_linc);
for i=1:num_index_linc
    a(i,:)=0;
end
DiDrA = a;

    


% for i = 1:100
%     
% %     find(DiDrA(test));
% %     sse = sse + sum((yhat - y(test)).^2);
% end
