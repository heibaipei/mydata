function [U_disease_cell, U_drug_cell] =cf_features(DiseaseSim,DrugSim,d1,d2)


[m1,n1] = size(DiseaseSim);
[m2,n2] = size(DrugSim);
order = -1;
weights = 0.000001;
A = DiseaseSim;
B = DrugSim;

[U_disease_cell,V_disease_cell] = AROPE(A,d1,order,weights); %%Ãÿ’˜Ã·»°
[U_drug_cell,V_drug_cell] = AROPE(B,d2,order,weights);


