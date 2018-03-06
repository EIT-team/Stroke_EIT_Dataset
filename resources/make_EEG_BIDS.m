% Make BIDS electrodes file

load('Mesh_example.mat');
%%
% fid=fopen('Electrode_Positions.txt');

A=readtable('Electrode_Positions.txt');

Elec_name = A.EEG10_10Equivalent;

X=Mesh.elec_pos(:,1);
Y=Mesh.elec_pos(:,2);
Z=Mesh.elec_pos(:,3);
Elecnum=length(X);

%% write electrodes file
%write each file with its EEG 10-10 equivalent and the coordinates, all
%the electrodes were the same easycap ones.
fid=fopen('_electrodes.tsv','w+');
fprintf(fid,'%s\t%s\t%s\t%s\t%s\t%s\n','Name','X','Y','Z','Type','Material');
for iElec = 1:Elecnum
    fprintf(fid,'%s\t%f\t%f\t%f\t%s\t%s\n',Elec_name{iElec},X(iElec),Y(iElec),Z(iElec),'EasyCap','Ag/AgCl');
end
fclose(fid);
%% write channels file
%write the channels file. All channels were sampled at the maximum sample
%rate of the BioSemi Active Two. All with respect to the CMS common
%electrode

fid=fopen('_channels.tsv','w+');
fprintf(fid,'%s\t%s\t%s\t%s\t%s\n','Channel','Sampling Rate','Low Pass','High Pass','Notes');
for iElec = 1:Elecnum-1
    fprintf(fid,'%d\t%d\t%s\t%s\t%s\n',iElec,16384,'N/A','N/A','');
end
fclose(fid);
