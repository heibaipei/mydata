% SMFLDA: Prediction of lncRNA-disease associations based on inductive matrix completion
%  
%%%%%%%%%%
%   interMatrix.mat: an n*m association matrix between lncRNAs and diseases, n is 
%   the number of lncRNAs, and m is the number of diseases
%   lncSim.mat: an n*n sequence similarity matrix of lncRNAs
%   disSim_Jaccard.mat: an m*m similarity matrix of disease

%% configuration
addpath('Code/SIMC');

%% load data
LD=importdata('../Datasets/Dataset1/interMatrix.mat');
lncSim=importdata('../Datasets/Dataset1/lncSim.mat');    
dissim=importdata('../Datasets/Dataset1/disSim_Jaccard.mat');

%% computing Gaussian interaction profile kernel of lncRNAs

[nl,nd]=size(LD);
[LL,~]=gKernel(nl,nd,LD);  


%% complete interaction information for a new lncRNA
for i=1:nl
    if length(find(LD(i,:)))==0 %�������ÿ��Ϊ1�ĸ���Ϊ��
        rowVec=lncSim(i,:); %���ҵ����ƾ����ж�Ӧ����
        rowVec(i)=0;
        simNeighbors=find(rowVec>=mean(mean(lncSim))); %�ҳ����������Ծ�ֵ����
        if length(simNeighbors)
            new_row=zeros(1,nd);
                for l=1:length(simNeighbors)
                   new_row=new_row+LD(simNeighbors(l),:);       
                end
            new_row=new_row/length(simNeighbors);      
            LD(i,:)=new_row; %LDȡ��Χ�ľ�ֵ      
        end
    end
end

%% extract feature vectors of lncRNAs and diseases
lnc_feature=pca_energy(LL,0.8);
dis_feature=pca_energy(dissim,0.6);

%% using inductive matrix completion to complete the association matrix of lncRNA-disease
Omega=find(LD==1);    
M_recover=SIMC(LD,Omega,lnc_feature,dis_feature);   

