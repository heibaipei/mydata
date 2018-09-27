addpath('Code\SIMC');
% load('D:\2018-2019-1\2018-8\M\mydata\dr\Cdatasets\DiDrA.txt');
% save('D:\2018-2019-1\2018-8\M\mydata\dr\Cdatasets\DiDrA.mat');
DiDrA = importdata('D:\2018-2019-1\2018-8\M\SIMCLDA-master\Code\DiDrA.mat');
LD = cross(DiDrA);
disease_featrue = importdata('D:\2018-2019-1\2018-8\M\SIMCLDA-master\U_disease_cell.mat');
drug_feature = importdata('D:\2018-2019-1\2018-8\M\SIMCLDA-master\U_drug_cell.mat');

Omega=find(LD==1);   
M_recover=SIMC(LD,Omega,disease_featrue,drug_feature);
save('M_recover.mat','M_recover');
