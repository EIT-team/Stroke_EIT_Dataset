% Make BIDS electrodes file

load('Mesh_example.mat');
%%
% fid=fopen('Electrode_Positions.txt');

A=readtable('Electrode_Positions.txt');

Elec_name = A.EEG10_10Equivalent;

X=Mesh.elec_pos(:,1);
Y=Mesh.elec_pos(:,2);
Z=Mesh.elec_pos(:,3);
