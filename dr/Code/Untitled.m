%% configuration
addpath('SIMC');

%% load data
LD=importdata('../Datasets/Dataset1/interMatrix.mat');
Omega=find(LD==1);
[nl,nd]=size(LD);
aa=sum(LD);
bb=sum(LD,2);
s=find(bb==0);
